/*
 * json_min.c
 *
 * See json_min.h. The emitter never writes past the buffer; once it
 * overflows it stops appending and latches the flag, so a caller can build
 * a whole document and check once at the end.
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "json_min.h"

/* ------------------------------------------------------------------ */
/* Emit                                                               */
/* ------------------------------------------------------------------ */

void json_init(json_out_t *j, char *buf, size_t cap)
{
    j->buf = buf;
    j->cap = cap;
    j->len = 0;
    j->overflow = false;
    j->last = '\0';
    if (cap > 0) {
        buf[0] = '\0';
    }
}

void json_drain(json_out_t *j)
{
    j->len = 0;
    if (j->cap > 0) {
        j->buf[0] = '\0';
    }
}

static void put(json_out_t *j, const char *s, size_t n)
{
    if (j->overflow || n == 0) {
        return;
    }
    if (j->len + n + 1 > j->cap) {
        j->overflow = true;
        return;
    }
    memcpy(j->buf + j->len, s, n);
    j->len += n;
    j->buf[j->len] = '\0';
    j->last = s[n - 1];
}

void json_raw(json_out_t *j, const char *text)
{
    put(j, text, strlen(text));
}

/* True when the last emitted character can be followed directly by a value. */
static bool needs_comma(const json_out_t *j)
{
    const char c = j->last;
    return c != '\0' && c != '{' && c != '[' && c != ',' && c != ':';
}

void json_sep(json_out_t *j)
{
    if (needs_comma(j)) {
        put(j, ",", 1);
    }
}

/* Emits `"key":` when key is non-NULL, preceded by a comma if needed. */
static void key_prefix(json_out_t *j, const char *key)
{
    json_sep(j);
    if (key != NULL) {
        put(j, "\"", 1);
        put(j, key, strlen(key));
        put(j, "\":", 2);
    }
}

void json_obj_open(json_out_t *j, const char *key)
{
    key_prefix(j, key);
    put(j, "{", 1);
}

void json_obj_close(json_out_t *j)
{
    put(j, "}", 1);
}

void json_arr_open(json_out_t *j, const char *key)
{
    key_prefix(j, key);
    put(j, "[", 1);
}

void json_arr_close(json_out_t *j)
{
    put(j, "]", 1);
}

static void put_escaped(json_out_t *j, const char *s)
{
    put(j, "\"", 1);
    for (; *s != '\0'; s++) {
        const unsigned char c = (unsigned char)*s;
        switch (c) {
        case '"':  put(j, "\\\"", 2); break;
        case '\\': put(j, "\\\\", 2); break;
        case '\n': put(j, "\\n", 2);  break;
        case '\r': put(j, "\\r", 2);  break;
        case '\t': put(j, "\\t", 2);  break;
        default:
            if (c < 0x20) {
                /* Control characters must be escaped; a scanned barcode can
                 * carry a stray one. */
                char esc[7];
                snprintf(esc, sizeof(esc), "\\u%04x", c);
                put(j, esc, strlen(esc));
            } else {
                put(j, (const char *)&c, 1);
            }
            break;
        }
    }
    put(j, "\"", 1);
}

void json_kv_str(json_out_t *j, const char *key, const char *value)
{
    key_prefix(j, key);
    put_escaped(j, value ? value : "");
}

void json_kv_f(json_out_t *j, const char *key, float value, int decimals)
{
    key_prefix(j, key);
    if (isnan(value) || isinf(value)) {
        /*
         * JSON has no NaN. The peak trackers start at +/-infinity, so an
         * untouched counter would otherwise emit an unparseable document.
         */
        put(j, "null", 4);
        return;
    }
    char tmp[32];
    snprintf(tmp, sizeof(tmp), "%.*f", decimals, (double)value);
    put(j, tmp, strlen(tmp));
}

void json_kv_i(json_out_t *j, const char *key, int64_t value)
{
    key_prefix(j, key);
    char tmp[24];
    snprintf(tmp, sizeof(tmp), "%lld", (long long)value);
    put(j, tmp, strlen(tmp));
}

void json_kv_u(json_out_t *j, const char *key, uint32_t value)
{
    key_prefix(j, key);
    char tmp[16];
    snprintf(tmp, sizeof(tmp), "%lu", (unsigned long)value);
    put(j, tmp, strlen(tmp));
}

void json_kv_bool(json_out_t *j, const char *key, bool value)
{
    key_prefix(j, key);
    if (value) {
        put(j, "true", 4);
    } else {
        put(j, "false", 5);
    }
}

/* ------------------------------------------------------------------ */
/* Parse                                                              */
/* ------------------------------------------------------------------ */

/*
 * Finds `"key"` and returns a pointer just past its colon.
 *
 * A plain scan: it does not track nesting, so a matching key inside a nested
 * object would be found too. The request bodies this serves are flat, and
 * every consumer validates the value it gets, so the worst case is a
 * rejected request rather than a misread one.
 */
static const char *find_value(const char *body, size_t len, const char *key)
{
    const size_t klen = strlen(key);
    if (len < klen + 3) {
        return NULL;
    }

    for (size_t i = 0; i + klen + 2 <= len; i++) {
        if (body[i] != '"') {
            continue;
        }
        if (memcmp(body + i + 1, key, klen) != 0) {
            continue;
        }
        if (body[i + 1 + klen] != '"') {
            continue;
        }

        size_t p = i + klen + 2;
        while (p < len && (body[p] == ' ' || body[p] == '\t' ||
                           body[p] == '\n' || body[p] == '\r')) {
            p++;
        }
        if (p < len && body[p] == ':') {
            p++;
            while (p < len && (body[p] == ' ' || body[p] == '\t' ||
                               body[p] == '\n' || body[p] == '\r')) {
                p++;
            }
            return (p < len) ? body + p : NULL;
        }
    }
    return NULL;
}

bool json_get_str(const char *body, size_t len, const char *key,
                  char *out, size_t out_len)
{
    const char *v = find_value(body, len, key);
    if (v == NULL || *v != '"' || out_len == 0) {
        return false;
    }
    v++;

    const char *end = body + len;
    size_t o = 0;
    while (v < end && *v != '"') {
        if (*v == '\\' && v + 1 < end) {
            v++;
            char c;
            switch (*v) {
            case 'n': c = '\n'; break;
            case 'r': c = '\r'; break;
            case 't': c = '\t'; break;
            case 'u':
                /*
                 * \uXXXX is skipped rather than decoded: the fields this
                 * parses are barcodes, SSIDs and model names, which are
                 * ASCII in practice, and a partial UTF-16 decoder would be
                 * more risk than the case is worth.
                 */
                v += 4;
                continue;
            default:  c = *v;   break;
            }
            if (o + 1 >= out_len) {
                break;
            }
            out[o++] = c;
            v++;
            continue;
        }
        if (o + 1 >= out_len) {
            break;
        }
        out[o++] = *v++;
    }
    out[o] = '\0';
    return true;
}

bool json_get_num(const char *body, size_t len, const char *key, double *out)
{
    const char *v = find_value(body, len, key);
    if (v == NULL) {
        return false;
    }
    if (*v != '-' && *v != '+' && *v != '.' && (*v < '0' || *v > '9')) {
        return false;
    }

    /* strtod needs a terminator; copy the token out. */
    char tmp[32];
    size_t n = 0;
    const char *end = body + len;
    while (v < end && n + 1 < sizeof(tmp) &&
           (*v == '-' || *v == '+' || *v == '.' || *v == 'e' || *v == 'E' ||
            (*v >= '0' && *v <= '9'))) {
        tmp[n++] = *v++;
    }
    tmp[n] = '\0';
    if (n == 0) {
        return false;
    }

    char *stop = NULL;
    const double d = strtod(tmp, &stop);
    if (stop == tmp) {
        return false;
    }
    *out = d;
    return true;
}

bool json_get_bool(const char *body, size_t len, const char *key, bool *out)
{
    const char *v = find_value(body, len, key);
    if (v == NULL) {
        return false;
    }
    const size_t left = (size_t)(body + len - v);
    if (left >= 4 && memcmp(v, "true", 4) == 0) {
        *out = true;
        return true;
    }
    if (left >= 5 && memcmp(v, "false", 5) == 0) {
        *out = false;
        return true;
    }
    /* Accept 1/0 too - a form-driven client is likely to send them. */
    if (*v == '1' || *v == '0') {
        *out = (*v == '1');
        return true;
    }
    return false;
}

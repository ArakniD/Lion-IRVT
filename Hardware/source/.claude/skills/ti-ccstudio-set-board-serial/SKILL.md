---
name: ti-ccstudio-set-board-serial
description: Configure a CCXML file to use a specific debug probe serial number when
  multiple boards are connected. Use when the user wants to target a specific board
  in a multi-board setup or when encountering probe selection ambiguity errors during
  debugging or flashing. This skill modifies the project's CCXML file to explicitly
  specify which XDS110 probe to use.
allowed-tools: Bash, Read, Glob, Grep, Edit, AskUserQuestion, mcp__ccs-debug__getConnectedDevices
---

# Configure Board Serial Number in CCXML

Configure a CCS project's CCXML file to use a specific debug probe serial number for multi-board setups.

## Arguments

The user may provide:
- **Project path** — path to the CCS project directory (optional if a CCXML file path is provided directly; otherwise ask if not provided)
- **Serial number** — the XDS110 serial number to configure (optional; will discover and prompt if not provided)
- **CCXML file** — specific CCXML file to modify (optional; will auto-discover from project path if not provided)

## Step 1 — Locate the Project, CCXML File, and Target Device

**Before doing anything else**, output this message to the user exactly as written:

> **Board Configuration Assistant** — I'll help you configure your CCXML file to use a specific
> debug probe. This is useful when you have multiple TI boards connected and want to ensure your
> project always targets the correct one.

If the user provided a specific CCXML file path, use it directly and skip to step 4. Otherwise:

If the user provided a project path, use it. Otherwise use `AskUserQuestion` to ask for it.

Once you have the project path:

1. Use `Glob` to search for `.ccxml` files in the project directory:
   - First check `{project_path}/targetConfigs/*.ccxml`
   - If no files found, search recursively: `{project_path}/**/*.ccxml`

2. If multiple CCXML files are found:
   - Use `AskUserQuestion` to ask which file to configure
   - Present options with relative paths from the project root

3. If no CCXML files are found:
   - Output an error message explaining that no CCXML files were found
   - Ask if the project path is correct or if they need help creating a CCXML file
   - Do not proceed to the next step

4. Read the selected CCXML file to understand its current configuration.

5. **Extract the target device ID** from the CCXML — look for the `<instance>` element inside `<platform>` and read its `id` attribute:
   ```xml
   <platform ...>
       <instance ... id="MSPM0G3507" .../>
   </platform>
   ```
   Store this device ID (e.g. `MSPM0G3507`). You will use it in Step 2 to filter probes.

## Step 2 — Discover Connected Debug Probes

Use the `mcp__ccs-debug__getConnectedDevices` MCP tool to discover all connected debug probes and their serial numbers:

```
mcp__ccs-debug__getConnectedDevices({})
```

**Output format** — an array of probe objects, e.g.:
```json
[
  {"probeId":"0","connection":"TIXDS110_Connection","serialNumber":"M3010001","boardName":"MSPM33C321A LaunchPad™","deviceXml":"MSPM33C321A"},
  {"probeId":"1","connection":"TIXDS110_Connection","serialNumber":"MG350001","boardName":"MSPM0G3507 LaunchPad™","deviceXml":"MSPM0G3507"}
]
```

**After calling the tool**, filter the results by the target device from Step 1:
- Keep only probes whose `deviceXml` matches the target device ID extracted from the CCXML
- These are the **matching probes** — boards of the correct type that are physically connected
- Keep track of both the full probe list and the matching probe list

**Error handling:**
- If the tool returns an empty array or errors:
  - Verify boards are connected and powered
  - Ask user to check hardware connections
  - Offer to continue with manual serial number entry

## Step 3 — Assess the Situation and Select Target Serial Number

Use the matching probe count and total probe count to understand what the user is dealing with and explain it clearly before asking anything.

**If 0 matching probes found (none of the correct device type connected):**
- Tell the user: "I don't see any `{DEVICE}` boards connected right now."
- If other probes were detected, mention what device types those are
- Offer to configure with a manually entered serial number (useful for setting up before hardware arrives)
- Use `AskUserQuestion` to ask if they want to enter a serial number anyway; if no, exit gracefully

**If 1 matching probe found and only 1 probe connected total:**
- Tell the user: "I found one `{DEVICE}` connected (serial: `{SERIAL}`)."
- Explain that with only one probe connected, serial number configuration is optional — CCS will pick it automatically
- Use `AskUserQuestion` to ask if they want to configure it anyway for future-proofing (e.g. in case they add more boards later)
- If yes, use the detected serial; if no, exit gracefully

**If 1 matching probe found but 2+ probes connected total:**
- **This requires configuration.** Tell the user plainly:
  > "You have multiple probes connected. CCS may not automatically select the correct one for this `{DEVICE}` project. I'll configure your CCXML to target the detected `{DEVICE}` (serial: `{SERIAL}`) specifically."
- Proceed to configure using the detected serial — do not ask for confirmation unless the user provided a conflicting serial number in the arguments

**If 2+ matching probes found:**
- **This is the key scenario.** Tell the user plainly:
  > "You have {N} `{DEVICE}` boards connected. CCS can't automatically determine which one to use for this project, so debugging or flashing will fail with a probe selection error. I need to configure your CCXML to target one of them specifically."
- List the matching probes: `[Serial: L40001BC] MSPM0G3507`, `[Serial: M3010001] MSPM0G3507`, …
- Use `AskUserQuestion` to let the user pick which probe to target
- If the user provided a serial number in the arguments, pre-select it and confirm rather than asking

**If the user provided a serial number in the arguments:**
- Check whether it matches one of the matching probes
- If it matches: proceed directly without prompting — no need to ask the user to confirm their own input
- If it doesn't match but matching probes were found: warn the user ("Serial `{GIVEN}` was not detected; connected `{DEVICE}` boards are: {LIST}") but offer to proceed anyway with the given serial
- If no probes at all: accept the provided serial number and proceed

## Step 4 — Determine Current CCXML Configuration

Read and analyze the CCXML file to determine if it already has probe selection properties configured.

**Look for these property IDs in the XML:**
- `SEPK.POD_PORT` — Probe selection choice list
- `SEPK.POD_SERIAL` — Serial number string field
- `Debug Probe Selection` — Alternative probe selection property
- `-- Enter the serial number` — Alternative serial number field

**Three scenarios:**

### Scenario A: No probe selection configured
The CCXML has no probe selection properties. You'll need to insert new XML elements.

### Scenario B: Probe selection configured but different serial number
The CCXML has probe selection properties with a different serial number. You'll need to update the existing values.

### Scenario C: Correct serial number already configured
The CCXML already has the target serial number configured. Inform the user and ask if they want to proceed anyway (in case they want to verify or update the format).

## Step 5 — Modify the CCXML File

Based on the scenario from Step 4, modify the CCXML file to configure the target serial number.

### For Scenario A (Insert new properties):

The CCXML file structure is:
```xml
<configuration>
    <connection>
        [existing properties...]
        <platform>...</platform>
    </connection>
</configuration>
```

**Insert location:** Inside the `<connection>` element, before the `<platform>` element.

**XML to insert:**
```xml
		<property Type="choicelist" Value="1" id="SEPK.POD_PORT">
			<choice Name="Only one XDS110 installed" value="0">
			</choice>
			<choice Name="Select by serial number" value="1">
				<property Type="stringfield" Value="SERIAL_NUMBER_HERE" id="SEPK.POD_SERIAL"/>
			</choice>
		</property>

		<property id="Debug Probe Selection" Type="choicelist" Value="1">
			<choice Name="Select by serial number" value="0">
				<property id="-- Enter the serial number" Type="stringfield" Value="SERIAL_NUMBER_HERE"/>
			</choice>
		</property>
```

**Key details:**
- Use tab indentation (not spaces) to match CCS conventions
- Set both `SEPK.POD_SERIAL` and `-- Enter the serial number` to the same serial number
- Set `Value="1"` in the choicelist properties to select the "by serial number" choice
- The indent level should match the surrounding elements (typically 3 tabs for properties inside connection)

**Implementation:**
Use the `Edit` tool with the `<platform` opening tag as the `old_string` anchor. The `new_string` should be the property XML followed by that same platform opening tag. This inserts the properties immediately before `<platform>` without touching the rest of the file.

### For Scenario B (Update existing values):

Use the Edit tool to replace the existing serial number values with the new target serial number.

**Two locations to update:**
1. The value of the property with `id="SEPK.POD_SERIAL"`:
   - Find: `<property Type="stringfield" Value="OLD_SERIAL" id="SEPK.POD_SERIAL"/>`
   - Replace `OLD_SERIAL` with the new serial number

2. The value of the property with `id="-- Enter the serial number"`:
   - Find: `<property id="-- Enter the serial number" Type="stringfield" Value="OLD_SERIAL"/>`
   - Replace `OLD_SERIAL` with the new serial number

**Also verify and update the choicelist Value attributes:**
- `SEPK.POD_PORT` should have `Value="1"` (selecting "by serial number" choice)
- `Debug Probe Selection` should have `Value="1"` (selecting "by serial number" choice)

**IMPORTANT:** If the existing CCXML has only one of the two property blocks (`SEPK.POD_PORT` but not `Debug Probe Selection`, or vice versa), you MUST add the missing block. Both property blocks are always required for full CCS compatibility. Use Scenario A's XML template to add the missing block if needed.

### For Scenario C (Already configured):

If the user confirmed they want to proceed:
- Follow Scenario B steps to ensure both properties are consistently set
- This handles cases where only one property was set or there's an inconsistency

If the user chose not to proceed:
- Output a confirmation message that the CCXML is already correctly configured
- Exit gracefully

## Step 6 — Verify and Report

After modifying the CCXML file:

1. **Read the modified file** to verify the changes were applied correctly

2. **Verify the following:**
   - **Both** `SEPK.POD_SERIAL` **and** `-- Enter the serial number` contain the target serial number — if either is missing, go back and add it before proceeding
   - The choice list values are set to select "by serial number" mode (`Value="1"` on both `SEPK.POD_PORT` and `Debug Probe Selection`)
   - The XML structure is valid (proper nesting and closing tags)
   - Indentation matches CCS style (tabs, not spaces)

3. **Report to the user:**
   - Show the file path of the modified CCXML file
   - Display the serial number that was configured
   - If multiple properties were updated, mention that both legacy and modern formats were configured for compatibility
   - Explain that the next time they debug or flash this project, CCS will use the specified probe

4. **Optional next steps:**
   - Offer to show the relevant section of the CCXML file if the user wants to verify
   - Suggest testing the configuration by building and loading the project
   - Mention that they can re-run this skill with a different serial number if needed

**Example output message:**

> ✓ **CCXML Configuration Complete**
>
> Modified: `targetConfigs/MSPM0G3507.ccxml`
> Serial number: `L40001BC`
>
> Your project is now configured to use the XDS110 probe with serial number L40001BC.
> When you debug or flash this project, CCS will automatically select this specific board.
>
> Next steps:
> - Test the configuration by building and loading your project
> - If you need to change the serial number, run this skill again

## Error Handling

Throughout the skill, handle common errors gracefully:

- **CCXML not found:** Guide user to check project structure or offer to help create a CCXML file
- **Multiple CCXML files:** Let user choose which one to configure
- **No probes detected:** Offer manual serial number entry
- **Invalid serial number format:** Accept any string but warn if it doesn't match expected format (e.g., `L4xxxxxx`)
- **File write errors:** Check permissions and offer solutions
- **Malformed CCXML:** Detect and report XML parsing issues before attempting modification

## Notes on CCS Integration

- The `SEPK.POD_PORT` property is the legacy format used by older CCS versions
- The `Debug Probe Selection` property is the modern format
- Configuring both ensures compatibility with all CCS versions
- CCS will use whichever property it recognizes first

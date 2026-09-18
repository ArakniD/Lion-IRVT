# Sets up the ESP-IDF v6.1 environment for this project.
#
# The stock export.ps1 does not work here: it resolves `python` from PATH and
# finds the system 3.6 interpreter before the IDF venv. This sets the same
# variables directly, from the paths the editor's ESP-IDF extension is
# configured with (idf.customExtraVars in the CCStudio settings).
#
# Usage:   . .\idf_env.ps1   then   idf.py build

$env:IDF_PATH = "C:\esp\v6.1\esp-idf"
$env:IDF_TOOLS_PATH = "C:\Espressif\tools"
$env:IDF_PYTHON_ENV_PATH = "C:\Espressif\tools\python\v6.1\venv"
$env:IDF_COMPONENT_LOCAL_STORAGE_URL = "file://C:\Espressif\tools"
$env:OPENOCD_SCRIPTS = "C:\Espressif\tools\openocd-esp32\v0.12.0-esp32-20260703\openocd-esp32\share\openocd\scripts"
$env:ESP_ROM_ELF_DIR = "C:\Espressif\tools\esp-rom-elfs\20241011\"
# idf_component_manager reads this and crashes on None; export.ps1 would
# normally set it.
$env:ESP_IDF_VERSION = "6.1"

$env:PATH = @(
    "C:\Espressif\tools\python\v6.1\venv\Scripts"
    "C:\Espressif\tools\cmake\4.0.3\bin"
    "C:\Espressif\tools\ninja\1.12.1"
    "C:\Espressif\tools\ccache\4.12.1\ccache-4.12.1-windows-x86_64"
    "C:\Espressif\tools\xtensa-esp-elf\esp-15.2.0_20251204\xtensa-esp-elf\bin"
    "C:\Espressif\tools\xtensa-esp-elf-gdb\17.1_20260402\xtensa-esp-elf-gdb\bin"
    "C:\Espressif\tools\esp-rom-elfs\20241011"
    "C:\Espressif\tools\openocd-esp32\v0.12.0-esp32-20260703\openocd-esp32\bin"
    "C:\Program Files\Git\cmd"
    $env:PATH
) -join ";"

function idf.py { python "$env:IDF_PATH\tools\idf.py" @args }

Write-Host "ESP-IDF v6.1 environment ready. Target: esp32. Port: COM6."

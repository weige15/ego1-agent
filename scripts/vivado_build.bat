@echo off

cd /d "%~dp0.."

echo ==========================================
echo Starting Vivado 2025.2
echo ==========================================

"C:\AMDDesignTools\2025.2\Vivado\bin\vivado.bat" ^
    -mode batch ^
    -source scripts\build.tcl ^
    -log build\vivado.log ^
    -journal build\vivado.jou

if errorlevel 1 (
    echo.
    echo VIVADO BUILD FAILED
    exit /b 1
)

echo.
echo VIVADO BUILD SUCCESS
exit /b 0

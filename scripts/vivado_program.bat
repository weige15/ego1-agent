@echo off

cd /d "%~dp0.."

echo ==========================================
echo Programming EGO1
echo ==========================================

"C:\AMDDesignTools\2025.2\Vivado\bin\vivado.bat" ^
    -mode batch ^
    -source scripts\program.tcl ^
    -log build\program.log ^
    -journal build\program.jou

if errorlevel 1 (
    echo.
    echo FPGA PROGRAM FAILED
    exit /b 1
)

echo.
echo FPGA PROGRAM SUCCESS
exit /b 0

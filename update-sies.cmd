@echo off
setlocal ENABLEEXTENSIONS

REM Step prompts
echo IMPORTANT: Remember to get an updated "alumnosMatriculados.xls" from SIES before proceeding.
pause

REM Run roster update
java -jar sies2csv.jar
if errorlevel 1 (
    echo sies2csv failed with exit code 1. Stopping.
    exit /b 1
)

REM CSV file generated from Excel file. Review it before proceeding.
echo "CSV file generated from Excel file. Review it before proceeding with the roster update."
choice /C YN /M "Have you already reviewed the CSV file and want to continue with the roster update?"
if errorlevel 2 (
    echo User chose not to continue.
    exit /b 0
)

REM CSV file generated from Excel file. Review it before proceeding.
java -jar roster50.jar

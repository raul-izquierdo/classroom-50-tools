@echo off

set "jars=roster50.jar teams50.jar solutions50.jar sies2csv.jar"

echo Current versions (before the updates):
for %%j in (%jars%) do call :show_version %%j

rem Use -f to fail on HTTP >= 400, -S to show errors, -L to follow redirects
for %%j in (%jars%) do (
	call :download_jar %%j
	if errorlevel 1 exit /b 1
)

echo.
echo Current versions (after the updates):
for %%j in (%jars%) do call :show_version %%j

exit /b 0

:show_version
if not exist "%~1" (
	echo %~1: jar file is missing
	goto :eof
)
<nul set /p "=%~1: "
java -jar "%~1" -V
goto :eof

:download_jar
set "url=https://github.com/raul-izquierdo/%~n1/releases/latest/download/%~1"
echo.
echo Downloading %~1 from %url%
curl -fS -L -o "%~1" "%url%"
if errorlevel 1 (
	echo ERROR: Failed to download %~1
	if exist "%~1" del /q "%~1"
	exit /b 1
)
goto :eof

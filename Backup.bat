@echo off
echo ====================================================
echo             POWER APPS AUTO-BACKUP SCRIPT
echo ====================================================
echo.

echo [1/4] Selecting Power Platform Profile...
pac auth select --name MySchoolEnv
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Could not select auth profile. 
    echo Please run 'pac auth list' to check your connection.
    goto error
)
echo.

echo [2/4] Exporting solution from Power Apps...
pac solution export --name "FloorAutomationSystemGF" --path "temp_solution.zip" --managed false
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Failed to export solution. 
    echo Verify the solution name matches exactly in the Maker portal.
    goto error
)
echo.

echo [3/4] Unpacking solution into source code...
:: --allowDelete ensures files you deleted in Power Apps are also removed locally
pac solution unpack --zipfile "temp_solution.zip" --folder "./src" --allowDelete
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Failed to unpack the solution zip file.
    goto error
)
echo.

echo [4/4] Cleaning up temporary zip file...
if exist temp_solution.zip del temp_solution.zip
echo.

echo ====================================================
echo  SUCCESS! Your app source code is updated in ./src
echo  Open VS Code to stage, commit, and push to GitHub.
echo ====================================================
pause
exit /b

:error
if exist temp_solution.zip del temp_solution.zip
echo ====================================================
echo  BACKUP FAILED. Review the errors above.
echo ====================================================
pause
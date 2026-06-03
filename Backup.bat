@echo off
echo Selecting Power Platform account...
pac auth select --name MySchoolEnv

echo Exporting solution from Power Apps...
pac solution export --name "FloorAutomationSystemGF" --path "solution.zip" --managed false

echo Unpacking solution into source files...
pac solution unpack --zipfile "solution.zip" --folder "./src"

echo Cleaning up zip file...
if exist solution.zip del solution.zip

echo Done! Ready to commit to GitHub.
pause
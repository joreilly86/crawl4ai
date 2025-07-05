@echo off
echo Setting up VS Code integration for Engineering Crawler...

if not exist ".vscode" (
    echo Creating .vscode directory...
    mkdir .vscode
)

echo Creating VS Code task configuration...
(
echo {
echo     "version": "2.0.0",
echo     "tasks": [
echo         {
echo             "label": "Run Engineering Crawler",
echo             "type": "shell",
echo             "command": ".\\\\run_engcrawl.bat",
echo             "group": "build",
echo             "presentation": {
echo                 "echo": true,
echo                 "reveal": "always",
echo                 "focus": true,
echo                 "panel": "new"
echo             },
echo             "problemMatcher": []
echo         }
echo     ]
echo }
) > .vscode\tasks.json

echo.
echo ✓ VS Code integration configured!
echo.
echo How to use:
echo   1. Open this project in VS Code: code .
echo   2. Press Ctrl+Shift+P
echo   3. Type "Tasks: Run Task"
echo   4. Select "Run Engineering Crawler"
echo.
echo Enjoy your streamlined workflow!
echo.
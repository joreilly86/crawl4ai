@echo off
echo Setting up Engineering Crawler with UV...

REM Create UV project if it doesn't exist
if not exist "pyproject.toml" (
    echo Creating UV project...
    uv init --name engcrawl --python 3.11
)

REM Install crawl4ai and dependencies
echo Installing dependencies...
uv add crawl4ai pyyaml

REM Install Playwright browsers
echo Installing Playwright browsers...
uv run playwright install

REM Optional: Install Google AI SDK for Gemini cleanup
echo.
set /p install_gemini=Install Google AI SDK for AI cleanup features? [y/N]: 
if /i "%install_gemini%"=="y" (
    echo Installing Google AI SDK...
    uv add google-generativeai
    echo Google AI SDK installed! Set GEMINI_API_KEY to use AI cleanup.
) else (
    echo Skipping Google AI SDK installation.
)

REM Create a simple requirements file for reference
echo crawl4ai>requirements.txt
echo pyyaml>>requirements.txt
if /i "%install_gemini%"=="y" echo google-generativeai>>requirements.txt

echo.
echo Setup complete! Use 'run_engcrawl.bat' to run the tool.
echo.
@echo off
REM Auto-activate UV environment and run engcrawl
echo Starting Engineering Crawler...
set UV_NO_SYNC=1
uv run --quiet python engcrawl %*
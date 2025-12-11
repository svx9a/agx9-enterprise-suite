@echo off
echo ========================================
echo    ASI:One Phoenix SE2 AI Engine
echo ========================================

REM Set Python path if needed
set PYTHONPATH=%cd%

REM Check for main entry points
if exist "main.py" (
    echo Starting from main.py...
    python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
) else if exist "app.py" (
    echo Starting from app.py...
    python -m uvicorn app:app --reload --host 0.0.0.0 --port 8000
) else if exist "api\app.py" (
    echo Starting from api/app.py...
    python -m uvicorn api.app:app --reload --host 0.0.0.0 --port 8000
) else (
    echo ERROR: Could not find ASI:One entry point!
    echo Looking for Python files...
    dir /b *.py
    pause
)

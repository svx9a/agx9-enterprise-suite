# ASI:One Phoenix SE2 - AI Engine
# Advanced AI backend for AGX9 Enterprise Suite

## Quick Start
1. Install Python 3.8+
2. Run: `pip install -r requirements.txt`
3. Start: `python -m uvicorn main:app --reload --port 8000`

## API Endpoints
- `GET /` - Status
- `GET /health` - Health check
- `POST /engine/run` - Main AI processing
- `GET /docs` - Interactive API documentation

## Integration
Frontend connects to: `http://localhost:8000/engine/run`

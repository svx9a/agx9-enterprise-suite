# AGX9 Enterprise Suite 🚀

![AGX9 Logo](https://img.shields.io/badge/AGX9-Enterprise%20Suite-blue)
![Version](https://img.shields.io/badge/version-1.0.0-green)
![License](https://img.shields.io/badge/license-MIT-yellow)

A comprehensive AI-powered enterprise dashboard with ASI:One Phoenix SE2 integration.

## ✨ Features

- **🤖 AI-Powered Chat** - Integrated with ASI:One Phoenix SE2
- **📊 Real-time Dashboard** - Portfolio, Security, SEO analytics
- **🎤 Voice Controls** - Speech recognition & synthesis
- **🔒 Multi-suite Support** - Real estate, security, SEO modules
- **⚡ Fast Performance** - React + FastAPI + Node.js stack
- **🌐 Real-time Updates** - Live data streaming
- **🔐 Security First** - Built-in threat detection
- **📱 Responsive Design** - Works on all devices

## 🏗️ Architecture

```
agx9-enterprise-suite/
├── frontend/          # React dashboard (Port 5173)
│   ├── src/          # React components
│   ├── public/       # Static assets
│   └── package.json  # Frontend dependencies
├── backend/          # Node.js server (Port 5000)
│   ├── src/          # Server code
│   └── package.json  # Backend dependencies
├── asi_one/          # ASI:One AI engine (Port 8000)
│   ├── main.py       # FastAPI application
│   └── requirements.txt # Python dependencies
├── docs/             # Documentation
├── scripts/          # Deployment scripts
├── docker-compose.yml # Docker orchestration
└── package.json      # Monorepo management
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Python 3.11+
- Git
- npm or yarn

### 1. Clone & Install
```bash
git clone https://github.com/svx9a/agx9-enterprise-suite.git
cd agx9-enterprise-suite
npm run install:all
```

### 2. Start Development
```bash
npm run dev
```
This starts all three services concurrently:
- Frontend: http://localhost:5173
- Backend: http://localhost:5000
- ASI:One: http://localhost:8000

### 3. Production Build
```bash
npm run build
npm start
```

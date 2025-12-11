# reset_and_fix.ps1
Write-Host "🔄 Resetting AGX9 Project with Tailwind CSS v3..." -ForegroundColor Cyan

cd "C:\Users\User\Downloads\agx_bundle\automatic-thai (1)"

# Clean up
Remove-Item node_modules -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item dist -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item *.log -ErrorAction SilentlyContinue
Remove-Item src -Recurse -Force -ErrorAction SilentlyContinue

# Create structure
New-Item -ItemType Directory -Force -Path "src"

# 1. Create index.html
@'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AGX9 Enterprise</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/index.jsx"></script>
  </body>
</html>
'@ | Set-Content index.html

# 2. Create vite.config.js
@'
import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    open: true,
    host: true
  },
  build: {
    outDir: "dist",
    sourcemap: true
  }
})
'@ | Set-Content vite.config.js

# 3. Create package.json with Tailwind CSS v3
@'
{
  "name": "agx9-enterprise",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "lucide-react": "^0.344.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.0.0",
    "autoprefixer": "^10.4.16",
    "postcss": "^8.4.32",
    "tailwindcss": "^3.3.0",
    "vite": "^5.0.0"
  }
}
'@ | Set-Content package.json

# 4. Create src/index.jsx
@'
import React from "react"
import ReactDOM from "react-dom/client"
import App from "./App.jsx"
import "./index.css"

const root = ReactDOM.createRoot(document.getElementById("root"))
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
'@ | Set-Content src/index.jsx

# 5. Create src/index.css
@'
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f5f9;
}

::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}

/* Smooth transitions */
* {
  transition: background-color 0.2s ease, border-color 0.2s ease;
}

/* Font import */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Orbitron:wght@900&display=swap');

body {
  font-family: 'Inter', sans-serif;
}
'@ | Set-Content src/index.css

# 6. Create tailwind.config.js (v3)
@'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        brand: "#007A5E",
      },
      fontFamily: {
        'orbitron': ['Orbitron', 'sans-serif'],
      }
    },
  },
  plugins: [],
}
'@ | Set-Content tailwind.config.js

# 7. Create postcss.config.js (v3)
@'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
'@ | Set-Content postcss.config.js

# 8. Create the FULL App.jsx (same as before, but with font-family fix)
@'
import React, { useState, useEffect, useRef } from 'react';
import { 
  LayoutDashboard, 
  Search, 
  Activity, 
  Terminal, 
  Send, 
  Cpu, 
  Zap, 
  Menu, 
  X, 
  ArrowUpRight, 
  ArrowDownRight, 
  RefreshCw, 
  MoreVertical, 
  MessageSquare, 
  Shield, 
  Home, 
  Building, 
  Users, 
  ShoppingBag, 
  Tag, 
  CreditCard, 
  Briefcase, 
  ChevronDown, 
  Layers, 
  Globe, 
  Server, 
  BarChart3, 
  Globe2, 
  Play, 
  CheckCircle2, 
  Languages, 
  MapPin,
  Bell,
  Settings,
  FileText,
  PieChart,
  HelpCircle,
  Filter,
  Download,
  Linkedin,
  Twitter,
  Facebook
} from 'lucide-react';

// --- Theme Constants (Enterprise: Satin Green & Slate) ---
const THEME = {
  bg: 'bg-slate-50', 
  bgSurface: 'bg-white',
  border: 'border-slate-200',
  textMain: 'text-slate-900',
  textSec: 'text-slate-500',
  brand: 'text-[#007A5E]',
  brandBg: 'bg-[#007A5E]',
  brandBorder: 'border-[#007A5E]',
  activeItem: 'bg-[#007A5E]/5 text-[#007A5E]',
  hoverItem: 'hover:bg-slate-50',
};

// --- Custom Brand Logo (Orbitron) ---
const AgxLogo = ({ className }) => (
  <svg 
    viewBox="0 0 400 400" 
    xmlns="http://www.w3.org/2000/svg" 
    className={className}
  >
    <text 
      x="50%" 
      y="55%" 
      fontFamily="Orbitron, sans-serif" 
      fontSize="110" 
      fontWeight="900" 
      fill="currentColor" 
      textAnchor="middle" 
      dominantBaseline="middle"
      letterSpacing="-0.02em"
    >
      AGX9
    </text>
  </svg>
);

// --- Configurations ---
const SUITES = {
  real_estate: {
    id: 'real_estate',
    name: 'Estate OS',
    nameTH: 'จัดการอสังหาฯ',
    icon: <Building size={16} />,
    color: 'text-[#007A5E]', 
    stats: [
      { title: 'Total Portfolio Value', value: '$142.5M', change: '+2.4%', trend: 'up' },
      { title: 'Active Listings', value: '1,248', change: '+12%', trend: 'up' },
      { title: 'Occupancy Rate', value: '94.2%', change: '-0.8%', trend: 'down' },
      { title: 'Pending Leases', value: '38', change: 'Stable', trend: 'flat' }
    ],
    tableData: [
      { id: 'L-1024', name: 'Skyline Tower Unit 4B', type: 'Residential', status: 'Active', price: '$1.2M', date: 'Oct 24, 2024' },
      { id: 'L-1025', name: 'Grand Avenue Retail', type: 'Commercial', status: 'Pending', price: '$4.5M', date: 'Oct 23, 2024' },
      { id: 'L-1026', name: 'Sunset Villa', type: 'Residential', status: 'Sold', price: '$850K', date: 'Oct 22, 2024' },
      { id: 'L-1027', name: 'Tech Hub Office', type: 'Commercial', status: 'Active', price: '$2.1M', date: 'Oct 21, 2024' },
      { id: 'L-1028', name: 'Lakeside Plot 4', type: 'Land', status: 'Review', price: '$320K', date: 'Oct 20, 2024' },
    ]
  },
  seo: {
    id: 'seo',
    name: 'SEO Worker',
    nameTH: 'ระบบวิเคราะห์ SEO',
    icon: <Globe size={16} />,
    color: 'text-blue-700', 
    stats: [
      { title: 'Global Requests', value: '42.8M', change: '+18%', trend: 'up' },
      { title: 'Avg. Latency', value: '24ms', change: '-4%', trend: 'up' },
      { title: 'Index Coverage', value: '99.9%', change: 'Stable', trend: 'flat' },
      { title: 'Bot Traffic', value: '14.2%', change: '+2%', trend: 'down' }
    ],
    tableData: [
      { id: 'J-8842', name: 'Daily Site Audit', type: 'Scheduled', status: 'Completed', price: 'N/A', date: '10:00 AM' },
      { id: 'J-8843', name: 'Keyword Gap Analysis', type: 'On-Demand', status: 'Processing', price: 'N/A', date: '10:15 AM' },
      { id: 'J-8844', name: 'Backlink Monitor', type: 'Scheduled', status: 'Completed', price: 'N/A', date: '09:00 AM' },
    ]
  }
};

// --- Shared Components ---
const Sparkline = ({ data, color }) => {
  const points = data.map((val, i) => {
    const x = (i / (data.length - 1)) * 100;
    const y = 100 - val; 
    return `${x},${y}`;
  }).join(' ');

  return (
    <svg viewBox="0 0 100 100" className="w-full h-full overflow-visible">
      <defs>
        <linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">
          <stop offset="0%" stopColor={color} stopOpacity="0.1" />
          <stop offset="100%" stopColor={color} stopOpacity="0" />
        </linearGradient>
      </defs>
      <polyline
        fill="none"
        stroke={color} 
        strokeWidth="1.5"
        points={points}
        vectorEffect="non-scaling-stroke"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <polygon 
        points={`0,100 ${points} 100,100`} 
        fill="url(#gradient)" 
      />
    </svg>
  );
};

const EnterpriseMetric = ({ title, value, change, trend }) => (
  <div className="bg-white p-5 rounded-md border border-slate-200 shadow-sm flex flex-col justify-between h-32 hover:border-[#007A5E]/30 transition-colors">
    <div className="flex justify-between items-start">
      <span className="text-xs font-semibold text-slate-500 uppercase tracking-wide">{title}</span>
      {trend !== 'flat' && (
        <span className={`flex items-center text-xs font-medium px-1.5 py-0.5 rounded ${trend === 'up' ? 'bg-emerald-50 text-emerald-700' : 'bg-red-50 text-red-700'}`}>
          {trend === 'up' ? <ArrowUpRight size={12} className="mr-1" /> : <ArrowDownRight size={12} className="mr-1" />}
          {change}
        </span>
      )}
      {trend === 'flat' && (
        <span className="text-xs font-medium text-slate-400 bg-slate-50 px-1.5 py-0.5 rounded">
          {change}
        </span>
      )}
    </div>
    <div>
      <div className="text-2xl font-bold text-slate-900 tracking-tight">{value}</div>
      <div className="text-xs text-slate-400 mt-1">vs. previous 30 days</div>
    </div>
  </div>
);

// --- LANDING PAGE (Enterprise B2B) ---
const LandingPage = ({ onEnter }) => {
  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <nav className="border-b border-slate-200 bg-white sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 text-[#007A5E]">
              <AgxLogo />
            </div>
            <span className="font-bold text-lg tracking-tight text-slate-900">AGX9 <span className="text-slate-400 font-normal">ENTERPRISE</span></span>
          </div>
          <div className="hidden md:flex items-center gap-8 text-sm font-medium text-slate-600">
            <a href="#" className="hover:text-[#007A5E]">Solutions</a>
            <a href="#" className="hover:text-[#007A5E]">Platform</a>
            <a href="#" className="hover:text-[#007A5E]">Developers</a>
            <a href="#" className="hover:text-[#007A5E]">Pricing</a>
          </div>
          <div className="flex items-center gap-4">
            <button className="text-sm font-medium text-slate-600 hover:text-slate-900">Sign In</button>
            <button 
              onClick={onEnter}
              className="bg-[#007A5E] text-white px-4 py-2 rounded-md text-sm font-semibold hover:bg-[#00634B] transition-colors shadow-sm"
            >
              Launch Console
            </button>
          </div>
        </div>
      </nav>

      <div className="max-w-7xl mx-auto px-6 py-20 flex flex-col md:flex-row items-center gap-16">
        <div className="flex-1 space-y-8">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-bold border border-blue-100">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-blue-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-blue-500"></span>
            </span>
            v4.2 SYSTEM UPDATE LIVE
          </div>
          <h1 className="text-5xl md:text-6xl font-bold tracking-tight text-slate-900 leading-[1.1]">
            The Operating System for <span className="text-[#007A5E]">Global Assets</span>
          </h1>
          <p className="text-lg text-slate-600 max-w-xl leading-relaxed">
            Unify your real estate portfolio, automate SEO infrastructure, and govern autonomous agents from a single, secure enterprise console.
          </p>
          <div className="flex items-center gap-4">
            <button 
              onClick={onEnter}
              className="flex items-center gap-2 bg-[#007A5E] text-white px-6 py-3 rounded-md font-semibold hover:bg-[#00634B] shadow-sm transition-all hover:translate-y-[-1px]"
            >
              Start Free Trial <ArrowUpRight size={18} />
            </button>
            <button className="px-6 py-3 rounded-md font-semibold text-slate-600 hover:bg-slate-100 border border-slate-200 bg-white">
              Contact Sales
            </button>
          </div>
          <div className="pt-8 border-t border-slate-200">
            <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-4">Trusted by Market Leaders</p>
            <div className="flex gap-8 opacity-60 grayscale">
              <div className="h-6 w-24 bg-slate-300 rounded"></div>
              <div className="h-6 w-24 bg-slate-300 rounded"></div>
              <div className="h-6 w-24 bg-slate-300 rounded"></div>
              <div className="h-6 w-24 bg-slate-300 rounded"></div>
            </div>
          </div>
        </div>
        <div className="flex-1 w-full relative">
          <div className="relative rounded-lg overflow-hidden shadow-2xl border border-slate-200 bg-white">
            <div className="absolute top-0 w-full h-8 bg-slate-50 border-b border-slate-200 flex items-center px-4 gap-2">
               <div className="w-3 h-3 rounded-full bg-red-400"></div>
               <div className="w-3 h-3 rounded-full bg-yellow-400"></div>
               <div className="w-3 h-3 rounded-full bg-green-400"></div>
            </div>
            <div className="p-10 text-center mt-8 text-slate-400">
              Interactive Dashboard Preview
            </div>
          </div>
        </div>
      </div>

      {/* Global Asset Gallery Section */}
      <div className="bg-white border-t border-slate-200 py-20 px-6">
        <div className="max-w-7xl mx-auto">
           <div className="flex justify-between items-end mb-10">
              <div>
                <h2 className="text-3xl font-bold text-slate-900 mb-2">Global Asset Infrastructure</h2>
                <p className="text-slate-500">Managing premium properties across 12 countries.</p>
              </div>
              <button className="text-[#007A5E] font-semibold flex items-center gap-1 hover:gap-2 transition-all">
                View Full Portfolio <ArrowUpRight size={16} />
              </button>
           </div>
           
           <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="group relative rounded-lg overflow-hidden h-80 shadow-md bg-slate-100 flex items-center justify-center">
                 <div className="text-slate-400">Corporate HQ Image</div>
                 <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-6">
                    <p className="text-emerald-400 text-xs font-bold uppercase mb-1">Commercial</p>
                    <h3 className="text-white font-bold text-xl">Singapore Financial Tower</h3>
                    <p className="text-slate-300 text-sm">98% Occupancy • AAA Grade</p>
                 </div>
              </div>
              <div className="group relative rounded-lg overflow-hidden h-80 shadow-md bg-slate-100 flex items-center justify-center">
                 <div className="text-slate-400">Luxury Residential Image</div>
                 <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-6">
                    <p className="text-emerald-400 text-xs font-bold uppercase mb-1">Residential</p>
                    <h3 className="text-white font-bold text-xl">The Azure, Tokyo</h3>
                    <p className="text-slate-300 text-sm">342 Units • Sold Out</p>
                 </div>
              </div>
              <div className="group relative rounded-lg overflow-hidden h-80 shadow-md bg-slate-100 flex items-center justify-center">
                 <div className="text-slate-400">Data Center Image</div>
                 <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-6">
                    <p className="text-emerald-400 text-xs font-bold uppercase mb-1">Industrial</p>
                    <h3 className="text-white font-bold text-xl">Data Center SG-1</h3>
                    <p className="text-slate-300 text-sm">Tier IV • 50MW Capacity</p>
                 </div>
              </div>
           </div>
        </div>
      </div>

      {/* Enterprise Footer */}
      <footer className="bg-slate-900 text-slate-400 py-16 px-6 border-t border-slate-800">
        <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-12">
           <div className="space-y-4">
              <div className="w-8 h-8 text-white">
                 <AgxLogo />
              </div>
              <p className="text-sm leading-relaxed text-slate-500">
                 AGX9 provides the foundational operating system for autonomous enterprise asset management.
              </p>
              <div className="flex gap-4">
                 <Linkedin size={20} className="hover:text-white cursor-pointer" />
                 <Twitter size={20} className="hover:text-white cursor-pointer" />
                 <Facebook size={20} className="hover:text-white cursor-pointer" />
              </div>
           </div>
           
           <div>
              <h4 className="text-white font-bold mb-4">Platform</h4>
              <ul className="space-y-2 text-sm">
                 <li className="hover:text-white cursor-pointer">Estate OS</li>
                 <li className="hover:text-white cursor-pointer">SEO Worker</li>
                 <li className="hover:text-white cursor-pointer">Market Intelligence</li>
                 <li className="hover:text-white cursor-pointer">API Documentation</li>
              </ul>
           </div>

           <div>
              <h4 className="text-white font-bold mb-4">Company</h4>
              <ul className="space-y-2 text-sm">
                 <li className="hover:text-white cursor-pointer">About AGX9</li>
                 <li className="hover:text-white cursor-pointer">Careers</li>
                 <li className="hover:text-white cursor-pointer">Legal & Compliance</li>
                 <li className="hover:text-white cursor-pointer">Contact</li>
              </ul>
           </div>

           <div>
              <h4 className="text-white font-bold mb-4">System Status</h4>
              <div className="flex items-center gap-2 mb-2">
                 <div className="w-2 h-2 rounded-full bg-emerald-500"></div>
                 <span className="text-sm text-emerald-500 font-medium">All Systems Operational</span>
              </div>
              <p className="text-xs text-slate-600 mb-4">Last updated: 2 mins ago</p>
              
              <div className="flex gap-2">
                 <div className="px-2 py-1 bg-slate-800 rounded border border-slate-700 text-[10px] font-mono">SOC2 Type II</div>
                 <div className="px-2 py-1 bg-slate-800 rounded border border-slate-700 text-[10px] font-mono">GDPR Ready</div>
              </div>
           </div>
        </div>
        <div className="max-w-7xl mx-auto mt-16 pt-8 border-t border-slate-800 flex flex-col md:flex-row justify-between items-center text-xs text-slate-600">
           <p>© 2024 AGX9 Enterprise Systems. All rights reserved.</p>
           <div className="flex gap-6 mt-4 md:mt-0">
              <span className="hover:text-slate-400 cursor-pointer">Privacy Policy</span>
              <span className="hover:text-slate-400 cursor-pointer">Terms of Service</span>
              <span className="hover:text-slate-400 cursor-pointer">SLA</span>
           </div>
        </div>
      </footer>
    </div>
  );
};

// --- ENTERPRISE DASHBOARD ---
const Dashboard = ({ onLogout }) => {
  const [activeTab, setActiveTab] = useState('overview');
  const [suiteId, setSuiteId] = useState('real_estate');
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [input, setInput] = useState('');
  const [messages, setMessages] = useState([
    { id: 1, sender: 'ai', text: `AGX9 Enterprise Kernel loaded. Awaiting instructions.` }
  ]);
  const chatRef = useRef(null);

  const suite = SUITES[suiteId];

  useEffect(() => {
    chatRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const handleCommand = (text = input) => {
    if (!text.trim()) return;
    setMessages(prev => [...prev, { id: Date.now(), sender: 'user', text }]);
    setInput('');
    setTimeout(() => {
      setMessages(prev => [...prev, { id: Date.now()+1, sender: 'ai', text: `Processing command: ${text}...` }]);
    }, 600);
  };

  return (
    <div className="flex h-screen bg-slate-50 overflow-hidden selection:bg-[#007A5E]/20 selection:text-[#007A5E]">
      
      {/* 1. SIDEBAR (Collapsible, Structured) */}
      <aside className={`flex flex-col bg-white border-r border-slate-200 transition-all duration-300 ${sidebarOpen ? 'w-64' : 'w-16'}`}>
        <div className="h-16 flex items-center justify-between px-4 border-b border-slate-200">
          <div className={`flex items-center gap-3 ${!sidebarOpen && 'justify-center w-full'}`}>
             <div className="w-8 h-8 text-[#007A5E] flex-shrink-0">
               <AgxLogo />
             </div>
             {sidebarOpen && <span className="font-bold text-lg tracking-tight">AGX9</span>}
          </div>
          {sidebarOpen && (
            <button onClick={() => setSidebarOpen(false)} className="text-slate-400 hover:text-slate-600">
              <ArrowDownRight className="rotate-90" size={18} />
            </button>
          )}
        </div>

        <div className="flex-1 overflow-y-auto py-4">
          <div className="px-3 mb-2">
            {sidebarOpen && <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-2 px-2">Platform</p>}
            <SidebarItem icon={<LayoutDashboard size={20} />} label="Overview" active={activeTab === 'overview'} expanded={sidebarOpen} onClick={() => setActiveTab('overview')} />
            <SidebarItem icon={<Globe size={20} />} label="Global Map" active={activeTab === 'map'} expanded={sidebarOpen} onClick={() => setActiveTab('map')} />
            <SidebarItem icon={<Layers size={20} />} label="Assets" active={activeTab === 'assets'} expanded={sidebarOpen} onClick={() => setActiveTab('assets')} />
          </div>

          <div className="px-3 mb-2">
             {sidebarOpen && <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-2 px-2 mt-4">Intelligence</p>}
            <SidebarItem icon={<Cpu size={20} />} label="AI Agents" active={activeTab === 'ai'} expanded={sidebarOpen} onClick={() => setActiveTab('ai')} />
            <SidebarItem icon={<BarChart3 size={20} />} label="Analytics" active={activeTab === 'analytics'} expanded={sidebarOpen} onClick={() => setActiveTab('analytics')} />
            <SidebarItem icon={<FileText size={20} />} label="Reports" active={activeTab === 'reports'} expanded={sidebarOpen} onClick={() => setActiveTab('reports')} />
          </div>

           <div className="px-3 mb-2">
             {sidebarOpen && <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-2 px-2 mt-4">System</p>}
            <SidebarItem icon={<Settings size={20} />} label="Configuration" active={activeTab === 'settings'} expanded={sidebarOpen} onClick={() => setActiveTab('settings')} />
            <SidebarItem icon={<Shield size={20} />} label="Security" active={activeTab === 'security'} expanded={sidebarOpen} onClick={() => setActiveTab('security')} />
          </div>
        </div>

        <div className="p-4 border-t border-slate-200">
          <button 
             onClick={() => setSidebarOpen(!sidebarOpen)}
             className={`flex items-center gap-3 w-full p-2 rounded-md hover:bg-slate-50 transition-colors ${!sidebarOpen && 'justify-center'}`}
          >
             <div className="w-8 h-8 rounded-full bg-[#007A5E] text-white flex items-center justify-center font-bold text-xs">
               JD
             </div>
             {sidebarOpen && (
               <div className="text-left">
                 <p className="text-sm font-semibold text-slate-700">John Doe</p>
                 <p className="text-xs text-slate-500">Enterprise Admin</p>
               </div>
             )}
          </button>
        </div>
      </aside>

      {/* 2. MAIN CONTENT AREA */}
      <main className="flex-1 flex flex-col min-w-0">
        
        {/* Top Navbar */}
        <header className="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-6 sticky top-0 z-10">
          
          {/* Context Switcher & Breadcrumbs */}
          <div className="flex items-center gap-4">
             {!sidebarOpen && (
                <button onClick={() => setSidebarOpen(true)} className="mr-2 text-slate-400 hover:text-slate-600">
                  <Menu size={20} />
                </button>
             )}
             <div className="flex items-center gap-2 text-sm text-slate-500">
                <span className="hover:text-slate-800 cursor-pointer">Platform</span>
                <span className="text-slate-300">/</span>
                <span className="font-semibold text-slate-900 flex items-center gap-2 cursor-pointer hover:bg-slate-50 px-2 py-1 rounded">
                   {suite.name} <ChevronDown size={14} />
                </span>
             </div>
          </div>

          {/* Global Search */}
          <div className="flex-1 max-w-xl mx-8 relative hidden md:block">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={16} />
            <input 
              type="text" 
              placeholder="Search assets, leases, or commands (Press '/')" 
              className="w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-200 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-[#007A5E]/20 focus:border-[#007A5E] transition-all"
            />
          </div>

          {/* Actions */}
          <div className="flex items-center gap-4">
            <button className="text-slate-400 hover:text-slate-600 relative">
              <Bell size={20} />
              <span className="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full border-2 border-white"></span>
            </button>
            <button className="text-slate-400 hover:text-slate-600">
              <HelpCircle size={20} />
            </button>
            <button onClick={onLogout} className="text-slate-400 hover:text-red-600">
              <X size={20} />
            </button>
          </div>
        </header>

        {/* Dashboard Content */}
        <div className="flex-1 overflow-y-auto p-8">
           <div className="max-w-7xl mx-auto space-y-6">
              
              {/* Header */}
              <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                  <h1 className="text-2xl font-bold text-slate-900">Dashboard Overview</h1>
                  <p className="text-sm text-slate-500 mt-1">Real-time insights across your {suite.name} environment.</p>
                </div>
                <div className="flex gap-2">
                   <button className="flex items-center gap-2 px-3 py-2 bg-white border border-slate-200 rounded-md text-sm font-medium text-slate-700 hover:bg-slate-50">
                     <Filter size={16} /> Filter
                   </button>
                   <button className="flex items-center gap-2 px-3 py-2 bg-white border border-slate-200 rounded-md text-sm font-medium text-slate-700 hover:bg-slate-50">
                     <Download size={16} /> Export
                   </button>
                   <button className="flex items-center gap-2 px-3 py-2 bg-[#007A5E] text-white rounded-md text-sm font-medium hover:bg-[#00634B] shadow-sm">
                     <Zap size={16} /> Run Audit
                   </button>
                </div>
              </div>

              {/* Metrics Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                {suite.stats.map((stat, i) => (
                  <EnterpriseMetric key={i} {...stat} />
                ))}
              </div>

              {/* Main Chart Section */}
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                 {/* Chart */}
                 <div className="lg:col-span-2 bg-white border border-slate-200 rounded-md p-6 shadow-sm">
                    <div className="flex items-center justify-between mb-6">
                       <h3 className="font-bold text-slate-900">Revenue Performance</h3>
                       <div className="flex bg-slate-100 rounded p-0.5">
                          <button className="px-3 py-1 text-xs font-medium rounded bg-white text-slate-900 shadow-sm">30D</button>
                          <button className="px-3 py-1 text-xs font-medium rounded text-slate-500 hover:text-slate-900">3M</button>
                          <button className="px-3 py-1 text-xs font-medium rounded text-slate-500 hover:text-slate-900">1Y</button>
                       </div>
                    </div>
                    <div className="h-64 w-full relative">
                       {/* Chart Background Grid */}
                       <div className="absolute inset-0 flex flex-col justify-between text-xs text-slate-400">
                          <div className="border-t border-slate-100 w-full pt-1">100k</div>
                          <div className="border-t border-slate-100 w-full pt-1">75k</div>
                          <div className="border-t border-slate-100 w-full pt-1">50k</div>
                          <div className="border-t border-slate-100 w-full pt-1">25k</div>
                          <div className="border-t border-slate-100 w-full pt-1">0</div>
                       </div>
                       <div className="absolute inset-0 pt-4 pl-8">
                          <Sparkline data={[30, 45, 42, 50, 65, 55, 70, 75, 80, 75, 85, 90]} color="#007A5E" />
                       </div>
                    </div>
                 </div>

                 {/* AI Command Center Widget */}
                 <div className="bg-white border border-slate-200 rounded-md shadow-sm flex flex-col h-[350px]">
                    <div className="p-4 border-b border-slate-200 flex justify-between items-center bg-slate-50 rounded-t-md">
                       <h3 className="font-bold text-slate-900 flex items-center gap-2">
                          <Cpu size={16} className="text-[#007A5E]" /> AI Assistant
                       </h3>
                       <span className="text-[10px] font-mono bg-green-100 text-green-700 px-2 py-0.5 rounded-full">ONLINE</span>
                    </div>
                    <div className="flex-1 overflow-y-auto p-4 space-y-4 bg-slate-50/50">
                       {messages.map(m => (
                          <div key={m.id} className={`flex ${m.sender === 'user' ? 'justify-end' : 'justify-start'}`}>
                             <div className={`max-w-[85%] rounded-md px-3 py-2 text-sm border shadow-sm ${
                                m.sender === 'user' 
                                  ? 'bg-white border-slate-200 text-slate-800' 
                                  : 'bg-[#007A5E] text-white border-transparent'
                             }`}>
                                {m.text}
                             </div>
                          </div>
                       ))}
                       <div ref={chatRef} />
                    </div>
                    <div className="p-3 bg-white border-t border-slate-200">
                       <div className="relative">
                          <input 
                            value={input}
                            onChange={(e) => setInput(e.target.value)}
                            onKeyDown={(e) => e.key === 'Enter' && handleCommand()}
                            placeholder="Execute command..."
                            className="w-full bg-slate-50 border border-slate-200 rounded pl-3 pr-10 py-2 text-sm focus:outline-none focus:border-[#007A5E]"
                          />
                          <button onClick={() => handleCommand()} className="absolute right-2 top-2 text-[#007A5E] hover:text-[#00634B]">
                             <Send size={16} />
                          </button>
                       </div>
                    </div>
                 </div>
              </div>

              {/* Data Table */}
              <div className="bg-white border border-slate-200 rounded-md shadow-sm overflow-hidden">
                 <div className="p-4 border-b border-slate-200 flex justify-between items-center">
                    <h3 className="font-bold text-slate-900">Recent Transactions</h3>
                    <button className="text-sm text-[#007A5E] hover:underline font-medium">View All</button>
                 </div>
                 <div className="overflow-x-auto">
                    <table className="w-full text-sm text-left">
                       <thead className="bg-slate-50 text-slate-500 font-medium border-b border-slate-200">
                          <tr>
                             <th className="px-6 py-3">ID</th>
                             <th className="px-6 py-3">Asset Name</th>
                             <th className="px-6 py-3">Type</th>
                             <th className="px-6 py-3">Status</th>
                             <th className="px-6 py-3">Value</th>
                             <th className="px-6 py-3">Date</th>
                             <th className="px-6 py-3"></th>
                          </tr>
                       </thead>
                       <tbody className="divide-y divide-slate-100">
                          {suite.tableData.map((row, i) => (
                             <tr key={i} className="hover:bg-slate-50 transition-colors">
                                <td className="px-6 py-3 font-mono text-slate-500">{row.id}</td>
                                <td className="px-6 py-3 font-medium text-slate-900">{row.name}</td>
                                <td className="px-6 py-3 text-slate-600">{row.type}</td>
                                <td className="px-6 py-3">
                                   <span className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium border ${
                                      row.status === 'Active' || row.status === 'Completed' ? 'bg-green-50 text-green-700 border-green-100' :
                                      row.status === 'Pending' || row.status === 'Processing' ? 'bg-yellow-50 text-yellow-700 border-yellow-100' :
                                      'bg-slate-100 text-slate-600 border-slate-200'
                                   }`}>
                                      {row.status === 'Active' && <span className="w-1.5 h-1.5 rounded-full bg-green-500 mr-1.5"></span>}
                                      {row.status}
                                   </span>
                                </td>
                                <td className="px-6 py-3 font-medium text-slate-900">{row.price}</td>
                                <td className="px-6 py-3 text-slate-500">{row.date}</td>
                                <td className="px-6 py-3 text-right">
                                   <button className="text-slate-400 hover:text-slate-600"><MoreVertical size={16} /></button>
                                </td>
                             </tr>
                          ))}
                       </tbody>
                    </table>
                 </div>
              </div>

           </div>
        </div>
      </main>

    </div>
  );
};

// --- Helper Component ---
const SidebarItem = ({ icon, label, active, expanded, onClick }) => (
  <button 
    onClick={onClick}
    className={`w-full flex items-center gap-3 px-3 py-2 rounded-md transition-all duration-200 mb-0.5 ${
       active ? THEME.activeItem : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900'
    } ${!expanded && 'justify-center'}`}
  >
    <div className={active ? 'text-[#007A5E]' : ''}>{icon}</div>
    {expanded && <span className="text-sm font-medium">{label}</span>}
  </button>
);

export default function App() {
  const [view, setView] = useState('landing');
  return view === 'landing' ? <LandingPage onEnter={() => setView('dashboard')} /> : <Dashboard onLogout={() => setView('landing')} />;
}
'@ | Set-Content src/App.jsx

Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
npm install

Write-Host "`n✅ AGX9 Enterprise Dashboard setup complete!" -ForegroundColor Green
Write-Host "`n🚀 Starting development server..." -ForegroundColor Cyan
Write-Host "   Access at: http://localhost:5173" -ForegroundColor Yellow
Write-Host "`nPress Ctrl+C to stop" -ForegroundColor Gray

# Start the dev server
npm run dev
Write-Host "ASI:One Directory Check" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan

# List all Python files
$pyFiles = Get-ChildItem -Recurse -Filter "*.py" -ErrorAction SilentlyContinue
Write-Host "Python files found: $($pyFiles.Count)" -ForegroundColor Yellow
if ($pyFiles.Count -gt 0) {
    $pyFiles | Select-Object -First 10 | ForEach-Object {
        Write-Host "  - $($_.FullName)" -ForegroundColor Gray
    }
}

# Check for requirements
if (Test-Path "requirements.txt") {
    Write-Host "✓ Found requirements.txt" -ForegroundColor Green
    $reqCount = (Get-Content "requirements.txt" | Measure-Object).Count
    Write-Host "  ($reqCount dependencies)" -ForegroundColor Gray
}

# Check for common ASI:One structure
$commonDirs = @("api", "app", "src", "core", "engine", "models")
foreach ($dir in $commonDirs) {
    if (Test-Path $dir) {
        Write-Host "✓ Found /$dir directory" -ForegroundColor Green
    }
}

# Check port 8000
Write-Host "`nChecking port 8000..." -ForegroundColor Yellow
try {
    $connection = Test-NetConnection localhost -Port 8000 -WarningAction SilentlyContinue
    if ($connection.TcpTestSucceeded) {
        Write-Host "✗ Port 8000 is already in use!" -ForegroundColor Red
    } else {
        Write-Host "✓ Port 8000 is available" -ForegroundColor Green
    }
} catch {
    Write-Host "✓ Port 8000 is available" -ForegroundColor Green
}

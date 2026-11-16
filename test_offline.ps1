# One-Click Offline Verification & Local Test Server Launcher
# Run from PowerShell: .\test_offline.ps1

$ErrorActionPreference = "Stop"
$SiteRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $SiteRoot

Write-Host "`n[Step 1/2] Running automated pre-flight check (verify_site.py)..." -ForegroundColor Cyan
python "$SiteRoot\verify_site.py"

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[STOP] Fix the errors reported above before launching or deploying!" -ForegroundColor Red
    exit 1
}

$Port = 8081
$Url = "http://localhost:$Port"

Write-Host "`n[Step 2/2] Starting Alfu Laily, PhD local GitHub Pages simulation server at $Url ..." -ForegroundColor Green
Write-Host "  -> Opening $Url in your default browser..." -ForegroundColor Yellow
Write-Host "  -> Press Ctrl+C in this window at any time to stop the offline server.`n" -ForegroundColor Yellow

Start-Process $Url
python -m http.server $Port --directory "$SiteRoot"

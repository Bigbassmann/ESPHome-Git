param(
  [string]$Root = "\\192.168.158.131\config\esphome",
  [string]$Config = "sensecap-d1s.yaml"
)

$ErrorActionPreference = "Stop"

$configPath = Join-Path $Root $Config
if (-not (Test-Path $configPath)) {
  Write-Host "ERROR: Config not found: $configPath" -ForegroundColor Red
  exit 2
}

$lines = Get-Content $configPath
$missing = @()

foreach ($line in $lines) {
  if ($line -match '^\s*-\s*!include\s+(.+?)\s*$') {
    $includePath = $matches[1].Trim()
    $fullPath = Join-Path $Root $includePath
    if (-not (Test-Path $fullPath)) {
      $missing += $includePath
    }
  }
}

if ($missing.Count -eq 0) {
  Write-Host "OK: all !include files exist for $Config" -ForegroundColor Green
  exit 0
}

Write-Host "MISSING include file(s):" -ForegroundColor Yellow
$missing | ForEach-Object { Write-Host " - $_" -ForegroundColor Yellow }
exit 1


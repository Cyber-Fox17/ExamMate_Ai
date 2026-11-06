$ErrorActionPreference = "Stop"

$repo = "Cyber-Fox17/ExamMate_Ai"
$asset = "ExamMateAI_v0.1.zip"
$installDir = Join-Path $env:LOCALAPPDATA "Programs\ExamMateAI"
$tempZip = Join-Path $env:TEMP $asset
$downloadUrl = "https://github.com/$repo/releases/latest/download/$asset"

try {
    Write-Host "Downloading ExamMate AI..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempZip

    Write-Host "Installing ExamMate AI..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Expand-Archive -LiteralPath $tempZip -DestinationPath $installDir -Force

    $exe = Join-Path $installDir "ExamMateAI.exe"
    if (-not (Test-Path -LiteralPath $exe)) {
        throw "ExamMateAI.exe was not found in the downloaded ZIP. Check the ZIP's folder structure."
    }

    Remove-Item -LiteralPath $tempZip -Force -ErrorAction SilentlyContinue
    Write-Host "Installation complete. Launching ExamMate AI..." -ForegroundColor Green
    Start-Process -FilePath $exe
}
catch {
    Write-Host "Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again."
    exit 1
}

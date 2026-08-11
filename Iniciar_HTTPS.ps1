$PSScriptRoot = "C:\Users\Gian\Desktop\TiktokHTML\TiktokHTML"

# 1. Iniciar servidor local
Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSScriptRoot\Servidor_TikTok.ps1`"" -WindowStyle Hidden

# 2. Generar Enlace HTTPS Cloudflare Tunnel (Persistente)
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "🚀 GENERANDO ENLACE HTTPS SEGURO (IGUAL A TIKFINITY)..." -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Green

$cloudflared = "$PSScriptRoot\cloudflared.exe"

$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = $cloudflared
$processInfo.Arguments = "tunnel --url http://localhost:8000"
$processInfo.RedirectStandardError = $true
$processInfo.UseShellExecute = $false

$process = New-Object System.Diagnostics.Process
$process.StartInfo = $processInfo
$process.Start() | Out-Null

$httpsUrl = ""
while (-not $process.StandardError.EndOfStream) {
    $line = $process.StandardError.ReadLine()
    if ($line -match "https://[a-zA-Z0-9-]+\.trycloudflare\.com") {
        $httpsUrl = $matches[0]
        break
    }
}

Clear-Host
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "🚀 ENLACE HTTPS PARA TIKTOK LIVE STUDIO (60 FPS FLUIDO)" -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Copia y pega este Enlace HTTPS en TikTok Live Studio:" -ForegroundColor Yellow
Write-Host "$httpsUrl/TiktokFuncion.html" -ForegroundColor White -BackgroundColor Black
Write-Host ""
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "¡Al ser HTTPS, TikTok Studio le otorga Aceleracion Grafica Completa a 60 FPS!" -ForegroundColor Gray

try {
    Set-Clipboard -Value "$httpsUrl/TiktokFuncion.html"
    Write-Host "✅ ¡Enlace copiado automaticamente a tu portapapeles!" -ForegroundColor Green
} catch {}

Write-Host ""
Write-Host "⚠️ MANTÉN ESTA VENTANA ABIERTA MIENTRAS TRANSMITES EN VIVO" -ForegroundColor Yellow
$process.WaitForExit()

$port = 8000
$folder = "C:\Users\Gian\Desktop\TiktokHTML\TiktokHTML"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
try { $listener.Prefixes.Add("http://127.0.0.1:$port/") } catch {}
$listener.Start()

Write-Host "=======================================================" -ForegroundColor Green
Write-Host "🚀 SERVIDOR LOCAL TIKTOK LIVE STUDIO ACTIVO" -ForegroundColor Cyan
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "Copia y pega este enlace exacto en TikTok Live Studio:" -ForegroundColor Yellow
Write-Host "http://localhost:8000/TiktokFuncion.html" -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "Presiona Ctrl+C para detener." -ForegroundColor Gray

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $localPath = $request.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($localPath)) { $localPath = "TiktokFuncion.html" }
    
    $filePath = Join-Path $folder $localPath

    if (Test-Path $filePath -PathType Leaf) {
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        switch ($ext) {
            ".html" { $response.ContentType = "text/html; charset=utf-8" }
            ".js"   { $response.ContentType = "application/javascript" }
            ".css"  { $response.ContentType = "text/css" }
            ".png"  { $response.ContentType = "image/png" }
            ".mp3"  { $response.ContentType = "audio/mpeg" }
            ".mp4"  { $response.ContentType = "video/mp4" }
            default { $response.ContentType = "application/octet-stream" }
        }
        
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $response.StatusCode = 404
    }
    $response.Close()
}

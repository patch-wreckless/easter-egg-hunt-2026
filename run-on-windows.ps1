$root = "$PSScriptRoot\www"

$mimeTypes = @{
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".json" = "application/json"
    ".txt"  = "text/plain"
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8000/")
$listener.Start()

Write-Host "Serving $root at http://localhost:8000/"

start "http://localhost:8000/"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $requestPath = $request.Url.LocalPath.TrimStart("/")

    if ([string]::IsNullOrWhiteSpace($requestPath)) {
        $requestPath = "index.html"
    }

    $safePath = [System.IO.Path]::GetFullPath((Join-Path $root $requestPath))
    if (-not ($safePath.StartsWith($root))) {
        $response.StatusCode = 403
        $msg = [Text.Encoding]::UTF8.GetBytes("403 Forbidden")
        $response.OutputStream.Write($msg, 0, $msg.Length)
        $response.OutputStream.Close()
        continue
    }

    if (-not (Test-Path $safePath -PathType Leaf)) {
        $response.StatusCode = 404
        $msg = [Text.Encoding]::UTF8.GetBytes("404 Not Found")
        $response.OutputStream.Write($msg, 0, $msg.Length)
    }

    try {
        $bytes = [System.IO.File]::ReadAllBytes($safePath)

        $ext = [System.IO.Path]::GetExtension($safePath).ToLower()
        if ($mimeTypes.ContainsKey($ext)) {
            $response.ContentType = $mimeTypes[$ext]
        } else {
            $response.ContentType = "application/octet-stream"
        }

        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
    }
    catch {
        $response.StatusCode = 500
        $msg = [Text.Encoding]::UTF8.GetBytes("500 Internal Server Error")
        $response.OutputStream.Write($msg, 0, $msg.Length)
    }

    $response.OutputStream.Close()
}

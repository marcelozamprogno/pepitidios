$html = Get-Content -Path "index.html" -Raw

$pattern = 'https://[^"''\)]+\.(png|jpg|jpeg|gif|webp|svg|css|js)'
$matches = [regex]::Matches($html, $pattern)

$urls = @{}
foreach ($match in $matches) {
    $url = $match.Value
    if (-not $urls.ContainsKey($url)) {
        $urls[$url] = $true
    }
}

if (-not (Test-Path "assets")) {
    New-Item -ItemType Directory -Path "assets" | Out-Null
}

$total = $urls.Count
$current = 0

foreach ($url in $urls.Keys) {
    $current++
    $filename = Split-Path $url -Leaf
    # Handle query parameters in filename if any
    $filename = $filename -replace '\?.*$', ''
    
    # some filenames might be the same but from different paths, let's prepend a short hash if we want to be 100% safe, 
    # but the greatpages URLs already have a hash like 7028-7a29cbf867cad8326be910a8be0ce1ca.png
    $localPath = "assets/$filename"
    
    Write-Host "Downloading [$current/$total]: $url -> $localPath"
    
    try {
        if (-not (Test-Path $localPath)) {
            Invoke-WebRequest -Uri $url -OutFile $localPath -ErrorAction SilentlyContinue
        }
        $html = $html.Replace($url, $localPath)
    } catch {
        Write-Host "Failed to download: $url"
    }
}

Set-Content -Path "index.html" -Value $html -NoNewline
Write-Host "Done!"

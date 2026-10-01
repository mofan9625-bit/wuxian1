$ErrorActionPreference = "Stop"
$HostName = "yiyuan-jichang.lat"
$Key = (Get-Content -LiteralPath (Join-Path $PSScriptRoot "key.txt") -Raw).Trim()
$KeyLocation = "https://$HostName/$Key.txt"
$SitemapPath = Join-Path (Split-Path $PSScriptRoot -Parent) "sitemap.xml"

if (-not (Test-Path -LiteralPath $SitemapPath)) {
    throw "sitemap.xml was not found: $SitemapPath"
}

[xml]$Sitemap = Get-Content -LiteralPath $SitemapPath -Raw
$Urls = @($Sitemap.urlset.url | ForEach-Object { $_.loc } | Where-Object { $_ })
if ($Urls.Count -eq 0) {
    throw "No URLs were found in sitemap.xml"
}

$Payload = @{
    host = $HostName
    key = $Key
    keyLocation = $KeyLocation
    urlList = $Urls
} | ConvertTo-Json -Depth 4

Write-Host "Submitting $($Urls.Count) URLs to IndexNow..."
$Response = Invoke-WebRequest -Uri "https://api.indexnow.org/indexnow" -Method Post -ContentType "application/json; charset=utf-8" -Body $Payload -UseBasicParsing
Write-Host "HTTP status: $($Response.StatusCode)"
Write-Host "Key location: $KeyLocation"

# PowerShell script to remove "(Operations Manager)" from Omar Ali in all port pages
$portsFolder = "d:\FalconXoft Ship Chandler\Libya\ports"
$htmlFiles = Get-ChildItem -Path $portsFolder -Filter "*.html"

Write-Host "Found $($htmlFiles.Count) HTML files" -ForegroundColor Cyan

$updatedCount = 0

foreach ($file in $htmlFiles) {
    $filePath = $file.FullName
    $content = Get-Content -Path $filePath -Raw
    
    if ($content -like '*Omar Ali (Operations Manager)*') {
        $newContent = $content -replace 'Omar Ali \(Operations Manager\)', 'Omar Ali'
        [System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $updatedCount++
    }
}

Write-Host "`nTotal updated: $updatedCount files" -ForegroundColor Green

# PowerShell script to remove "(Operations Manager)" from Omar Ali in all port pages
# This script only changes the specific line and nothing else

$portsFolder = "d:\FalconXoft Ship Chandler\Libya\ports"

# Get all HTML files in the ports folder
$htmlFiles = Get-ChildItem -Path $portsFolder -Filter "*.html"

Write-Host "Found $($htmlFiles.Count) HTML files in ports folder" -ForegroundColor Cyan
Write-Host ""

$updatedCount = 0
$skippedCount = 0

foreach ($file in $htmlFiles) {
    $filePath = $file.FullName
    $content = Get-Content -Path $filePath -Raw -Encoding UTF8
    
    # Check if the file contains the text we want to replace
    if ($content -match 'Omar Ali \(Operations Manager\)') {
        # Replace only the specific pattern
        $oldPattern = '<li><i class="fas fa-user-tie"></i> Omar Ali \(Operations Manager\)</li>'
        $newPattern = '<li><i class="fas fa-user-tie"></i> Omar Ali</li>'
        $newContent = $content -replace [regex]::Escape($oldPattern), $newPattern
        
        # Write the updated content back to the file
        Set-Content -Path $filePath -Value $newContent -Encoding UTF8 -NoNewline
        
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $updatedCount++
    } else {
        Write-Host "Skipped: $($file.Name) (already updated or pattern not found)" -ForegroundColor Yellow
        $skippedCount++
    }
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Files updated: $updatedCount" -ForegroundColor Green
Write-Host "  Files skipped: $skippedCount" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Done! All port pages have been updated." -ForegroundColor Green

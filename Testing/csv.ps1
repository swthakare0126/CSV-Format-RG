
# Script to generate terraform.tfvars from Rg list.csv
$csvPath = "Rg list.csv"

if (Test-Path $csvPath) {
    $lines = Get-Content -Path $csvPath | Where-Object { $_.Trim() -ne "" }

    $tfvarsContent = "resource_groups = {" + [Environment]::NewLine

    # Skip header line (start from index 1)
    for ($i = 1; $i -lt $lines.Count; $i++) {
        $parts = $lines[$i] -split '\s+|,|\t' | Where-Object { $_ -ne "" }
        
        if ($parts.Count -ge 2) {
            $name = $parts[0].Trim().ToUpper()
            $loc = (($parts[1..($parts.Count-1)] -join "") -replace "\s+", "").ToLower()
            
            $key = "r$i"
            
            $tfvarsContent += "  $key = {" + [Environment]::NewLine
            $tfvarsContent += "    name     = ""$name""" + [Environment]::NewLine
            $tfvarsContent += "    location = ""$loc""" + [Environment]::NewLine
            $tfvarsContent += "  }" + [Environment]::NewLine
        }
    }

    $tfvarsContent += "}"
    $tfvarsContent | Out-File -FilePath "terraform.tfvars" -Encoding utf8
    Write-Host "terraform.tfvars successfully generated!" -ForegroundColor Green
} else {
    Write-Host "Error: Rg list.csv file not found in current folder." -ForegroundColor Red
}
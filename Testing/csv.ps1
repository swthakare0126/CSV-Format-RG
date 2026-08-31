$csvFile = ".\Rg list.csv"
$tfvarsFile = ".\terraform.tfvars"

# Read CSV
$rgs = Import-Csv $csvFile

# Start building terraform.tfvars content
$content = "rgs = {`n"

$index = 1

foreach ($rg in $rgs) {

    $key = "rg$index"

    $content += @"
  $key = {
    name     = "$($rg.name)"
    location = "$($rg.location)"
  }

"@

    $index++
}

$content += "}`n"

# Update terraform.tfvars
Set-Content -Path $tfvarsFile -Value $content

Write-Host "terraform.tfvars updated successfully!"
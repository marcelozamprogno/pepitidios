$html = Get-Content index.html -Raw
Write-Host "20,14:"
[regex]::Matches($html, '.{0,80}20,14.{0,80}') | ForEach-Object { $_.Value }
Write-Host "32,35:"
[regex]::Matches($html, '.{0,80}32,35.{0,80}') | ForEach-Object { $_.Value }
Write-Host "40,49:"
[regex]::Matches($html, '.{0,80}40,49.{0,80}') | ForEach-Object { $_.Value }
Write-Host "197,90:"
[regex]::Matches($html, '.{0,80}197,90.{0,80}') | ForEach-Object { $_.Value }
Write-Host "317,90:"
[regex]::Matches($html, '.{0,80}317,90.{0,80}') | ForEach-Object { $_.Value }
Write-Host "397,90:"
[regex]::Matches($html, '.{0,80}397,90.{0,80}') | ForEach-Object { $_.Value }

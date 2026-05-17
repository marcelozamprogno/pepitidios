$html = Get-Content index.html -Raw
[regex]::Matches($html, '12x.{0,150}20.{0,150}14') | ForEach-Object { $_.Value }
[regex]::Matches($html, '12x.{0,150}32.{0,150}35') | ForEach-Object { $_.Value }
[regex]::Matches($html, '12x.{0,150}40.{0,150}49') | ForEach-Object { $_.Value }

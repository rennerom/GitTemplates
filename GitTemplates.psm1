$path = Join-Path -Path $PSScriptRoot -ChildPath "functions"

Get-ChildItem -Path $path -Filter *.ps1 | Foreach-Object { . $_.FullName }
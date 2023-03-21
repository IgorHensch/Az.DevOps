Get-ChildItem -Path $PSScriptRoot\..\Scripts\*.ps1 -Recurse |
ForEach-Object {
    . $_.FullName
}
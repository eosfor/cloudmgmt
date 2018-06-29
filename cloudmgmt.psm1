# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

Get-ChildItem $PSScriptRoot\*.ps1 -Recurse | ? {$_.Directory -notlike "*test*"}  | % {
    . $_.FullName
}


Export-ModuleMember -Function *-*
# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

#. $PSScriptRoot\Classes\cache.ps1
#. $PSScriptRoot\ArgumentCompleters\cloudmgmt.argumentcompleters.ps1

Get-ChildItem $PSScriptRoot\*.ps1 -Recurse | ? {$_.Directory -notlike "*test*"} | ? {$_.Directory -notlike "_ignore*"} | % {
    . $_.FullName
}


#$Global:cmdbFunc = (Get-Command Get-AzureCMDBData)

Set-Variable -Name cmdbFunc -Value (Get-Command Get-AzureCMDBData) -Option ReadOnly -Scope Global

Export-ModuleMember -Function *-*
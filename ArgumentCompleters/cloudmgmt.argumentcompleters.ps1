
function CMDBDEPTCompleter2 {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $buParamValue = $fakeBoundParameter.BU
    $BUs = (& $cmdbFunc) | ? PartitionKey -EQ "DEPT" | ? BU -EQ $buParamValue | Select-Object code, name -Unique

    $BUs | ? {$_.name -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.code -ToolTip 'DEPT' -ListItemText $_.name
    }
}



function AZRegionCompleter {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    #lets cache our locations
    if (! [CMDBCache]::Instance.cache.AZRegions)  {[CMDBCache]::Instance.cache.AZRegions = Get-AzureRmLocation}
    [CMDBCache]::Instance.cache.AZRegions | ? {$_.DisplayName -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.Location -ListItemText $_.DisplayName -ToolTip 'Azure Region'
    }
}


# sample usage of TabExpansionPlusPlus\Register-ArgumentCompleter
# TabExpansionPlusPlus\Register-ArgumentCompleter -CommandName Get-CMDBdata `
#     -ParameterName BU `
#     -ScriptBlock $Function:CMDBBUCompleter `
#     -Description "BU"

# TabExpansionPlusPlus\Register-ArgumentCompleter -CommandName Get-CMDBdata `
#     -ParameterName DEPT `
#     -ScriptBlock $Function:CMDBDEPTCompleter `
#     -Description "DEPT"
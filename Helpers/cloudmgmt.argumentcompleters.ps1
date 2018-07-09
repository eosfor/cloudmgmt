function CMDBBUCompleter {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    (&$cmdbFunc) | ? PartitionKey -EQ "BU" |
        Select-Object code, name -Unique |
        ? {$_.name -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.code -ToolTip 'BU' -ListItemText $_.name
     }
}

function CMDBDEPTCompleter {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    $buparamindex = $commandAst.CommandElements.IndexOf(($commandAst.CommandElements | ? ParameterName -EQ "BU"))
    $buParamValue = $commandAst.CommandElements[$buparamindex + 1].Value
    $BUs = (& $cmdbFunc) | ? PartitionKey -EQ "DEPT" | ? BU -EQ $buParamValue | Select-Object code, name -Unique

    $BUs | ? {$_.name -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.code -ToolTip 'DEPT' -ListItemText $_.name
    }
}

function CMDBDEPTCompleter2 {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $buParamValue = $fakeBoundParameter.BU
    $BUs = (& $cmdbFunc) | ? PartitionKey -EQ "DEPT" | ? BU -EQ $buParamValue | Select-Object code, name -Unique

    $BUs | ? {$_.name -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.code -ToolTip 'DEPT' -ListItemText $_.name
    }
}


function CMDBBUCompleter3 {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    (&$cmdbFunc) | ? PartitionKey -EQ "BU" |
        Select-Object code, name -Unique |
        ? {$_.name -like "*$wordToComplete*"} | % {
        New-CompletionResult -CompletionText $_.code -ToolTip 'BU' -ListItemText $_.name
     }
}



TabExpansionPlusPlus\Register-ArgumentCompleter -CommandName Get-CMDBdata `
    -ParameterName BU `
    -ScriptBlock $Function:CMDBBUCompleter `
    -Description "BU"

# TabExpansionPlusPlus\Register-ArgumentCompleter -CommandName Get-CMDBdata `
#     -ParameterName DEPT `
#     -ScriptBlock $Function:CMDBDEPTCompleter `
#     -Description "DEPT"
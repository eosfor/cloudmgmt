using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.Collections
using namespace System.Collections.Generic


class CMDBCache
{
    $cache = @{}
    static [CMDBCache] $Instance = [CMDBCache]::new()
    hidden CMDBCache()
    {
        $this.cache.DB = (Get-AzureTableData)
    }
}

class AZRegionCompleter : IArgumentCompleter
{
    [IEnumerable[CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $parameterName,
        [string] $wordToComplete,
        [CommandAst] $commandAst,
        [IDictionary] $fakeBoundParameters)
    {
        $resultList = [List[CompletionResult]]::new()

        if (! [CMDBCache]::Instance.cache.AZRegions)  {[CMDBCache]::Instance.cache.AZRegions = Get-AzureRmLocation}
        $filteredRegions = [CMDBCache]::Instance.cache.AZRegions.Where({$_.DisplayName -like "*$wordToComplete*"})
        foreach ($rgn in $filteredRegions) {
            $resultList.Add([CompletionResult]::new($rgn.Location, $rgn.DisplayName, "ParameterValue", 'Azure Region'))
        }

        return $resultList
    }
}

class CMDBBUCompleter : IArgumentCompleter
{
    [IEnumerable[CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $parameterName,
        [string] $wordToComplete,
        [CommandAst] $commandAst,
        [IDictionary] $fakeBoundParameters)
    {
        $resultList = [List[CompletionResult]]::new()

        (& $Global:cmdbFunc) | ? PartitionKey -EQ "BU" |
        Select-Object code, name -Unique |
        ? {$_.name -like "*$wordToComplete*"} | % {
            $resultList.Add([CompletionResult]::new($_.code, $_.name, "ParameterValue", 'BU'))
     }

     return $resultList
    }
}

class CMDBDEPTCompleter : IArgumentCompleter
{
    [IEnumerable[CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $parameterName,
        [string] $wordToComplete,
        [CommandAst] $commandAst,
        [IDictionary] $fakeBoundParameters)
    {
        $resultList = [List[CompletionResult]]::new()

        $buParamValue = $fakeBoundParameters.BUName
        $BUs = (& $Global:cmdbFunc).Where({$_.PartitionKey -EQ "DEPT"}).
                                    Where({$_.BU -EQ $buParamValue}).
                                    Where({$_.Name -like "*$wordToComplete*"})

        # $BUs = (& $Global:cmdbFunc) | Where-Object PartitionKey -EQ "DEPT" | Where-Object BU -EQ $buParamValue |
        #         Select-Object code, name -Unique | Where-Object {$_.name -like "*$wordToComplete*"}

        foreach ($b in $BUs) {
            $resultList.Add([CompletionResult]::new($b.code, $b.name, "ParameterValue", 'DEPT'))
        }

        return $resultList
    }
}
# naming convention in general
# BUCODE-DEPTCODE-ENVCODE-AZREGION-RESOURCECODE-SUFFIX
# VMs name restricted to 15 chars so namig for them is BUCODE-DEPTCODE-ENVCODE-SUFFIX (no dashes)
# StorageAccount name restricted to 24 chars, should not be any dashes so namig for them is BUCODE-DEPTCODE-ENVCODE-AZREGION-SUFFIX (no dashes)
function New-AzureResourceName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([CMDBBUCompleter])]
        [string]$BUName,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([CMDBDEPTCompleter])]
        [string]$DEPTName,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([AZRegionCompleter])]
        [string]$AZRegion,

        [Parameter(Mandatory=$true)]
        [ValidateSet("DEV","UAT","PDN")] # we want to enfoce these
        [string]$EnvCode,

        [Parameter(Mandatory=$true)]
        [ArgumentCompletions("AVM", "STR")] # there are special cases here. we need to process them separately
        [string]$ResourceCode,

        [Parameter(Mandatory=$true)]
        [string]$Suffix
    )


    end {
        $name = ""
        $vmNameErrorMsg = "VM Name length should be less than 15 characters"
        $strAcctErrorMessage = "Resource Name length should be less than 24 characters"

        switch ($ResourceCode) {
            "AVM" { $name = ($BUName + $DEPTName + $EnvCode + $Suffix).ToUpper(); if ($name.Length -gt 15) {Write-Error $vmNameErrorMsg -EA Stop } break;}
            "STR" { $name = ($BUName + $DEPTName + $EnvCode + $AZRegion + $ResourceCode + $Suffix).ToLower(); if ($name.Length -gt 24) {Write-Error $strAcctErrorMessage -EA Stop } break}
            Default {$name =(($BUName, $DEPTName, $EnvCode, $AZRegion, $ResourceCode, $Suffix) -join '-').ToUpper()}
        }
        $name
    }
}
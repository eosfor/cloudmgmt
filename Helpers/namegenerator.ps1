#naming convention
# BUCODE-DEPTCODE-AZREGION-RESOURCECODE-SUFFIX
function New-AzureResourceName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([CMDBBUCompleter])]
        $BUName,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([CMDBDEPTCompleter])]
        $DEPTName,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter([AZRegionCompleter])]
        $AZRegion,

        [Parameter(Mandatory=$true)]
        [ValidateSet("AVM","VNT")] #sample validations for Azure VMs and VNETs. We want to force only these
        $ResourceCode,

        [Parameter(Mandatory=$true)]
        $Suffix
    )


    end {
        $name = ($BUName, $DEPTName, $AZRegion, $ResourceCode, $Suffix) -join '-'
        if ($ResourceCode -eq "AVM") {
            if ($name.Length -gt 15) { # just a simple check, of course the VM name can be longer, this is just to be on the safe side
                Write-Error "VM Name length should be less than 15 characters" -ErrorAction Stop
            }
        }
        else {
            if ($name.Length -gt 24) { #lowest common length (https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions#naming-rules-and-restrictions)
                Write-Error "Resource Name length should be less than 24 characters" -ErrorAction Stop
            }
        }
        $name
    }
}
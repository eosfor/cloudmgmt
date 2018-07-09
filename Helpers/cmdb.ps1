function Get-CMDBdata {
    [CmdletBinding()]
    param (
        [ArgumentCompleter({CMDBBUCompleter3 @args})]
        $BU,
        [ArgumentCompleter({CMDBDEPTCompleter2 @args})]
        $DEPT
    )

    begin {
    }

    process {
         & $cmdbFunc
    }

    end {
    }
}
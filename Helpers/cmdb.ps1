function Get-CMDBdata {
    [CmdletBinding()]
    param (
        [ArgumentCompleter([CMDBBUCompleter4])]
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
function Get-CMDBdata {
    [CmdletBinding()]
    param (
        [ArgumentCompleter([CMDBBUCompleter])]
        $BU,
        [ArgumentCompleter([CMDBDEPTCompleter])]
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
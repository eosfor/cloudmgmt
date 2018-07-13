#Requires -Version 5
#Requires -Modules AzureRmStorageTable
function ConvertTo-Hashtable
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [psobject[]] $InputObject
    )

    process
    {
        foreach ($object in $InputObject)
        {
            $hash = @{}

            foreach ($property in $object.PSObject.Properties)
            {
                $hash[$property.Name] = $property.Value
            }

            $hash
        }
    }
}

$RGname = "trainingRG01"
$StorageAccountName = "testsstore001"
$TableName = "CMDB"

$storageAcct = Get-AzureRmStorageAccount -ResourceGroupName $RGname -Name $StorageAccountName
$tbl = Get-AzureStorageTable -Name $TableName -Context $storageAcct.Context

$BU = (
@{"NAME" = "Information technology"; "CODE" = "GIT"; "DESCRIPTION" = "Global Information technology unit"},
@{"NAME" = "Security"; "CODE" = "SEC"; "DESCRIPTION" = "Global Security unit"},
@{"NAME" = "Production"; "CODE" = "PDN"; "DESCRIPTION" = "Global Production unit"},
@{"NAME" = "Sales"; "CODE" = "SLS"; "DESCRIPTION" = "Global Sales unit"},
@{"NAME" = "Marketing"; "CODE" = "MKT"; "DESCRIPTION" = "Global Marketing unit"})

$DEPT = (
@{"NAME" = "MS tech"; "CODE" = "WIN"; "BU" = "GIT" ; "DESCRIPTION" = "MS-based technologies department"},
@{"NAME" = "NIX tech"; "CODE" = "UNX"; "BU" = "GIT" ; "DESCRIPTION" = "NIX-based technologies department"},
@{"NAME" = "Networking"; "CODE" = "NET"; "BU" = "GIT" ; "DESCRIPTION" = "Networking technologies department"},
@{"NAME" = "IT security"; "CODE" = "ITS"; "BU" = "GIT" ; "DESCRIPTION" = "IT security department"},
@{"NAME" = "Commpliance"; "CODE" = "COS"; "BU" = "GIT" ; "DESCRIPTION" = "Legal and compliance department"},
@{"NAME" = "Physical security"; "CODE" = "PHS"; "BU" = "GIT" ; "DESCRIPTION" = "Physical security department"},
@{"NAME" = "Ship"; "CODE" = "SHP"; "BU" = "PDN" ; "DESCRIPTION" = "Ship production deparment"},
@{"NAME" = "Machinery"; "CODE" = "MAS"; "BU" = "PDN" ; "DESCRIPTION" = "Machinery production deparment"},
@{"NAME" = "Ship sales"; "CODE" = "SLH"; "BU" = "SLS" ; "DESCRIPTION" = "Ship sales deparment"},
@{"NAME" = "Machinery sales"; "CODE" = "SLM"; "BU" = "SLS" ; "DESCRIPTION" = "Machinery sales deparment"})


$BU | % {
    $currentElement = $_
    $row=@{}
    $row.RowKey = $currentElement.GetHashCode()
    $row.Partition = "BU"
    $row.Property = $currentElement
    Add-StorageTableRow -table $tbl @row
 }

 $DEPT | % {
    $currentElement = $_
    $row=@{}
    $row.RowKey = $currentElement.GetHashCode()
    $row.Partition = "DEPT"
    $row.Property = $currentElement
    Add-StorageTableRow -table $tbl @row
 }

$locations = Import-Csv $PSScriptRoot\_ignore_azlocationcodes.csv
$locations | % {
    $currentElement = $_ | ConvertTo-Hashtable
    $row=@{}
    $row.RowKey = $currentElement.GetHashCode()
    $row.Partition= "LOCATIONS"
    $row.Property = $currentElement
    Add-StorageTableRow -table $tbl @row
}



#

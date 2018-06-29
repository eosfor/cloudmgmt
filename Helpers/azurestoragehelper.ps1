function Convert-AzureData {
    [CmdletBinding()]
    param (
        $azureRows
    )

    begin {
    }

    process {
        $azureRows | % {
            $r = $_
            $r.Properties | % {
                $currentProp = $_

                $o = [hashtable]::new()
                $currentProp.Keys | % {
                    $o[$_] = ($currentProp)[$_].PropertyAsObject
                }
                $o["PartitionKey"] = $r.PartitionKey
                $o["RowKey"] = $r.RowKey
                $o["Timestamp"] = $r.Timestamp
                [pscustomobject]$o
            }
        }
    }

    end {
    }
}

function Get-AzureTableData {
    [CmdletBinding()]
    param (
        $RGname = "trainingRG01",
        $StorageAccountName = "testsstore001",
        $TableName = "CMDB"
    )

    begin {
        $storageAcct = Get-AzureRmStorageAccount -ResourceGroupName $RGname -Name $StorageAccountName
        $tbl = Get-AzureStorageTable -Name $TableName -Context $storageAcct.Context
    }

    process {
        $q1 = [Microsoft.WindowsAzure.Storage.Table.TableQuery]::new()
        $t1 = [Microsoft.WindowsAzure.Storage.Table.TableContinuationToken]::new()

        $res = $tbl.CloudTable.ExecuteQuerySegmentedAsync($q1, $t1).Result

        Convert-AzureData -azureRows $res
    }

    end {
    }
}
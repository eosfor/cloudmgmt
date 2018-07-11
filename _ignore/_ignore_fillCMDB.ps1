$rows =
@{Partition = "BU"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Information technology"; "CODE" = "GIT"; "DESCRIPTION" = "Global Information technology unit"}},
@{Partition = "BU"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Security"; "CODE" = "SEC"; "DESCRIPTION" = "Global Security unit"}},
@{Partition = "BU"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Production"; "CODE" = "PDN"; "DESCRIPTION" = "Global Production unit"}},
@{Partition = "BU"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Sales"; "CODE" = "SLS"; "DESCRIPTION" = "Global Sales unit"}},
@{Partition = "BU"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Marketing"; "CODE" = "MKT"; "DESCRIPTION" = "Global Marketing unit"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "MS tech"; "CODE" = "WIN"; "BU" = "IT" ; "DESCRIPTION" = "MS-based technologies department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "NIX tech"; "CODE" = "UNX"; "BU" = "IT" ; "DESCRIPTION" = "NIX-based technologies department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Networking"; "CODE" = "NET"; "BU" = "IT" ; "DESCRIPTION" = "Networking technologies department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "IT security"; "CODE" = "ITS"; "BU" = "IT" ; "DESCRIPTION" = "IT security department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Commpliance"; "CODE" = "COS"; "BU" = "IT" ; "DESCRIPTION" = "Legal and compliance department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Physical security"; "CODE" = "PHS"; "BU" = "IT" ; "DESCRIPTION" = "Physical security department"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Ship"; "CODE" = "SHP"; "BU" = "PDN" ; "DESCRIPTION" = "Ship production deparment"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Machinery"; "CODE" = "MAS"; "BU" = "PDN" ; "DESCRIPTION" = "Machinery production deparment"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Ship sales"; "CODE" = "SLH"; "BU" = "SLS" ; "DESCRIPTION" = "Ship sales deparment"}},
@{Partition = "DEPT"; RowKey = (New-Guid).Guid; Property = @{"NAME" = "Machinery sales"; "CODE" = "SLM"; "BU" = "SLS" ; "DESCRIPTION" = "Machinery sales deparment"}}

$rows | % {
    Add-StorageTableRow -table $tbl @_
}
#

class CMDBCache
{
    $cache = @{}
    static [CMDBCache] $Instance = [CMDBCache]::new()
    hidden CMDBCache()
    {
        $this.cache.DB = (Get-AzureTableData)
    }
}
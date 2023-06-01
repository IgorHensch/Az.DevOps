class AzureDevOps {
    static [object] InvokeRequest() {
        $apiData = [APIData]::new().Data
        return [WebRequestAzureDevOpsCore]::Invoke($apiData).Value
    }
    static [void] DeleteRequest([object]$Object, [bool]$Force) {
        $apiData = [APIData]::new().Data
        [WebRequestAzureDevOpsCore]::Remove($Object, $apiData, $Force)
    }
}
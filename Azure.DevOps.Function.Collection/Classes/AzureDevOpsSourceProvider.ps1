class AzureDevOpsSourceProvider {
    [string]$private:Name
    [object]$private:SupportedTriggers
    hidden [object]$private:Raw

    AzureDevOpsSourceProvider($Value) {
        $this.Name = $Value.name
        $this.SupportedTriggers = $Value.supportedTriggers
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsSourceProvider[]]Get() {
        $sourceProvider = [AzureDevOps]::InvokeRequest()
        $output = $sourceProvider | ForEach-Object {
            [AzureDevOpsSourceProvider]::new($_)
        }
        return $output
    }
}
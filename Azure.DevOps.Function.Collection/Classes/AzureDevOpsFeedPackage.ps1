class AzureDevOpsFeedPackage {
    [string]$private:Name
    [string]$private:Id
    [string]$private:ProtocolType
    [string]$private:Url
    [object]$private:Versions
    hidden [object]$private:Raw

    AzureDevOpsFeedPackage([Object]$Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.ProtocolType = $Value.protocolType
        $this.Url = $Value.url
        $this.Versions = $Value.versions
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsFeedPackage[]]Get() {
        $artifactFeedPackages = [AzureDevOps]::InvokeRequest()
        $output = $artifactFeedPackages | ForEach-Object {
            [AzureDevOpsFeedPackage]::new($_)
        }
        return $output
    }
}
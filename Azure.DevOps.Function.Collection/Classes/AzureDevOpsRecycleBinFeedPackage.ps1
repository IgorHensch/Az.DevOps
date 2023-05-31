class AzureDevOpsRecycleBinFeedPackage {
    [string]$private:Name
    [string]$private:Id
    [string]$private:ProjectName
    [string]$private:FeedId
    [string]$private:ProtocolType
    [object]$private:Versions
    hidden [object]$private:Raw

    AzureDevOpsRecycleBinFeedPackage ($Value) {
        $project = $script:project
        $feed = $script:feed
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.ProjectName = $project
        $this.FeedId = $feed
        $this.ProtocolType = $Value.protocolType
        $this.Versions = $Value.versions
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsRecycleBinFeedPackage[]]Get() {
        $script:project = $script:projectName
        $script:feed = $script:feedId
        $recycleBinFeedPackage = [AzureDevOps]::InvokeRequest()
        $output = $recycleBinFeedPackage.ForEach{
            [AzureDevOpsRecycleBinFeedPackage]::new($_)
        }
        return $output 
    }
    hidden static [void]CleanScriptVariables() {
        $script:project = $null
        $script:feed = $null
    }
}
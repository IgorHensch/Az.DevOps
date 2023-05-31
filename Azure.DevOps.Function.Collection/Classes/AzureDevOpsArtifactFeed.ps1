class AzureDevOpsArtifactFeed {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Description
    [string]$private:ProjectName
    [string]$private:DefaultViewId
    [string]$private:ViewId
    [string]$private:ViewName
    [string]$private:FullyQualifiedName
    [object]$private:FullyQualifiedId
    [bool]$private:HideDeletedPackageVersions
    [bool]$private:BadgesEnabled
    [string]$private:Capabilities
    [bool]$private:UpstreamEnabled
    [object]$private:UpstreamSources
    hidden [object]$private:Raw

    AzureDevOpsArtifactFeed([Object]$Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.ProjectName = $Value.project.name
        $this.DefaultViewId = $Value.defaultViewId
        $this.ViewId = $Value.viewId
        $this.FullyQualifiedName = $Value.fullyQualifiedName
        $this.FullyQualifiedId = $Value.fullyQualifiedId
        $this.Description = $Value.description
        $this.HideDeletedPackageVersions = $Value.hideDeletedPackageVersions
        $this.BadgesEnabled = $Value.badgesEnabled
        $this.Capabilities = $Value.capabilities
        $this.ViewName = $Value.viewName
        $this.UpstreamEnabled = $Value.upstreamEnabled
        $this.UpstreamSources = $Value.upstreamSources
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsArtifactFeed[]]Get() {
        $artifactFeeds = [AzureDevOps]::InvokeRequest()
        $output = $artifactFeeds | ForEach-Object {
            [AzureDevOpsArtifactFeed]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsArtifactFeed[]]Create() {
        $feed = ($script:body | ConvertFrom-Json).name
        $project = $script:projectName
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            while (-not (Get-AzDevOpsArtifactFeed -Project $project -Name $feed)) {}
            return Get-AzDevOpsArtifactFeed -Project $project -Name $feed
        }
        else {
            return $null
        }
    }
}
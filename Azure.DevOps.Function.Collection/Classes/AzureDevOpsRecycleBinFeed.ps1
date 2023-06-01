class AzureDevOpsRecycleBinFeed {
    [string]$private:Name
    [string]$private:Id
    [string]$private:ProjectName
    [string]$private:Description
    $private:DeletedDate
    $private:ScheduledPermanentDeleteDate
    [bool]$private:HideDeletedPackageVersions
    [string]$private:DefaultViewId
    [bool]$private:BadgesEnabled
    [string]$private:FullyQualifiedName
    [string]$private:FullyQualifiedId
    [string]$private:ViewId
    [string]$private:ViewName
    [string]$private:Capabilities
    [bool]$private:UpstreamEnabled
    [object]$private:UpstreamSources
    hidden [object]$private:Raw

    AzureDevOpsRecycleBinFeed([Object]$Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.ProjectName = $Value.project.name
        $this.Description = $Value.description
        $this.DeletedDate = $Value.deletedDate
        $this.ScheduledPermanentDeleteDate = $Value.scheduledPermanentDeleteDate
        $this.HideDeletedPackageVersions = $Value.hideDeletedPackageVersions
        $this.DefaultViewId = $Value.defaultViewId
        $this.BadgesEnabled = $Value.badgesEnabled
        $this.FullyQualifiedName = $Value.fullyQualifiedName
        $this.FullyQualifiedId = $Value.fullyQualifiedId
        $this.ViewId = $Value.viewId
        $this.ViewName = $Value.viewName
        $this.Capabilities = $Value.capabilities
        $this.UpstreamEnabled = $Value.upstreamEnabled
        $this.UpstreamSources = $Value.upstreamSources
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsRecycleBinFeed[]]Get() {
        $recycleBinFeed = [AzureDevOps]::InvokeRequest()
        $output = $recycleBinFeed | ForEach-Object {
            [AzureDevOpsRecycleBinFeed]::new($_)
        }
        return $output
    }
}
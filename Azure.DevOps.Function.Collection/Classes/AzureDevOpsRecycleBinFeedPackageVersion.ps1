class AzureDevOpsRecycleBinFeedPackageVersion {
    [string]$private:Version
    [string]$private:Id
    [string]$private:Author
    [string]$private:StorageId
    [bool]$private:IsLatest
    [bool]$private:IsListed
    [bool]$private:IsDeleted
    [string]$private:Description
    [object]$private:ProtocolMetadata
    [object]$private:Views
    [object]$private:Tags
    [object]$private:Dependencies
    [object]$private:SourceChain
    $private:PublishDate
    $private:DeletedDate
    $private:ScheduledPermanentDeleteDate
    hidden [object]$private:Raw

    AzureDevOpsRecycleBinFeedPackageVersion ($Value) {
        $this.Version = $Value.version
        $this.Id = $Value.id
        $this.Author = $Value.author
        $this.StorageId = $Value.storageId
        $this.IsLatest = $Value.isLatest
        $this.IsListed = $Value.isListed
        $this.IsDeleted = $Value.IsDeleted
        $this.Description = $Value.description
        $this.ProtocolMetadata = $Value.protocolMetadata
        $this.Views = $Value.views
        $this.Tags = $Value.tags
        $this.Dependencies = $Value.dependencies
        $this.SourceChain = $Value.sourceChain
        $this.PublishDate = $Value.publishDate
        $this.DeletedDate = $Value.deletedDate
        $this.ScheduledPermanentDeleteDate = $Value.ScheduledPermanentDeleteDate
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsRecycleBinFeedPackageVersion[]]Get() {
        $recycleBinFeedPackageVersions = [AzureDevOps]::InvokeRequest()
        $output = $recycleBinFeedPackageVersions.ForEach{
            [AzureDevOpsRecycleBinFeedPackageVersion]::new($_)
        }
        return $output 
    }
}
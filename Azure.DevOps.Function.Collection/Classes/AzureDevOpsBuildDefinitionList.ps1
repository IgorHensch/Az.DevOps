class AzureDevOpsBuildDefinitionList {
    [string]$private:Name
    [int]$private:Id
    [string]$private:Path
    [string]$private:Type
    [string]$private:AuthoredBy
    [object]$private:Queue
    [string]$private:QueueStatus
    [int]$private:Revision
    [string]$private:Quality
    $private:CreatedDate
    [string]$private:ProjectName
    [object]$private:Drafts
    hidden [object]$private:Raw

    AzureDevOpsBuildDefinitionList([Object]$Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Path = $Value.path
        $this.Type = $Value.type
        $this.AuthoredBy = $Value.authoredBy.uniqueName
        $this.Queue = $Value.queue
        $this.QueueStatus = $Value.queueStatus
        $this.Revision = $Value.revision
        $this.Quality = $Value.quality
        $this.CreatedDate = $Value.createdDate
        $this.ProjectName = $Value.project.name
        $this.Drafts = $Value.drafts
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildDefinitionList[]]Get() {
        $buildDefinitionList = [AzureDevOps]::InvokeRequest()
        $output = $buildDefinitionList | ForEach-Object {
            [AzureDevOpsBuildDefinitionList]::new($_)
        }
        return $output
    }
}
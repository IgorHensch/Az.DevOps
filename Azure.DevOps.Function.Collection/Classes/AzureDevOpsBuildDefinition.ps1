class AzureDevOpsBuildDefinition {
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
    [string]$private:RepositoryName
    [object]$private:Drafts
    [string]$private:LastChangedBy
    [string]$private:LastChangedType
    $private:LastChangedDate
    [object]$private:Options
    [object]$private:Triggers
    [object]$private:Variables
    [object]$private:ProcessParameters
    [object]$private:Process
    [string]$private:JobAuthorizationScope
    [int]$private:JobTimeoutInMinutes
    [int]$private:JobCancelTimeoutInMinutes
    [string]$private:BuildNumberFormat
    [object]$private:Properties
    [object]$private:Tags
    hidden [object]$private:BuildDefinitionRevisionRaw
    hidden [object]$private:Raw

    AzureDevOpsBuildDefinition([Object]$Value, [object]$BuildDefinitionRevision) {
        $latestBuildDefinitionRevision = $BuildDefinitionRevision | Sort-Object -Property changedDate -Descending | Select-Object -First 1
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
        $this.LastChangedBy = $latestBuildDefinitionRevision.changedBy.uniqueName 
        $this.LastChangedType = $latestBuildDefinitionRevision.changeType
        $this.LastChangedDate = $latestBuildDefinitionRevision.changedDate
        $this.Options = $Value.options
        $this.Triggers = $Value.triggers
        $this.Variables = $Value.variables
        $this.ProcessParameters = $Value.processParameters
        $this.Process = $Value.process
        $this.JobAuthorizationScope = $Value.jobAuthorizationScope
        $this.JobTimeoutInMinutes = $Value.jobTimeoutInMinutes
        $this.JobCancelTimeoutInMinutes = $Value.jobCancelTimeoutInMinutes
        $this.RepositoryName = $Value.repository.name
        $this.BuildNumberFormat = $Value.buildNumberFormat
        $this.Properties = $Value.properties
        $this.Tags = $Value.tags
        $this.BuildDefinitionRevisionRaw = $BuildDefinitionRevision
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildDefinition[]]Get() {
        function Get-AzDevOpsBuildDefinitionRevision {
            param (
                [string]$ProjectName,
                [string]$BuildDefinitionId
            )
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $ProjectName
            $script:buildDefinitionId = $BuildDefinitionId
            return [AzureDevOps]::InvokeRequest()
        }
        $buildDefinitions = [AzureDevOps]::InvokeRequest()
        $output = $buildDefinitions | ForEach-Object {
            $buildDefinitionRevision = Get-AzDevOpsBuildDefinitionRevision -ProjectName $_.project.name -BuildDefinitionId $_.Id
            [AzureDevOpsBuildDefinition]::new($_, $buildDefinitionRevision)
        }
        return $output
    }
}
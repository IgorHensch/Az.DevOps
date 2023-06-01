class AzureDevOpsRelease {
    [string]$private:Name
    [int]$private:Id
    [string]$private:Status
    [string]$private:CreatedBy
    $private:CreatedOn
    [string]$private:CreatedFor
    [string]$private:ModifiedBy
    $private:ModifiedOn
    $private:Variables
    [object]$private:VariableGroups
    [string]$private:ReleaseDefinitionName
    [int]$private:ReleaseDefinitionRevision
    [string]$private:Description
    [string]$private:Reason
    [string]$private:ReleaseNameFormat
    [bool]$private:KeepForever
    [int]$private:DefinitionSnapshotRevision
    [string]$private:LogsContainerUrl
    [object]$private:Tags
    [string]$private:TriggeringArtifactAlias
    [object]$private:ProjectName
    $private:Properties
    hidden [object]$private:Raw

    AzureDevOpsRelease ($Value) {
        $this.Name = $Value.Name
        $this.Id = $Value.id
        $this.Status = $Value.status
        $this.CreatedOn = $Value.createdOn
        $this.ModifiedOn = $Value.modifiedOn
        $this.CreatedBy = $Value.createdBy.uniqueName
        $this.CreatedFor = $Value.createdFor.uniqueName
        $this.ModifiedBy = $Value.modifiedBy.uniqueName
        $this.Variables = $Value.variables
        $this.VariableGroups = $Value.variableGroups
        $this.ReleaseDefinitionName = $Value.releaseDefinition.name
        $this.ReleaseDefinitionRevision = $Value.releaseDefinitionRevision
        $this.Description = $Value.description
        $this.Reason = $Value.reason
        $this.ReleaseNameFormat = $Value.releaseNameFormat
        $this.KeepForever = $Value.keepForever
        $this.DefinitionSnapshotRevision = $Value.definitionSnapshotRevision
        $this.LogsContainerUrl = $Value.logsContainerUrl
        $this.Tags = $Value.tags
        $this.TriggeringArtifactAlias = $Value.triggeringArtifactAlias
        $this.ProjectName = $Value.projectReference.name
        $this.Properties = $Value.properties
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsRelease[]]Get() {
        $releases = [AzureDevOps]::InvokeRequest()
        $output = $releases.ForEach{
            [AzureDevOpsRelease]::new($_)
        }
        return $output 
    }
}
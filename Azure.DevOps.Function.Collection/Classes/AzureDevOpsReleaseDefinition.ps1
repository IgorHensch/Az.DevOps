class AzureDevOpsReleaseDefinition {
    [string]$private:Name
    [int]$private:Id
    [string]$private:Description
    [string]$private:Path
    [string]$private:Source
    [string]$private:CreatedBy
    $private:CreatedOn
    [string]$private:ModifiedBy
    $private:ModifiedOn
    [bool]$private:IsDeleted
    $private:VariableGroups
    [string]$private:ReleaseNameFormat
    $private:Properties
    [string]$private:ProjectName 
    hidden [object]$private:Raw

    AzureDevOpsReleaseDefinition ($Value) {
        $this.Name = $Value.Name
        $this.Id = $Value.id
        $this.Path = $Value.path
        $this.Source = $Value.source
        $this.CreatedOn = $Value.createdOn
        $this.ModifiedOn = $Value.modifiedOn
        $this.CreatedBy = $Value.createdBy.uniqueName
        $this.ModifiedBy = $Value.modifiedBy.uniqueName
        $this.VariableGroups = $Value.variableGroups
        $this.Description = $Value.description
        $this.ReleaseNameFormat = $Value.releaseNameFormat
        $this.IsDeleted = $Value.isDeleted
        $this.ProjectName = $Value.projectReference.name
        $this.Properties = $Value.properties
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsReleaseDefinition[]]Get() {
        $releaseDefinitions = [AzureDevOps]::InvokeRequest()
        $output = $releaseDefinitions.ForEach{
            [AzureDevOpsReleaseDefinition]::new($_)
        }
        return $output 
    }
}
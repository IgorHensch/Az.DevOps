class AzureDevOpsVariableGroup {
    [string]$private:VariableGroupName
    [int]$private:VariableGroupId
    [string]$private:Type
    [string]$private:Project
    [string]$private:CreatedBy
    [datetime]$private:CreatedOn
    [string]$private:ModifiedBy
    [datetime]$private:ModifiedOn
    [bool]$private:IsShared
    [string]$private:VariableGroupProjectReferences
    [object]$private:Variables
    hidden [object]$private:Raw

    AzureDevOpsVariableGroup([Object]$Value) {
        $projectName = $script:project
        $this.VariableGroupName = $Value.name
        $this.VariableGroupId = $Value.id
        $this.Type = $Value.type
        $this.Project = $projectName
        $this.CreatedBy = $Value.createdBy.uniqueName
        $this.CreatedOn = $Value.createdOn
        $this.ModifiedBy = $Value.modifiedBy.uniqueName
        $this.ModifiedOn = $Value.modifiedOn
        $this.IsShared = $Value.isShared
        $this.VariableGroupProjectReferences = $Value.variableGroupProjectReferences
        $this.Variables = $Value.variables
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsVariableGroup[]]Get() {
        $script:project = $script:projectName
        $variableGroups = [AzureDevOps]::InvokeRequest()
        $output = $variableGroups | ForEach-Object {
            [AzureDevOpsVariableGroup]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsVariableGroup[]]Create() {
        $varGroupName = ($script:body | ConvertFrom-Json).name
        $projectName = $script:projectName
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            while (-not (Get-AzDevOpsVariableGroup -Project $projectName -VariableGroupName $varGroupName)) {}
            return Get-AzDevOpsVariableGroup -Project $projectName -VariableGroupName $varGroupName
        }
        else {
            return $null
        }
    }
    hidden static [void]CleanScriptVariables() {
        $script:project = $null
    }
}
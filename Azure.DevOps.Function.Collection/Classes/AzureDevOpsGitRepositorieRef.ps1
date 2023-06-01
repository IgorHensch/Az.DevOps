class AzureDevOpsGitRepositorieRef {
    [string]$private:RefName
    [string]$private:RefObjectId
    [string]$private:Repositorie
    [string]$private:Project
    [string]$private:Creator
    hidden [object]$private:Raw

    AzureDevOpsGitRepositorieRef([Object]$Value) {
        $repositorieName = $script:repositorie
        $projectName = $script:project
        $this.RefName = $Value.name
        $this.RefObjectId = $Value.objectId
        $this.Repositorie = $repositorieName
        $this.Project = $projectName
        $this.Creator = $Value.creator.uniqueName
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositorieRef[]]Get() {
        $script:repositorie = $script:repositorieName
        $script:project = $script:projectName
        $gitRepositorieRefs = [AzureDevOps]::InvokeRequest()
        $output = $gitRepositorieRefs | ForEach-Object {
            [AzureDevOpsGitRepositorieRef]::new($_)
        }
        return $output
    }
    hidden static [void]CleanScriptVariables() {
        $script:repositorie = $null
        $script:project = $null
    }
}
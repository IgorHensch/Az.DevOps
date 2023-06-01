class AzureDevOpsGitRepositorieItem {
    [string]$private:ObjectId
    [string]$private:Repositorie
    [string]$private:Project
    [string]$private:GitObjectType
    [string]$private:CommitId
    [string]$private:Path
    hidden [object]$private:Raw

    AzureDevOpsGitRepositorieItem([Object]$Value) {
        $repositorieName = $script:repositorie
        $projectName = $script:project
        $this.ObjectId = $Value.objectId
        $this.Repositorie = $repositorieName
        $this.Project = $projectName
        $this.GitObjectType = $Value.gitObjectType
        $this.CommitId = $Value.commitId
        $this.Path = $Value.path
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositorieItem[]]Get() {
        $script:repositorie = $script:repositorieName
        $script:project = $script:projectName
        $gitRepositorieItems = [AzureDevOps]::InvokeRequest()
        $output = $gitRepositorieItems | ForEach-Object {
            [AzureDevOpsGitRepositorieItem]::new($_)
        }
        return $output
    }
    hidden static [void]CleanScriptVariables() {
        $script:repositorie = $null
        $script:project = $null
    }
}
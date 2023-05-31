class AzureDevOpsGitRepositorieStat {
    [string]$private:Name
    [int]$private:AheadCount
    [int]$private:BehindCount
    [string]$private:Repositorie
    [string]$private:Project
    [bool]$private:IsBaseVersion
    [string]$private:CommitId
    [string]$private:Committer
    [string]$private:Comment
    hidden [object]$private:Raw

    AzureDevOpsGitRepositorieStat([Object]$Value) {
        $repositorieName = $script:repositorie
        $projectName = $script:project
        $this.Name = $Value.name
        $this.AheadCount = $Value.aheadCount
        $this.BehindCount = $Value.behindCount
        $this.Repositorie = $repositorieName
        $this.Project = $projectName
        $this.IsBaseVersion = $Value.isBaseVersion
        $this.CommitId = $Value.commit.commitId
        $this.Committer = $Value.commit.committer.email
        $this.Comment = $Value.commit.comment
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositorieStat[]]Get() {
        $script:repositorie = $script:repositorieName
        $script:project = $script:projectName
        $gitRepositorieStats = [AzureDevOps]::InvokeRequest()
        $output = $gitRepositorieStats | ForEach-Object {
            [AzureDevOpsGitRepositorieStat]::new($_)
        }
        return $output
    }
    hidden static [void]CleanScriptVariables() {
        $script:repositorie = $null
        $script:project = $null
    }
}
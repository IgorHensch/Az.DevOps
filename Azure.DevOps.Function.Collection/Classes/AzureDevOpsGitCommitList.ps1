class AzureDevOpsGitCommitList {
    [string]$private:CommitId
    [string]$private:Repositorie
    [string]$private:Project
    [string]$private:Author
    [string]$private:Committer
    [string]$private:Comment
    [string]$private:ChangeCounts
    [string]$private:RemoteUrl
    hidden [string]$private:Url
    hidden [object]$private:Raw

    AzureDevOpsGitCommitList([Object]$Value) {
        $repositorieName = $script:repositorie
        $projectName = $script:project
        $this.CommitId = $Value.commitId
        $this.Repositorie = $repositorieName
        $this.Project = $projectName
        $this.Author = $Value.Author
        $this.Committer = $Value.committer
        $this.Comment = $Value.comment
        $this.ChangeCounts = $Value.changeCounts
        $this.RemoteUrl = $Value.remoteUrl
        $this.Url = $Value.url
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitCommitList[]]Get() {
        $script:repositorie = $script:repositorieName
        $script:project = $script:projectName
        $gitCommitList = [AzureDevOps]::InvokeRequest()
        $output = $gitCommitList | ForEach-Object {
            [AzureDevOpsGitCommitList]::new($_)
        }
        return $output
    }
    hidden static [void]CleanScriptVariables() {
        $script:repositorie = $null
        $script:project = $null
    }
}
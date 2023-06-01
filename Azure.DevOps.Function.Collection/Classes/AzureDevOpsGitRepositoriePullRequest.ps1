class AzureDevOpsGitRepositoriePullRequest {
    [int]$private:PullRequestId
    [int]$private:CodeReviewId
    [string]$private:Repositorie
    [string]$private:Project
    [string]$private:Status
    [string]$private:CreatedBy
    [datetime]$private:CreationDate
    [string]$private:Title
    [string]$private:Description
    [string]$private:SourceRefName
    [string]$private:TargetRefName
    [string]$private:MergeStatus
    [bool]$private:IsDraft
    [string]$private:MergeId
    [array]$private:Reviewers
    [string]$private:LastMergeSourceCommitId
    [string]$private:LastMergeTargetCommitId
    [string]$private:LastMergeCommitId
    [bool]$private:SupportsIterations
    hidden [object]$private:Raw

    AzureDevOpsGitRepositoriePullRequest([Object]$Value) {
        $this.PullRequestId = $Value.pullRequestId
        $this.CodeReviewId = $Value.codeReviewId
        $this.Repositorie = $Value.repository.name
        $this.Project = $Value.repository.project.name
        $this.Status = $Value.status
        $this.CreatedBy = $Value.createdBy.uniqueName
        $this.CreationDate = $Value.creationDate
        $this.Title = $Value.title
        $this.Description = $Value.description
        $this.SourceRefName = $Value.sourceRefName
        $this.TargetRefName = $Value.targetRefName
        $this.MergeStatus = $Value.mergeStatus
        $this.IsDraft = $Value.isDraft
        $this.MergeId = $Value.mergeId
        $this.Reviewers = $Value.reviewers.uniqueName
        $this.LastMergeSourceCommitId = $Value.lastMergeSourceCommit.commitId
        $this.LastMergeTargetCommitId = $Value.lastMergeTargetCommit.commitId
        $this.LastMergeCommitId = $Value.lastMergeCommit.commitId
        $this.SupportsIterations = $Value.supportsIterations
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositoriePullRequest[]]Get() {
        $gitRepositoriePullRequests = [AzureDevOps]::InvokeRequest()
        $output = $gitRepositoriePullRequests | ForEach-Object {
            [AzureDevOpsGitRepositoriePullRequest]::new($_)
        }
        return $output
    }
}
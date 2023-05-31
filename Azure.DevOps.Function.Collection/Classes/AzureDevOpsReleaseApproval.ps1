class AzureDevOpsReleaseApproval {
    [int]$private:Id
    [string]$private:ProjectName
    [int]$private:Revision
    [string]$private:Approver
    [string]$private:ApprovedBy
    [string]$private:ApprovalType
    [string]$private:Status
    $private:CreatedOn
    $private:ModifiedOn
    [string]$private:Comments
    [bool]$private:IsAutomated
    [bool]$private:IsNotificationOn
    [int]$private:TrialNumber
    [int]$private:Attempt 
    [int]$private:Rank
    [object]$private:History
    [object]$private:ReleaseName
    [object]$private:ReleaseDefinitionName
    [object]$private:ReleaseDefinitionPath
    [string]$private:ReleaseEnvironment 
    hidden [object]$private:Raw

    AzureDevOpsReleaseApproval ($Value) {
        $this.Id = $Value.id
        $this.ProjectName = $script:project
        $this.Approver = $Value.approver.uniqueName
        $this.ApprovedBy = $Value.approvedBy.uniqueName
        $this.CreatedOn = $Value.createdOn
        $this.ModifiedOn = $Value.modifiedOn
        $this.ApprovalType = $Value.approvalType
        $this.Status = $Value.status
        $this.Comments = $Value.comments
        $this.IsAutomated = $Value.isAutomated
        $this.IsNotificationOn = $Value.isNotificationOn
        $this.TrialNumber = $Value.trialNumber
        $this.Attempt = $Value.attempt
        $this.Rank = $Value.rank
        $this.History = $Value.history
        $this.ReleaseName = $Value.release.name
        $this.ReleaseDefinitionName = $Value.releaseDefinition.name
        $this.ReleaseDefinitionPath = $Value.releaseDefinition.path
        $this.ReleaseEnvironment = $Value.releaseEnvironment.name
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsReleaseApproval[]]Get() {
        $script:project = $script:projectName
        $releaseApprovals = [AzureDevOps]::InvokeRequest()
        $output = $releaseApprovals.ForEach{
            [AzureDevOpsReleaseApproval]::new($_)
        }
        return $output 
    }
    hidden static [void]CleanScriptVariables() {
        $script:project = $null
    }
}
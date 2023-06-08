class AzureDevOpsPipelineApproval {
    [string]$private:BuildNumber
    [int]$private:BuildId
    [string]$private:ProjectName
    [string]$private:ApprovalId
    [string]$private:ApprovalStatus
    [string]$private:Approver
    $private:QueueTime
    $private:StartTime
    [string]$private:Priority
    $private:Properties
    [object]$private:BuildTags
    [object]$private:ValidationResults
    [string]$private:LastChangedBy
    $private:LastChangedDate
    [string]$private:RequestedBy
    [string]$private:Stage
    [string]$private:RepositoryName
    [string]$private:SourceBranch
    [string]$private:SourceVersion
    [string]$private:DefinitionName
    [string]$private:DefinitionPath
    [string]$private:TriggerInfo
    [string]$private:TriggeredByBuild
    [object]$private:Queue
    [object]$private:BuildLogs
    [bool]$private:RetainedByRelease
    [bool]$private:AppendCommitMessageToRunName

    AzureDevOpsPipelineApproval ($Build, $BuildStage, $Approval) {
        $this.BuildNumber = $Build.BuildNumber
        $this.BuildId = $Build.Id
        $this.ProjectName = $Build.ProjectName
        $this.ApprovalId = $Approval.Id
        $this.ApprovalStatus = $BuildStage.State
        $this.Approver = $Build.RequestedFor
        $this.QueueTime = $Build.QueueTime
        $this.StartTime = $Build.StartTime
        $this.Priority = $Build.Priority
        $this.Properties = $Build.Properties
        $this.BuildTags = $Build.Tags
        $this.ValidationResults = $Build.ValidationResults
        $this.LastChangedBy = $Build.LastChangedBy
        $this.LastChangedDate = $Build.LastChangedDate
        $this.RequestedBy = $Build.RequestedBy
        $this.Stage = $BuildStage.Identifier
        $this.RepositoryName = $Build.RepositoryName
        $this.SourceBranch = $Build.SourceBranch
        $this.SourceVersion = $Build.SourceVersion
        $this.DefinitionName = $Build.DefinitionName
        $this.DefinitionPath = $Build.DefinitionPath
        $this.TriggerInfo = $Build.TriggerInfo
        $this.TriggeredByBuild = $Build.TriggeredByBuild
        $this.Queue = $Build.Queue
        $this.BuildLogs = $Build.Logs
        $this.RetainedByRelease = $Build.RetainedByRelease
        $this.AppendCommitMessageToRunName = $Build.AppendCommitMessageToRunName
    }
    hidden static [AzureDevOpsPipelineApproval[]]Get([string] $Project) {
        $output = (Get-AzDevOpsBuild -Project $Project -IsPending).foreach{
            $build = $_
            $buildRecords = ($build | Get-AzDevOpsBuildTimeline).records | Select-Object type, state, identifier, id
            $buildStage = $buildRecords.where{ $_.type -eq 'Stage' -and $_.state -eq 'pending' }
            $approval = $buildRecords.where{ $_.type -eq 'Checkpoint.Approval' -and $_.state -eq 'inProgress' }
            if ($buildStage.state -eq 'pending' -and -not [string]::IsNullOrEmpty($approval.id)) {
                [AzureDevOpsPipelineApproval]::new($build, $buildStage, $approval)
            }
        }
        return $output
    }
}
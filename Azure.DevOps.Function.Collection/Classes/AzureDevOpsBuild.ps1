class AzureDevOpsBuild {
    [string]$private:BuildNumber
    [int]$private:Id
    [string]$private:ProjectName
    [string]$private:RepositoryName
    [string]$private:Properties
    [object]$private:Tags
    [object]$private:ValidationResults
    [object]$private:Plans
    [string]$private:TriggerInfo
    [string]$private:Status
    [string]$private:Result
    $private:QueueTime
    $private:StartTime
    $private:FinishTime
    [string]$private:DefinitionName
    [string]$private:DefinitionPath
    [int]$private:BuildNumberRevision
    [string]$private:SourceBranch
    [string]$private:SourceVersion
    [string]$private:Priority
    [string]$private:Reason
    [string]$private:RequestedFor
    [string]$private:RequestedBy
    $private:LastChangedDate
    [string]$private:LastChangedBy
    [object]$private:OrchestrationPlan
    [object]$private:Queue
    [object]$private:Logs
    [bool]$private:RetainedByRelease
    [string]$private:TriggeredByBuild
    [bool]$private:AppendCommitMessageToRunName
    hidden [object]$private:Raw

    AzureDevOpsBuild([Object]$Value) {
        $this.BuildNumber = $Value.buildNumber
        $this.Id = $Value.id
        $this.ProjectName = $Value.project.name
        $this.RepositoryName = $Value.repository.name
        $this.Properties = $Value.properties
        $this.Tags = $Value.tags
        $this.ValidationResults = $Value.validationResults
        $this.Plans = $Value.plans
        $this.TriggerInfo = $Value.triggerInfo
        $this.Status = $Value.status
        $this.Result = $Value.result
        $this.QueueTime = $Value.queueTime
        $this.StartTime = $Value.startTime
        $this.FinishTime = $Value.finishTime
        $this.DefinitionName = $Value.definition.name
        $this.DefinitionPath = $Value.definition.path
        $this.BuildNumberRevision = $Value.buildNumberRevision
        $this.SourceBranch = $Value.sourceBranch
        $this.SourceVersion = $Value.sourceVersion
        $this.Priority = $Value.priority
        $this.Reason = $Value.reason
        $this.RequestedFor = $Value.requestedFor.uniqueName
        $this.RequestedBy = $Value.requestedBy.uniqueName
        $this.LastChangedDate = $Value.lastChangedDate
        $this.LastChangedBy = $Value.lastChangedBy.uniqueName
        $this.OrchestrationPlan = $Value.orchestrationPlan
        $this.Queue = $Value.queue
        $this.Logs = $Value.logs
        $this.RetainedByRelease = $Value.retainedByRelease
        $this.TriggeredByBuild = $Value.triggeredByBuild
        $this.AppendCommitMessageToRunName = $Value.appendCommitMessageToRunName
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuild[]]Get() {
        $builds = [AzureDevOps]::InvokeRequest()
        $output = $builds | ForEach-Object {
            [AzureDevOpsBuild]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsBuild[]]GetPending() {
        function Get-AzDevOpsPendingBuild {
            param ()
            $script:function = $MyInvocation.MyCommand.Name
            $pendinBuilds = [AzureDevOps]::InvokeRequest()
            $output = $pendinBuilds | ForEach-Object {
                [AzureDevOpsBuild]::new($_)
            }
            return $output
        }
        return Get-AzDevOpsPendingBuild
    }
}
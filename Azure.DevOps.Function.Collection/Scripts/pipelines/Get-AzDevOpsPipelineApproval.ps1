function Get-AzDevOpsPipelineApproval {
    <#
    .SYNOPSIS
        Gets Azure DevOps Pipeline Approvals.
    .DESCRIPTION
        Gets Pipeline Approvals from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsPipelineApproval -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsPipelineApproval -Project 'ProjectName' -BuildNumber 'BuildNumber'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$BuildNumber = '*'
    )
    process {
        try {
            $output = (Get-AzDevOpsBuild -Project $Project).where{ 
                $_.status -eq 'inProgress' 
            }.foreach{
                $build = $_
                $buildRecords = ($build | Get-AzDevOpsBuildTimeline).records | Select-Object type, state, identifier, id
                $buildStage = $buildRecords.where{ $_.type -eq 'Stage' -and $_.state -eq 'pending' }
                $approval = $buildRecords.where{ $_.type -eq 'Checkpoint.Approval' }
                if ($buildStage.state -eq 'pending' -and -not [string]::IsNullOrEmpty($approval.id)) {
                    [ordered]@{
                        id                           = $build.id
                        approver                     = $build.requestedFor
                        stage                        = $buildStage.identifier
                        approvalId                   = $approval.id
                        state                        = $buildStage.state
                        _links                       = $build._links
                        properties                   = $build.properties
                        tags                         = $build.tags
                        validationResults            = $build.validationResults
                        plans                        = $build.plans
                        buildNumber                  = $build.buildNumber
                        queueTime                    = $build.queueTime
                        startTime                    = $build.startTime
                        url                          = $build.url
                        queue                        = $build.queue
                        sourceBranch                 = $build.sourceBranch
                        sourceVersion                = $build.sourceVersion
                        project                      = $build.project
                        uri                          = $build.uri
                        reason                       = $build.reason
                        priority                     = $build.priority
                        repository                   = $build.repository
                        requestedBy                  = $build.requestedBy
                        lastChangedDate              = $build.lastChangedDate
                        lastChangedBy                = $build.lastChangedBy
                        orchestrationPlan            = $build.orchestrationPlan
                        logs                         = $build.logs
                        retainedByRelease            = $build.retainedByRelease
                        definition                   = $build.definition
                        triggerInfo                  = $build.triggerInfo
                        triggeredByBuild             = $build.triggeredByBuild
                        appendCommitMessageToRunName = $build.appendCommitMessageToRunName
                    }
                }
            }
            Write-Output -InputObject $output.where{ $_.buildNumber -imatch "^$BuildNumber$" }
        }
        catch {
            throw $_
        }
    }
}
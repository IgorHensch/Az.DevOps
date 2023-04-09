function Get-AzDevOpsBuildApprovals {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Pipeline Approvals.
    .DESCRIPTION
        Gets Build Approvals in Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildApprovals -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildApprovals -Project 'ProjectName' -BuildNumber 'BuildNumber'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$BuildNumber = '*'
    )
    process {
        try {
            $output = @()
            Get-AzDevOpsBuilds -Project $Project | Where-Object { $_.status -eq 'inProgress' } | ForEach-Object {
                $build = $_
                $buildRecords = ($build | Get-AzDevOpsBuildTimeline).records
                $buildStage = $buildRecords | Where-Object { $_.type -eq 'Stage' -and $_.state -eq 'pending' }
                $approval = $buildRecords | Where-Object { $_.type -eq 'Checkpoint.Approval' }
                if ($buildStage.state -eq 'pending' -and -not [string]::IsNullOrEmpty($approval.id)) {
                    $output += @{
                        _links                       = $build._links
                        properties                   = $build.properties
                        tags                         = $build.tags
                        validationResults            = $build.validationResults
                        plans                        = $build.plans
                        buildNumber                  = $build.buildNumber
                        id                           = $build.id
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
                        requestedFor                 = $build.requestedFor
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
                        state                        = $buildStage.state
                        stage                        = $buildStage.identifier
                        approvalId                   = $approval.id
                    }
                }
            }
            Write-Output -InputObject $output | Select-Object `
                stage, _links, properties, tags, validationResults, plans, triggerInfo, id, approvalId, buildNumber, state, queueTime, startTime, url, definition, project, `
                uri, sourceBranch, sourceVersion, queue, priority, reason, requestedFor, requestedBy, lastChangedDate, lastChangedBy, orchestrationPlan, logs, repository, `
                retainedByRelease, triggeredByBuild, appendCommitMessageToRunName `
            | Where-Object { $_.buildNumber -imatch "^$BuildNumber$" }
        }
        catch {
            throw $_
        }
    }
}

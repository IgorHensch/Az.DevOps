function Approve-AzDevOpsPipeline {
    <#
    .SYNOPSIS
        Approves Azure DevOps Pipeline.
    .DESCRIPTION
        Approves Pipeline from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsPipelineApproval
    .EXAMPLE
        Approve-AzDevOpsPipeline -ApprovalId 'ApprovalId' -Project 'ProjectName'
    .EXAMPLE
        Approve-AzDevOpsPipeline -ApprovalId 'ApprovalId' -Project 'ProjectName' -Comment 'Comment'
    .EXAMPLE
        Get-AzDevOpsPipelineApproval -Project 'ProjectName' -BuildNumber 'BuildNumber' | Approve-AzDevOpsPipeline
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [string]$Comment,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    ApprovalId = $ApprovalId
                    Project    = $Project
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalId = $PipelineObject.approvalId
                    Project    = $PipelineObject.project.name
                }
            }
        }
        $body = @{
            approvalId = $param.ApprovalId
            status     = 4
            comment    = $Comment
        } | ConvertTo-Json -Depth 2 -AsArray
        try {
            [WebRequestAzureDevOpsCore]::Update('pipelines/approvals', $body, 'application/json', $param.Project, $script:sharedData.ApiVersionPreview, $null, $null)
        }
        catch {
            throw $_
        }
    }
}
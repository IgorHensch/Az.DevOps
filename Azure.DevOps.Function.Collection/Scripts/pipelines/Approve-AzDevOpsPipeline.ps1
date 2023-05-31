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
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Comment,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    ApprovalId = $ApprovalId
                    Project    = $Project
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalId = $PipelineObject.ApprovalId
                    Project    = $PipelineObject.ProjectName
                }
            }
        }
        try {
            $script:body = @{
                approvalId = $param.ApprovalId
                status     = 4
                comment    = $Comment
            } | ConvertTo-Json -Depth 2 -AsArray
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $param.Project
            [AzureDevOps]::InvokeRequest()
        }
        catch {
            throw $_
        }
    }
}
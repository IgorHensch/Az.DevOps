function Approve-AzDevOpsRelease {
    <#
    .SYNOPSIS
        Approves Azure DevOps Release Pipeline.
    .DESCRIPTION
        Approves Release Pipeline in Azure Devops Releases.
    .LINK
        Get-AzDevOpsReleaseApproval
    .EXAMPLE
        Approve-AzDevOpsRelease -ApprovalId 'ApprovalId' -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsReleaseApproval -Project 'ProjectName' -Id 'ApprovalId' | Approve-AzDevOpsRelease
    .NOTES
        PAT Permission Scope: vso.release_manage
        Description: Grants the ability to read, update and delete release artifacts, including folders, releases, release 
        definitions and release environment and the ability to queue and approve a new release.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    ApprovalId = (Get-AzDevOpsReleaseApproval -Project $Project -Id $ApprovalId).Id
                    Project    = $Project
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalId = $PipelineObject.Id
                    Project    = $PipelineObject.ProjectName
                }
            }
        }
        try {
            $script:body = @{
                status = "approved"
            } | ConvertTo-Json -Depth 2
            $script:approvalId = $param.ApprovalId
            $script:project = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsReleaseApproval]::new([AzureDevOps]::InvokeRequest())
        }
        catch {
            throw $_
        }
    }
}
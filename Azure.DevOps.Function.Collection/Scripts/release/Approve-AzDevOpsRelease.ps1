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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    ApprovalUrl = (Get-AzDevOpsReleaseApproval -Project $Project -Id $ApprovalId).url
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalUrl = PipelineObject.url
                }
            }
        }
        $body = @{
            status = "approved"
        } | ConvertTo-Json -Depth 2
        try {
            [WebRequestAzureDevOpsCore]::Update($param.ApprovalUrl, $body, $script:sharedData.ApiVersionPreview)
        }
        catch {
            throw $_
        }
    }
}
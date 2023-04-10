function Approve-AzDevOpsRelease {
    <#
    .SYNOPSIS
        Approves Azure DevOps Release Pipeline.
    .DESCRIPTION
        Approves Release Pipeline in Azure Devops Releases.
    .LINK
        Get-AzDevOpsApproval
    .EXAMPLE
        Approve-AzDevOpsRelease -ApprovalId 'ApprovalId' -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsApproval -Project 'ProjectName' -Id 'ApprovalId' | Approve-AzDevOpsRelease
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
                    ApprovalUrl = (Get-AzDevOpsApproval -Project $Project -Id $ApprovalId).url
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalUrl = PipelineObject.url
                }
            }
        }
        $approvalsUri = "$($param.ApprovalUrl)?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            status = "approved"
        }
        $body = $bodyData | ConvertTo-Json
        try {
            Invoke-RestMethod -Uri $approvalsUri -Method Patch -Body $body -Headers $script:sharedData.Header -ContentType 'application/json'
        }
        catch {
            throw $_
        }
    }
}
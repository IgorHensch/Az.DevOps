function Get-AzDevOpsReleaseApproval {
    <#
    .SYNOPSIS
        Gets Azure DevOps Release Pipeline Approvals.
    .DESCRIPTION
        Gets Release Approvals from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsReleaseApproval -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsReleaseApproval -Project 'ProjectName' -Id 'ApprovalId'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Id = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('release/approvals', $script:sharedData.ApiVersionPreview, $Project, 'vsrm.', $null)
        Write-Output -InputObject $request.value.where{ $_.id -imatch "^$Id$" }.foreach{ $_ | Add-Member @{project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}
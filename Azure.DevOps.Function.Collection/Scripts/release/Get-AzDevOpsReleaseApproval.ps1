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
    .NOTES
        PAT Permission Scope: vso.release
        Description: Grants the ability to read release artifacts, including folders, releases, release definitions and release environment.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Id = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsReleaseApproval]::Get().where{ $_.Id -imatch "^$Id$" } 
            [AzureDevOpsReleaseApproval]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }
}
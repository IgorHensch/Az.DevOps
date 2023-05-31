function Get-AzDevOpsCurrentUser {
    <#
    .SYNOPSIS
        Gets Azure DevOps Current User.
    .DESCRIPTION
        Gets Current User from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsCurrentUser
    .NOTES
        Permission Scope: vso.profile
        Description: Grants the ability to read your profile, accounts, collections, projects, teams, and other top-level organizational artifacts.
    #>
    [CmdletBinding()]
    param ()
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsConnectionProfile]::GetUser()
        }
        catch {
            throw $_
        }
    }
}
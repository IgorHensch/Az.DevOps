function Get-AzDevOpsUser {
    <#
    .SYNOPSIS
        Gets Azure DevOps User.
    .DESCRIPTION
        Gets User from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsUser
    .EXAMPLE
        Get-AzDevOpsUser -PrincipalName 'PrincipalName'
    .NOTES
        PAT Permission Scope: vso.graph
        Description: Grants the ability to read user, group, scope and group membership information.
    #>
    [CmdletBinding()]
    param (
        [string]$PrincipalName = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsUserGroup]::Get().where{ $_.PrincipalName -imatch "^$PrincipalName$" }
        }
        catch {
            throw $_
        }
    }
}
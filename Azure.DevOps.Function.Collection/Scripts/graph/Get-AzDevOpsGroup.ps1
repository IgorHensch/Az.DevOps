function Get-AzDevOpsGroup {
    <#
    .SYNOPSIS
        Gets Azure DevOps Groups.
    .DESCRIPTION
        Gets Groups from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsGroup
    .EXAMPLE
        Get-AzDevOpsGroup -PrincipalName 'PrincipalName'
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
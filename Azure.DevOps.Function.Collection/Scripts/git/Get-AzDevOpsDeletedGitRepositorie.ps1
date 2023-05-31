function Get-AzDevOpsDeletedGitRepositorie {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Git Repositories.
    .DESCRIPTION
        Gets deleted Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositorie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositorie -Project 'ProjectName' -IsSoftDeleted
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    .NOTES
        PAT Permission Scope: vso.code
        Description: Grants the ability to read source code and metadata about commits, changesets, branches, and other version control artifacts.
        Also grants the ability to search code and get notified about version control events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Name = '*',
        [switch]$IsSoftDeleted
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsGitDeletedRepositorie]::Get($IsSoftDeleted).where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}

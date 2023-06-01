function Get-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Repositories.
    .DESCRIPTION
        Gets Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
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
        [string]$Name = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsGitRepositorie]::Get().where{ $_.Name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
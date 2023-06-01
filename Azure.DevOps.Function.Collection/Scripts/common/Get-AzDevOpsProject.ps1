function Get-AzDevOpsProject {
    <#
    .SYNOPSIS
        Gets Azure DevOps Projects.
    .DESCRIPTION
        Gets Projects from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsProject
    .EXAMPLE
        Get-AzDevOpsProject -Name 'ProjectName'
    .NOTES
        PAT Permission Scope: vso.profile, vso.project
        Description: Grants the ability to read your profile, accounts, collections, projects, teams, and other top-level organizational artifacts.
    #>
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsProject]::Get().where{ $_.Name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}

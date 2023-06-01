function Get-AzDevOpsReleaseDefinition {
    <#
    .SYNOPSIS
        Gets Azure DevOps Release Definitions.
    .DESCRIPTION
        Gets Release Definitions from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsReleaseDefinition -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsReleaseDefinition -Project 'ProjectName' -Name 'ReleaseDefinitionName'
    .NOTES
        PAT Permission Scope: vso.release
        Description: Grants the ability to read release artifacts, including folders, releases, release definitions and release environment.
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
            [AzureDevOpsReleaseDefinition]::Get().where{ $_.name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}
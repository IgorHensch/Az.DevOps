function Get-AzDevOpsRelease {
    <#
    .SYNOPSIS
        Gets Azure DevOps Releases.
    .DESCRIPTION
        Gets Releases from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsRelease -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsRelease -Project 'ProjectName' -Name 'ReleaseName'
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
            [AzureDevOpsRelease]::Get().where{ $_.name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}
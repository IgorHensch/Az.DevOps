function Get-AzDevOpsBuild {
    <#
    .SYNOPSIS
        Gets Azure DevOps Builds.
    .DESCRIPTION
        Gets Builds from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId'
    .NOTES
        PAT Permission Scope: vso.build
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [switch]$IsPending,
        [string]$Id = '*'
    )
    end {
        try {
            $script:projectName = $Project
            if ($IsPending) {
                [AzureDevOpsBuild]::GetPending().where{ $_.id -imatch "^$Id$" }
            }
            else {
                $script:function = $MyInvocation.MyCommand.Name
                [AzureDevOpsBuild]::Get().where{ $_.id -imatch "^$Id$" }
            }
        }
        catch {
            throw $_
        }
    }
}
function Get-AzDevOpsBuildSetting {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Settings.
    .DESCRIPTION
        Gets Build Settings from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildSetting -Project 'ProjectName' -Setting 'Setting'
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
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('DefaultRetentionPolicy', 'MaximumRetentionPolicy', 'DaysToKeepDeletedBuildsBeforeDestroy')]
        [string]$Setting
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            if ($Setting -eq 'DaysToKeepDeletedBuildsBeforeDestroy') {
                [PSCustomObject]@{
                    DaysToKeepDeletedBuildsBeforeDestroy = [AzureDevOps]::InvokeRequest().daysToKeepDeletedBuildsBeforeDestroy
                }
            }
            else {
                [AzureDevOpsBuildSetting]::Get($Setting)
            }
        }
        catch {
            throw $_
        }
    }
}
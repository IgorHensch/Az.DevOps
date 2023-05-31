function Get-AzDevOpsBuildFolder {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Folders.
    .DESCRIPTION
        Gets Build Folders from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildFolder -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildFolder -Project 'ProjectName' -Path 'Path'
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
        [string]$Path = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildFolder]::Get().where{ $_.path -imatch "^$($Path.Replace('\', '\\'))$" }
        }
        catch {
            throw $_
        }
    }
}
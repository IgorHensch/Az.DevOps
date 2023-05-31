function Get-AzDevOpsBuildOption {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Options.
    .DESCRIPTION
        Gets Build Options from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName' -Name 'OptionName'
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
        [string]$Name = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildOptions]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
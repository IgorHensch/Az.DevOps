function Get-AzDevOpsSourceProvider {
    <#
    .SYNOPSIS
        Gets Azure DevOps Source Provider.
    .DESCRIPTION
        Gets Source Provider from Azure Devops Project.
    .EXAMPLE
        Get-AzDevOpsSourceProvider -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsSourceProvider -Project 'ProjectName' -Name 'SourceProviderName'
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
            [AzureDevOpsSourceProvider]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
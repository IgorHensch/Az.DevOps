function Get-AzDevOpsProcess {
    <#
    .SYNOPSIS
        Gets Azure DevOps Process.
    .DESCRIPTION
        Gets Process from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsProcess
    .EXAMPLE
        Get-AzDevOpsProcess -Name 'ProcessName'
    .NOTES
        PAT Permission Scope: vso.work
        Description: Grants the ability to read work items, queries, boards, area and iterations paths, and other work item tracking related metadata. 
        Also grants the ability to execute queries, search work items and to receive notifications about work item events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsProcess]::Get().where{ $_.Name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}

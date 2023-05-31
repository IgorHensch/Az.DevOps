function Get-AzDevOpsTeam {
    <#
    .SYNOPSIS
        Gets Azure DevOps Teams.
    .DESCRIPTION
        Gets Teams from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsTeam
    .EXAMPLE
        Get-AzDevOpsTeam -Name 'TeamName'
    .NOTES
        PAT Permission Scope: vso.project
        Description: Grants the ability to read projects and teams.
    #>
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsTeam]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
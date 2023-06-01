function New-AzDevOpsTeam {
    <#
    .SYNOPSIS
        Creates Azure DevOps Team.
    .DESCRIPTION
        Creates Team in Azure Devops.
    .EXAMPLE
        New-AzDevOpsTeam -Name 'TeamName'
    .EXAMPLE
        New-AzDevOpsTeam -Name 'TeamName' -Description 'Description'
    .NOTES
        PAT Permission Scope: vso.project_manage
        Description: Grants the ability to create, read, update, and delete projects and teams.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [string]$Description
    )
    end {
        try {
            $script:body = @{
                name        = $Name
                description = $Description
            } | ConvertTo-Json -Depth 2
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsTeam]::Create()
        }
        catch {
            throw $_
        }
    }
}
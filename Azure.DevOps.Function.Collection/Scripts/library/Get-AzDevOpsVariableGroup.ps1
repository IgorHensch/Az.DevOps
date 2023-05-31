function Get-AzDevOpsVariableGroup {
    <#
    .SYNOPSIS
        Gets Azure DevOps Variable Groups.
    .DESCRIPTION
        Gets Variable Groups from Azure Devops Library.
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName' -VariableGroupName 'VariableGroupName'
    .NOTES
        PAT Permission Scope: vso.variablegroups_read
        Description: Grants the ability to read variable groups.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$VariableGroupName = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsVariableGroup]::Get().where{ $_.VariableGroupName -imatch "^$VariableGroupName$" }
            [AzureDevOpsVariableGroup]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }
}
function Rename-AzDevOpsTeam {
    <#
    .SYNOPSIS
        Rename Azure DevOps Team.
    .DESCRIPTION
        Rename Team in Azure Devops.
    .EXAMPLE
        Rename-AzDevOpsTeam -Name 'TeamName' -NewName 'NewTeamName
    .EXAMPLE
        Rename-AzDevOpsTeam -Name 'TeamName' -NewName 'NewTeamName -Description 'Description'
    .NOTES
        PAT Permission Scope: vso.project_write
        Description: Grants the ability to read and update projects and teams.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NewName,
        [string]$Description,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project = $Project
                    TeamId  = (Get-AzDevOpsTeam -Name $Name).Id
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.ProjectName
                    TeamId  = $PipelineObject.Id
                }
            }
        }
        try {
            $script:body = @{
                name        = $NewName
                description = $Description
            } | ConvertTo-Json -Depth 2
            $script:teamId = $param.TeamId 
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsTeam]::Create()
        }
        catch {
            throw $_
        }
    }
}
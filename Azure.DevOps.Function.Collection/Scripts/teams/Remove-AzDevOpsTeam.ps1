function Remove-AzDevOpsTeam {
    <#
    .SYNOPSIS
        Removes Azure DevOps Team.
    .DESCRIPTION
        Removes Team from Azure Devops.
    .LINK
        Get-AzDevOpsTeam
    .EXAMPLE
        Remove-AzDevOpsTeam -Name 'TeamName'
    .EXAMPLE
        Remove-AzDevOpsTeam -Name 'TeamName' -Force
    .EXAMPLE
        Get-AzDevOpsTeam -Name 'TeamName' | Remove-AzDevOpsTeam
    .EXAMPLE
        Get-AzDevOpsTeam | Remove-AzDevOpsTeam
    .NOTES
        PAT Permission Scope: vso.project_manage
        Description: Grants the ability to create, read, update, and delete projects and teams.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]  
        [string]$TeamName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    TeamName = $TeamName
                }
            }
            'Pipeline' {
                $param = @{
                    TeamName = $PipelineObject.name
                }
            }
        }
        try {
            Write-Output ($team = Get-AzDevOpsTeam -Name $param.TeamName)
            $script:projectId = $team.projectId
            $script:teamId = $team.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($team, $Force)
        }
        catch {
            throw $_
        }
    }
}
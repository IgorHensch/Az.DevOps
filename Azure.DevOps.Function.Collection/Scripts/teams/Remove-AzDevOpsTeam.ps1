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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$TeamName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
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
        $team = Get-AzDevOpsTeam -Name $param.TeamName
        try {
            $team
            [WebRequestAzureDevOpsCore]::Delete($team, $Force, $script:sharedData.ApiVersion).Value
        }
        catch {
            throw $_
        }
    }
}
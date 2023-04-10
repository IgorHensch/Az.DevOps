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
        $team = Get-AzDevOpsTeams -Name $param.TeamName
        $teamUri = "$($team.url)?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $teamUri -Method Delete -Headers $script:sharedData.Header
                Write-Output "Team $($team.name) has been deleted."
            }
            else {
                $team
                $title = "Delete $($team.name) Feed from recycle bin."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $teamUri -Method Delete -Headers $script:sharedData.Header
                    Write-Output "Team $($team.name) has been deleted."
                }
                else {
                    Write-Output 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
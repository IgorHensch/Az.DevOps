function Remove-AzDevOpsTeams {
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
                Write-Host "Team $($team.name) has been deleted."
            }
            else {
                $team
                $title = "Delete $($team.name) Feed from recycle bin."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $teamUri -Method Delete -Headers $script:sharedData.Header
                    Write-Host "Team $($team.name) has been deleted."
                }
                else {
                    Write-Host 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
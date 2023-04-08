function Remove-AzDevOpsProject {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    Name = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Name = $PipelineObject.name
                }
            }
        }
        $project = Get-AzDevOpsProject -Name $param.Name
        $projectUri = "$($project.url)?api-version=$($script:sharedData.ApiVersion)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $projectUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Project $($project.name) has been deleted."
            }
            else {
                $project
                $title = "Delete $($project.name) Project."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
            
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $projectUri -Method Delete -Headers $script:sharedData.Header
                    Write-Host "Project $($project.name) has been deleted."
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
function Remove-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Project = $Project
                Name    = $Name
            }
        }
        'Pipeline' {
            $param = @{
                Project = $PipelineObject.project.name
                Name    = $PipelineObject.name
            }
        }
    }

    $GitRepositorie = Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name
    $GitRepositoriesUri = "$($GitRepositorie.url)?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
        }
        else {
            $GitRepositorie
            $title = "Delete $($GitRepositorie.name) Git repository."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Git repository $($GitRepositorie.name) has been deleted."
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
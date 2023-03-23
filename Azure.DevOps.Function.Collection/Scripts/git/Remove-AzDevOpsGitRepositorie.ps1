function Remove-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Project      = $Project
                RepositoryId = $RepositoryId
            }
        }
        'Pipeline' {
            $param = @{
                Project      = $PipelineObject.project.name
                RepositoryId = $PipelineObject.id
            }
        }
    }

    $GitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/git/repositories/$($param.RepositoryId)`?api-version=$($script:sharedData.ApiVersion)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
        }
        else {
            $response = Invoke-RestMethod -Uri $GitRepositoriesUri -Method Get -Headers $script:sharedData.Header
            $response
            $title = "Delete $($response.name) Git repository."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Git repository $($response.name) has been deleted."
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
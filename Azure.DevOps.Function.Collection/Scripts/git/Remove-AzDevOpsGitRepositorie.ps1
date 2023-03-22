function Remove-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
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
        Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
    }
    catch {
        throw $_
    }
}
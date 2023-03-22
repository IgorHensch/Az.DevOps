function Restore-AzDevOpsSoftDeletedGitRepositorie {
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

    $SoftDeletedGitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/git/recycleBin/repositories/$($param.RepositoryId)`?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        deleted = 'false'
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $SoftDeletedGitRepositoriesUri -Body $Body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
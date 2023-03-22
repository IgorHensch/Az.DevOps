function Rename-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'General')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Pipeline')]
        [string]$NewName
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
    $bodyData = @{
        name = $NewName
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        $Body 
        Invoke-RestMethod -Uri $GitRepositoriesUri -Body $Body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
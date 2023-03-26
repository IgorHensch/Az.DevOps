function Rename-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'General')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Pipeline')]
        [string]$NewName
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
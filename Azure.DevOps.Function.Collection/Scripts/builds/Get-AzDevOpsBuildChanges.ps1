function Get-AzDevOpsBuildChanges {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [string]$Id = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Id      = $Id
                Project = $Project
            }
        }
        'Pipeline' {
            $param = @{
                Id      = $PipelineObject.id
                Project = $PipelineObject.project.name
            }
        }
    }

    $BuildUrl = (Get-AzDevOpsBuilds -Project $param.Project -Id $param.Id).url
    $BuildChangesUri = "$BuildUrl/changes?api-version=$($script:sharedData.ApiVersion)&includeSourceChange=true"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $BuildChangesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
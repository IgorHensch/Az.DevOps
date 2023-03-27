function Get-AzDevOpsProjectProperties {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                ProjectPropertieUrl = (Get-AzDevOpsProject -Name $Project).url
            }
        }
        'Pipeline' {
            $param = @{
                ProjectPropertieUrl = $PipelineObject.url
            }
        }
    }

    $ProjectPropertiesUri = "$($param.ProjectPropertieUrl)/properties?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $ProjectPropertiesUri -Method Get -Headers $script:sharedData.Header).value
    }
    catch {
        throw $_
    }
}
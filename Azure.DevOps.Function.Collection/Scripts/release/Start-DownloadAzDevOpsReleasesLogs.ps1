function Start-DownloadAzDevOpsReleasesLogs {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ReleaseUrl,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'Pipeline')]
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$DownloadPath
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                ReleaseUrl = $ReleaseUrl
            }
        }
        'Pipeline' {
            $param = @{
                ReleaseUrl = $PipelineObject.url
            }
        }
    }
    try {
            $ReleaseUri = "$($param.ReleaseUrl)/logs?api-version=$($script:sharedData.ApiVersionPreview)"
            Invoke-RestMethod -Uri $ReleaseUri -Method Get -Headers $script:sharedData.Header -ContentType 'application/zip' -OutFile "$DownloadPath/Release-$($param.ReleaseUrl.Split('/')[-1]).zip"
    }
    catch {
        throw $_
    }
}
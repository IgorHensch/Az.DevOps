function Start-DownloadAzDevOpsReleasesLog {
    <#
    .SYNOPSIS
        Download Azure DevOps Release Logs.
    .DESCRIPTION
        Download Release Logs from Azure Devops Releases.
    .LINK
        Get-AzDevOpsRelease
    .EXAMPLE
        Start-DownloadAzDevOpsReleasesLog -ReleaseUrl 'ReleaseUrl' -DownloadPath 'DownloadPath'
    .EXAMPLE
        Get-AzDevOpsRelease -Project 'ProjectName' -Name 'ReleaseName' | Start-DownloadAzDevOpsReleasesLog -DownloadPath 'DownloadPath'
    #>

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
    process {
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
        $releaseUri = "$($param.ReleaseUrl)/logs?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            $invokeRestMethodParam = @{
                Uri         = $releaseUri
                Method      = 'Get'
                Headers     = $script:sharedData.Header
                ContentType = 'application/zip'
                OutFile     = "$DownloadPath/Release-$($param.ReleaseUrl.Split('/')[-1]).zip"
            }
            Invoke-RestMethod @invokeRestMethodParam
        }
        catch {
            throw $_
        }
    }
}
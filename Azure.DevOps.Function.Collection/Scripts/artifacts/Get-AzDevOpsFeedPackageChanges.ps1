function Get-AzDevOpsFeedPackageChanges {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                FeedName = $FeedName
            }
        }
        'Pipeline' {
            $param = @{
                FeedName = $PipelineObject.name
            }
        }
    }

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $param.FeedName).url
    $FeedPackageChangessUri = "$FeedUrl/packagechanges?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $FeedPackageChangessUri -Method Get -Headers $script:sharedData.Header).packageChanges.package | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
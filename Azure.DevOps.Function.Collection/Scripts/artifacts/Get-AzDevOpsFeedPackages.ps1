function Get-AzDevOpsFeedPackages {
    [CmdletBinding()]
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
                FeedName      = $FeedName
            }
        }
        'Pipeline' {
            $param = @{
                FeedName      = $PipelineObject.name
            }
        }
    }

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $param.FeedName).url
    $ArtifactFeedsUri = "$FeedUrl/packages?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
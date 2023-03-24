function Get-AzDevOpsFeedViews {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $FeedViewsUri = "$FeedUrl/views?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $FeedViewsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
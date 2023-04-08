function Get-AzDevOpsFeedViews {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $feedViewsUri = "$feedUrl/views?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $feedViewsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
function New-AzDevOpsFeedView {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Visibility = "collection",
        [string]$Type = "release"
    )

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $FeedViewsUri = "$FeedUrl/views?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        visibility = $Visibility
        name       = $Name
        type       = $Type
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $FeedViewsUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
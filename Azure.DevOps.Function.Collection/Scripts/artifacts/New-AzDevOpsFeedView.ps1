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
    $feedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $feedViewsUri = "$FeedUrl/views?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        visibility = $Visibility
        name       = $Name
        type       = $Type
    }
    $body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $feedViewsUri -Body $body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
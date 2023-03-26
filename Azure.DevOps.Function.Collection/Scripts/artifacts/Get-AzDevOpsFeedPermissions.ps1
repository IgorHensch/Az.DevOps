function Get-AzDevOpsFeedPermissions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $FeedPermissionsUri = "$FeedUrl/permissions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $FeedPermissionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
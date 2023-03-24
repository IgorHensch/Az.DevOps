function Get-AzDevOpsRecycleBinFeedPackages {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $RecycleBinPackagesUri = "$FeedUrl/RecycleBin/Packages?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $RecycleBinPackagesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
function Get-AzDevOpsRecycleBinFeedPackages {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $recycleBinPackagesUri = "$feedUrl/RecycleBin/Packages?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $recycleBinPackagesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
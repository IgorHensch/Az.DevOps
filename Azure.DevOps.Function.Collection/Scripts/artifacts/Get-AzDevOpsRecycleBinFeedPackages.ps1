function Get-AzDevOpsRecycleBinFeedPackages {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feed Packages
    .DESCRIPTION
        Gets deleted Feed Packages from Azure Devops Artifact Recycle Bin.
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackages -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackages -FeedName 'FeedName' -Name 'PackageName'
    #>

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
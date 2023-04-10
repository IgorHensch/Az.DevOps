function Get-AzDevOpsRecycleBinFeedPackage {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feed Packages.
    .DESCRIPTION
        Gets deleted Feed Packages from Azure Devops Artifact Recycle Bin.
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackage -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackage -FeedName 'FeedName' -Name 'PackageName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeed -Name $FeedName).url
    $recycleBinPackagesUri = "$feedUrl/RecycleBin/Packages?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $recycleBinPackagesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
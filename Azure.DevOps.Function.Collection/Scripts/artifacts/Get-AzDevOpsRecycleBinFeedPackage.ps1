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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get($feedUrl, 'RecycleBin/Packages', $script:sharedData.ApiVersionPreview, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
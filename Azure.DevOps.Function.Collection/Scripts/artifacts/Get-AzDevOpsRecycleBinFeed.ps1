function Get-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feeds.
    .DESCRIPTION
        Gets deleted Feeds from Azure Devops Artifact Recycle Bin.
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Project 'ProjectName' -Name 'FeedName'
    #>

    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$Name = '*'
    )
    $recycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/packaging/feedrecyclebin?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $recycleBinFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('packaging/feedrecyclebin', $script:sharedData.ApiVersionPreview, $Project, 'feeds.', $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
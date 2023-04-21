function Get-AzDevOpsFeedChange {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Changes.
    .DESCRIPTION
        Gets Feed Changes from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedChange
    .EXAMPLE
        Get-AzDevOpsFeedChange -Name 'FeedName'
    #>

    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('packaging/feedchanges', $script:sharedData.ApiVersionPreview, $null, 'feeds.', $null)
        Write-Output -InputObject $request.value.feedChanges.feed.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
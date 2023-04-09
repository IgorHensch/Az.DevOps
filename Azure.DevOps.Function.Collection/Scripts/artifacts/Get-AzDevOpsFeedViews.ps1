function Get-AzDevOpsFeedViews {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Views.
    .DESCRIPTION
        Gets Feed Views from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedViews -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedViews -FeedName 'FeedName' -Name 'ViewName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $feedViewsUri = "$feedUrl/views?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $feedViewsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
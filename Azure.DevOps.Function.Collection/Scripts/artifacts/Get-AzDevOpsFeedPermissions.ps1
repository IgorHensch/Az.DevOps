function Get-AzDevOpsFeedPermissions {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Permissions
    .DESCRIPTION
        Gets Feed Permissions from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedPermissions -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPermissions -FeedName 'FeedName' -Role 'administrator'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Role = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
    $feedPermissionsUri = "$FeedUrl/permissions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $feedPermissionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.role -imatch "^$Role$" }
    }
    catch {
        throw $_
    }
}
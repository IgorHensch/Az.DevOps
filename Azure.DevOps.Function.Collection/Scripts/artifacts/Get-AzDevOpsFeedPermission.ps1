function Get-AzDevOpsFeedPermission {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Permissions.
    .DESCRIPTION
        Gets Feed Permission from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedPermission -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPermission -FeedName 'FeedName' -Role 'administrator'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Role = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeed -Name $FeedName).url
    $feedPermissionsUri = "$FeedUrl/permissions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $feedPermissionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.role -imatch "^$Role$" }
    }
    catch {
        throw $_
    }
}
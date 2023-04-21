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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get($feedUrl, 'permissions', $script:sharedData.ApiVersionPreview, $null) 
        Write-Output -InputObject $request.value.where{ $_.role -imatch "^$Role$" }
    }
    catch {
        throw $_
    }
}
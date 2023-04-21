function Get-AzDevOpsFeedView {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Views.
    .DESCRIPTION
        Gets Feed Views from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedView -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedView -FeedName 'FeedName' -Name 'ViewName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Name = '*'
    )
    $feedUrl = (Get-AzDevOpsArtifactFeed -Name $FeedName).url
    try {
        $request = [WebRequestAzureDevOpsCore]::Get($feedUrl, 'views', $script:sharedData.ApiVersionPreview, $null) 
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
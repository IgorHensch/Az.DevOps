function New-AzDevOpsFeedView {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Artifact Feeds View.
    .DESCRIPTION
        Creates new Feeds View in Azure Devops Artifact.
    .EXAMPLE
        New-AzDevOpsFeedView -Name 'FeedName' -Name 'ViewName'
    .EXAMPLE
        New-AzDevOpsFeedView -Name 'FeedName' -Name 'ViewName' -Visibility 'collection' -Type 'release'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$FeedName,
        [string]$Visibility = "collection",
        [string]$Type = "release"
    )
    $feedUrl = (Get-AzDevOpsArtifactFeed -Name $FeedName).url
    $body = @{
        visibility = $Visibility
        name       = $Name
        type       = $Type
    } | ConvertTo-Json -Depth 2
    try {
        $request = [WebRequestAzureDevOpsCore]::Create("$feedUrl/views", $body, $script:sharedData.ApiVersionPreview)
        Write-Output -InputObject $request.value 
    }
    catch {
        throw $_
    }
}
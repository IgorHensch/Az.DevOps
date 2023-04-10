function Get-AzDevOpsArtifactFeed {
    <#
    .SYNOPSIS
        Gets Azure DevOps Artifact Feeds. 
    .DESCRIPTION
        Gets Feeds from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsArtifactFeed
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Project 'ProjectName' -Name 'FeedName'
    #>
    
    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$Name = '*'
    )
    $artifactFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/packaging/Feeds?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $artifactFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('packaging/Feeds', $script:sharedData.ApiVersionPreview, $Project, 'feeds.', $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
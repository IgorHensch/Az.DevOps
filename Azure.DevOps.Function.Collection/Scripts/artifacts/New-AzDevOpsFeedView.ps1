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
    .NOTES
        PAT Permission Scope: vso.packaging_write
        Description: Grants the ability to create and read feeds and packages.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Visibility = "collection",
        [string]$Type = "release"
    )
    end {
        try {
            $Feed = Get-AzDevOpsArtifactFeed -Name $FeedName
            $script:body = @{
                visibility = $Visibility
                name       = $Name
                type       = $Type
            } | ConvertTo-Json -Depth 2
            $script:projectName = $Feed.ProjectName
            $script:feedId = $Feed.Id
            $script:feedName = $Feed.Name
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsFeedView]::Create()
        }
        catch {
            throw $_
        }
    }
}
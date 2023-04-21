function Remove-AzDevOpsArtifactFeed {
    <#
    .SYNOPSIS
        Removes Azure DevOps Artifact Feeds.
    .DESCRIPTION
        Removes Feeds from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeed
    .EXAMPLE
        Remove-AzDevOpsArtifactFeed -FeedName 'FeedName'
    .EXAMPLE
        Remove-AzDevOpsArtifactFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Project 'ProjectName' -Name 'FeedName' | Remove-AzDevOpsArtifactFeed
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    FeedName = $FeedName
                }
            }
            'Pipeline' {
                $param = @{
                    FeedName = $PipelineObject.name
                }
            }
        }
        $feed = Get-AzDevOpsArtifactFeed -Name $param.FeedName
        try {
            $feed
            [WebRequestAzureDevOpsCore]::Delete($feed, $Force, $script:sharedData.ApiVersionPreview).Value
        }
        catch {
            throw $_
        }
    }
}
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
    .NOTES
        PAT Permission Scope: vso.packaging_manage
        Description: Grants the ability to create, read, update, and delete feeds and packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()] 
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
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
        try {
            Write-Output ($feed = Get-AzDevOpsArtifactFeed -Name $param.FeedName)
            $script:projectName = $feed.ProjectName
            $script:feedId = $feed.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($feed, $Force)
        }
        catch {
            throw $_
        }
    }
}
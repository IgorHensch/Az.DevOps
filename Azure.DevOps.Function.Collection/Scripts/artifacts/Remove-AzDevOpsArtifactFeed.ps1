function Remove-AzDevOpsArtifactFeed {
    <#
    .SYNOPSIS
        Removes Azure DevOps Artifact Feeds.
    .DESCRIPTION
        Removes Feeds from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeeds
    .EXAMPLE
        Remove-AzDevOpsArtifactFeed -FeedName 'FeedName'
    .EXAMPLE
        Remove-AzDevOpsArtifactFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsArtifactFeeds -Project 'ProjectName' -Name 'FeedName' | Remove-AzDevOpsArtifactFeed
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
        $feed = Get-AzDevOpsArtifactFeeds -Name $param.FeedName
        $artifactFeedsUri = "$($Feed.url)`?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $artifactFeedsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Feed $($feed.name) has been deleted."
            }
            else {
                $feed
                $title = "Delete $($feed.name) Feed."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $artifactFeedsUri -Method Delete -Headers $script:sharedData.Header
                    Write-Host "Feed $($feed.name) has been deleted."
                }
                else {
                    Write-Host 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
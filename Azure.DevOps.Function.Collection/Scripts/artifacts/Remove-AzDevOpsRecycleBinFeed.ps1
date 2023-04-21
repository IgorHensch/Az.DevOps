function Remove-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Removes Azure DevOps Artifact deleted Feeds.
    .DESCRIPTION
        Removes deleted Feeds from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Remove-AzDevOpsRecycleBinFeed -FeedName 'FeedName'
    .EXAMPLE
        Remove-AzDevOpsRecycleBinFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName' | Remove-AzDevOpsRecycleBinFeed
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
        $feed = Get-AzDevOpsRecycleBinFeed -Name $param.FeedName
        try {
            $feed
            [WebRequestAzureDevOpsCore]::Delete($feed, "packaging/feedrecyclebin/$($feed.id)", $null, $Force, $script:sharedData.ApiVersionPreview, 'feeds.').Value
        }
        catch {
            throw $_
        }
    }
}
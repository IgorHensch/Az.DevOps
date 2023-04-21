function Restore-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Restore Azure DevOps Artifact deleted Feeds.
    .DESCRIPTION
        Restore deleted Feeds from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Restore-AzDevOpsRecycleBinFeed -FeedName 'FeedName'
    .EXAMPLE
        Restore-AzDevOpsRecycleBinFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName' | Restore-AzDevOpsRecycleBinFeed
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
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
        $body = @{
            op    = 'replace'
            path  = '/isDeleted'
            value = $false
        } | ConvertTo-Json -Depth 2 -AsArray
        try {
            [WebRequestAzureDevOpsCore]::Update("packaging/feedrecyclebin/$($feed.id)", $body, 'application/json-patch+json', $null, $script:sharedData.ApiVersion, 'feeds.', $null)
        }
        catch {
            throw $_
        }
    }
}
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
        $recycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedrecyclebin/$($Feed.id)?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $recycleBinFeedsUri -Method Delete -Headers $script:sharedData.Header
                Write-Output "Feed $($feed.name) has been deleted from recycle bin."
            }
            else {
                $feed
                $title = "Delete $($feed.name) Feed from recycle bin."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
            
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $recycleBinFeedsUri -Method Delete -Headers $script:sharedData.Header
                    Write-Output "Feed $($feed.name) has been deleted from recycle bin."
                }
                else {
                    Write-Output 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
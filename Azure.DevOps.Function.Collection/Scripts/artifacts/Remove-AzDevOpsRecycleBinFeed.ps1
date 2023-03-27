function Remove-AzDevOpsRecycleBinFeed {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )

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

    $Feed = Get-AzDevOpsRecycleBinFeeds -Name $param.FeedName
    $RecycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedrecyclebin/$($Feed.id)?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $RecycleBinFeedsUri -Method Delete -Headers $script:sharedData.Header
            Write-Host "Feed $($Feed.name) has been deleted from recycle bin."
        }
        else {
            $Feed
            $title = "Delete $($Feed.name) Feed from recycle bin."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $RecycleBinFeedsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Feed $($Feed.name) has been deleted from recycle bin."
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
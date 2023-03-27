function Remove-AzDevOpsArtifactFeed {
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

    $Feed = Get-AzDevOpsArtifactFeeds -Name $param.FeedName
    $ArtifactFeedsUri = "$($Feed.url)`?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Delete -Headers $script:sharedData.Header
            Write-Host "Feed $($Feed.name) has been deleted."
        }
        else {
            $Feed
            $title = "Delete $($Feed.name) Feed."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Feed $($Feed.name) has been deleted."
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
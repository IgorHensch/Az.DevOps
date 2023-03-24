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
                FeedName      = $FeedName
            }
        }
        'Pipeline' {
            $param = @{
                FeedName      = $PipelineObject.name
            }
        }
    }

    $FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $param.FeedName).url
    $ArtifactFeedsUri = "$FeedUrl`?api-version=$($script:sharedData.ApiVersion)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Delete -Headers $script:sharedData.Header
        }
        else {
            $response = Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Get -Headers $script:sharedData.Header
            $response
            $title = "Delete $($response.name) Feed."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $ArtifactFeedsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Feed $($response.name) has been deleted."
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
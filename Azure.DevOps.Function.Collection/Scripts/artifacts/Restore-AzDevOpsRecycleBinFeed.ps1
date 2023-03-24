function Restore-AzDevOpsRecycleBinFeed {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
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

    $Feed = Get-AzDevOpsRecycleBinFeeds -Name $param.FeedName
    $RecycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedrecyclebin/$($Feed.id)?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        op = 'replace'
        path = '/isDeleted'
        value = $false
    }
    $Body = $bodyData | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $RecycleBinFeedsUri -Body "[$Body]" -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json-patch+json'
        Write-Host "Feed $($param.FeedName) has been successfully restored!" -ForegroundColor Green
    }
    catch {
        throw $_
    }
}
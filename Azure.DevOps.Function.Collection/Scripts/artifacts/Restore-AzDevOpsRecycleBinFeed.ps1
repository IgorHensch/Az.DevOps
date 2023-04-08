function Restore-AzDevOpsRecycleBinFeed {
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
        $feed = Get-AzDevOpsRecycleBinFeeds -Name $param.FeedName
        $recycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedrecyclebin/$($feed.id)?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            op    = 'replace'
            path  = '/isDeleted'
            value = $false
        }
        $body = $bodyData | ConvertTo-Json -AsArray
        try {
            Invoke-RestMethod -Uri $recycleBinFeedsUri -Body $body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json-patch+json'
            Write-Host "Feed $($param.FeedName) has been successfully restored!" -ForegroundColor Green
        }
        catch {
            throw $_
        }
    }
}
function Get-AzDevOpsFeedPackageChanges {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
                }
            }
            'Pipeline' {
                $param = @{
                    FeedUrl = $PipelineObject.url
                }
            }
        }
        $feedPackageChangessUri = "$($param.FeedUrl)/packagechanges?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $feedPackageChangessUri -Method Get -Headers $script:sharedData.Header).packageChanges.package | Where-Object { $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
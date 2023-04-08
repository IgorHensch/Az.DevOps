function Get-AzDevOpsPackageBadge {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PackageName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    PackageUrl = (Get-AzDevOpsFeedPackages -FeedName $FeedName -Name $PackageName).url
                }
            }
            'Pipeline' {
                $param = @{
                    PackageUrl = $PipelineObject.url
                }
            }
        }
        $packageBadgeUri = "$($param.PackageUrl)/badge?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -ContentType 'image/svg+xml' -Uri $packageBadgeUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
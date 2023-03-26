function Get-AzDevOpsRecycleBinFeedPackageVersions {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PackageName,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [string]$Version = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
        
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                RecycleBinFeedPackageUrl = (Get-AzDevOpsRecycleBinFeedPackages -FeedName $FeedName -name $PackageName).url
                PackageName              = $PackageName
            }
        }
        'Pipeline' {
            $param = @{
                RecycleBinFeedPackageUrl = $PipelineObject.url
                PackageName              = $PipelineObject.name
            }
        }
    }

    $RecycleBinFeedPackageVersions = "$($param.RecycleBinFeedPackageUrl)/Versions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $RecycleBinFeedPackageVersions -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Version$" }
    }
    catch {
        throw $_
    }
}
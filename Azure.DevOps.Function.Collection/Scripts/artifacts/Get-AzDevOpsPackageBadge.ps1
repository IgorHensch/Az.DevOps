function Get-AzDevOpsPackageBadge {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PackageName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

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

    $PackageBadgeUri = "$($param.PackageUrl)/badge?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -ContentType 'image/svg+xml' -Uri $PackageBadgeUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
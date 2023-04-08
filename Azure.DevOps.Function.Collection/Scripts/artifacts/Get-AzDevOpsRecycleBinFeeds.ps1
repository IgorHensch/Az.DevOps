function Get-AzDevOpsRecycleBinFeeds {
    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$Name = '*'
    )
    $recycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/packaging/feedrecyclebin?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $recycleBinFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
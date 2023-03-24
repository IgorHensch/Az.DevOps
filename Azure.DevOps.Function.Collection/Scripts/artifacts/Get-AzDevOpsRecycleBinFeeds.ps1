function Get-AzDevOpsRecycleBinFeeds {
    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$Name = '*'
    )

    $RecycleBinFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/packaging/feedrecyclebin?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $RecycleBinFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
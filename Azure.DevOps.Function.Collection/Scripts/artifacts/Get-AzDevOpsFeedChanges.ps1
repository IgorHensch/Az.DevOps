function Get-AzDevOpsFeedChanges {
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )

    $FeedChangesUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedchanges?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $FeedChangesUri -Method Get -Headers $script:sharedData.Header).feedChanges.feed | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
function Get-AzDevOpsReleases {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name
    )

    $ReleaseUri = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/release/releases?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $ReleaseUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "\b$Name\b" }
    }
    catch {
        throw $_
    }
}
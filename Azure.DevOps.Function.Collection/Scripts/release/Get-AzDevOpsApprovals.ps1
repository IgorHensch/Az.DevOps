function Get-AzDevOpsApprovals {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project
    )

    $ApprovalsUri = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/release/approvals?top=200&api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $ApprovalsUri -Method Get -Headers $script:sharedData.Header).value
    }
    catch {
        throw $_
    }
}
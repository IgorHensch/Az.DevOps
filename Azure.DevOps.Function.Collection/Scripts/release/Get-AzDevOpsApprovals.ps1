function Get-AzDevOpsApprovals {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Id = '*'
    )
    $approvalsUri = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/release/approvals?top=200&api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $approvalsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.id -imatch "^$Id$" } | ForEach-Object { $_ | Add-Member @{project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}
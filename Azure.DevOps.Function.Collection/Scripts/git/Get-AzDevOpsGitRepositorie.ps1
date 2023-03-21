function Get-AzDevOpsGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name
    )

    $GitRepositoriesUri = "https://dev.azure.com/$($script:sharedData.Organization)/$Project/_apis/git/repositories/?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $GitRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch $Name }
    }
    catch {
        throw $_
    }
}
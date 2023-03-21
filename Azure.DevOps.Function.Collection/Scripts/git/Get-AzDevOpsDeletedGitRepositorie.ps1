function Get-AzDevOpsDeletedGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name
    )

    $DeletedRepositoriesUri = "https://dev.azure.com/$($script:sharedData.Organization)/$Project/_apis/git/deletedrepositories?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $DeletedRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch $Name }
    }
    catch {
        throw $_
    }
}
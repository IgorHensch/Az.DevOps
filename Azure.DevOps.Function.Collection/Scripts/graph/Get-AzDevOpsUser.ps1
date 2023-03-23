function Get-AzDevOpsUser {
    [CmdletBinding()]
    param (
        [string]$PrincipalName = '*'
    )

    $UsersUri = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/graph/users?api-version=$($script:sharedData.ApiVersion)&subjectTypes=aad&continuationToken="
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $UsersUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.principalName -imatch "^$PrincipalName$" }
    }
    catch {
        throw $_
    }
}
function Get-AzDevOpsUser {
    [CmdletBinding()]
    param (
        [string]$PrincipalName = '*'
    )
    $usersUri = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/graph/users?api-version=$($script:sharedData.ApiVersionPreview)&subjectTypes=aad&continuationToken="
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $usersUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.principalName -imatch "^$PrincipalName$" }
    }
    catch {
        throw $_
    }
}
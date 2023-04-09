function Get-AzDevOpsUser {
    <#
    .SYNOPSIS
        Gets Azure DevOps User.
    .DESCRIPTION
        Gets User from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsUser
    .EXAMPLE
        Get-AzDevOpsUser -PrincipalName 'PrincipalName'
    #>

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
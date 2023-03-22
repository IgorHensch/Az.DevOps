function Get-AzDevOpsSoftDeletedGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name
    )

    $SoftDeletedGitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/recycleBin/repositories?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $SoftDeletedGitRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "\b$Name\b" }
    }
    catch {
        throw $_
    }
}
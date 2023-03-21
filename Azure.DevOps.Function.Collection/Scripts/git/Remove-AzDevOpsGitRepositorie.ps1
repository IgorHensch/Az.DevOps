function Remove-AzDevOpsGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$RepositoryId
    )

    $GitRepositoriesUri = "https://dev.azure.com/$($script:sharedData.Organization)/$Project/_apis/git/repositories/$RepositoryId`?api-version=$($script:sharedData.ApiVersion)"
    try {
        Invoke-RestMethod -Uri $GitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
    }
    catch {
        throw $_
    }
}
function Restore-AzDevOpsSoftDeletedGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$RepositoryId
    )

    $SoftDeletedGitRepositoriesUri = "https://dev.azure.com/$($script:sharedData.Organization)/$Project/_apis/git/recycleBin/repositories/$RepositoryId`?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        deleted = 'false'
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $SoftDeletedGitRepositoriesUri -Body $Body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
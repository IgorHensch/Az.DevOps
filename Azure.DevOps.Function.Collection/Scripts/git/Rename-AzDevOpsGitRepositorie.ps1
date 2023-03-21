function Rename-AzDevOpsGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true)]
        [string]$NewName
    )

    $GitRepositoriesUri = "https://dev.azure.com/$($script:sharedData.Organization)/$Project/_apis/git/repositories/$RepositoryId`?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        name = $NewName
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        $Body 
        Invoke-RestMethod -Uri $GitRepositoriesUri -Body $Body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
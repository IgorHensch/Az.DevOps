function Get-AzDevOpsDeletedGitRepositories {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Git Repositories.
    .DESCRIPTION
        Gets deleted Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositories -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositories -Project 'ProjectName' -Name 'RepositorieName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $deletedRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/deletedrepositories?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $deletedRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
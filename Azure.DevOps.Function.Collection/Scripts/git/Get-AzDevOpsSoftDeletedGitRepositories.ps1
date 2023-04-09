function Get-AzDevOpsSoftDeletedGitRepositories {
    <#
    .SYNOPSIS
        Gets Azure DevOps soft deleted Git Repositories.
    .DESCRIPTION
        Gets soft deleted Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsSoftDeletedGitRepositories -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsSoftDeletedGitRepositories -Project 'ProjectName' -Name 'RepositorieName'
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $softDeletedGitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/recycleBin/repositories?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $softDeletedGitRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
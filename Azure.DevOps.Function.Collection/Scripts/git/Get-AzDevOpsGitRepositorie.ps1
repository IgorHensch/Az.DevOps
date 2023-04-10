function Get-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Repositories.
    .DESCRIPTION
        Gets Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $gitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/repositories/?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $gitRepositoriesUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
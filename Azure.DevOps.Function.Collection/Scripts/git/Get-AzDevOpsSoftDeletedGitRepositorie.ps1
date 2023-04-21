function Get-AzDevOpsSoftDeletedGitRepositorie {
    <#
    .SYNOPSIS
        Gets Azure DevOps soft deleted Git Repositories.
    .DESCRIPTION
        Gets soft deleted Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsSoftDeletedGitRepositorie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsSoftDeletedGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('git/recycleBin/repositories', $script:sharedData.ApiVersionPreview, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}
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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('git/repositories', $script:sharedData.ApiVersion, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}
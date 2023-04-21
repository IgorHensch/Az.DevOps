function Get-AzDevOpsDeletedGitRepositorie {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Git Repositories.
    .DESCRIPTION
        Gets deleted Git Repositories from Azure Devops Repos.
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositorie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsDeletedGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('git/deletedrepositories', $script:sharedData.ApiVersionPreview, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}

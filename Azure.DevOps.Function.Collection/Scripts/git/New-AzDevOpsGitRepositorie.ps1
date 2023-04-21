function New-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Git Repositorie.
    .DESCRIPTION
        Creates new Git Repositorie in Azure Devops Repos.
    .EXAMPLE
        New-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    $body = @{
        name    = $Name
        project = @{ 
            id = (Get-AzDevOpsProject -Name $Project).id
        }
    } | ConvertTo-Json -Depth 3
    try {
        $request = [WebRequestAzureDevOpsCore]::Create($Project, $body, 'git/repositories', $script:sharedData.ApiVersion, $null, $null)
        Write-Output -InputObject $request.value 
    }
    catch {
        throw $_
    }
}
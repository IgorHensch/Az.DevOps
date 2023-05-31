function New-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Git Repositorie.
    .DESCRIPTION
        Creates new Git Repositorie in Azure Devops Repos.
    .EXAMPLE
        New-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    .NOTES
        PAT Permission Scope: vso.code_manage
        Description: Grants the ability to read, update, and delete source code, access metadata about commits, changesets, branches, and other version control artifacts.
        Also grants the ability to create and manage code repositories, create and manage pull requests and code reviews, and to receive notifications about version control
        events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    end {
        try {
            $script:body = @{
                name    = $Name
                project = @{ 
                    id = (Get-AzDevOpsProject -Name $Project).id
                }
            } | ConvertTo-Json -Depth 2
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsGitRepositorie]::Create()
        }
        catch {
            throw $_
        }
    }
}
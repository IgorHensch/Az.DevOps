function Restore-AzDevOpsSoftDeletedGitRepositorie {
    <#
    .SYNOPSIS
        Restore Azure DevOps Git Repositorie.
    .DESCRIPTION
        Restore Git Repositorie from Azure Devops Soft Deleted Repos.
    .LINK
        Get-AzDevOpsSoftDeletedGitRepositorie
    .EXAMPLE
        Restore-AzDevOpsSoftDeletedGitRepositorie -Project 'ProjectName' -RepositoryId 'RepositoryId'
    .EXAMPLE
        Get-AzDevOpsSoftDeletedGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Restore-AzDevOpsSoftDeletedGitRepositorie
    .NOTES
        PAT Permission Scope: vso.code_manage
        Description: Grants the ability to read, update, and delete source code, access metadata about commits, changesets, branches, and other version control artifacts.
        Also grants the ability to create and manage code repositories, create and manage pull requests and code reviews, and to receive notifications about version control
        events via service hooks.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project      = $Project
                    RepositoryId = $RepositoryId
                }
            }
            'Pipeline' {
                $param = @{
                    Project      = $PipelineObject.Project
                    RepositoryId = $PipelineObject.Id
                }
            }
        }
        try {
            $script:body = @{
                deleted = 'false'
            } | ConvertTo-Json -Depth 2
            $script:projectName = $param.Project
            $script:deletedRepositoryId = $param.RepositoryId
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::InvokeRequest()
        }
        catch {
            throw $_
        }
    }
}
function Get-AzDevOpsGitCommitList {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Commits.
    .DESCRIPTION
        Gets Git Commits from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Get-AzDevOpsGitCommit -Project 'ProjectName' -RepositorieName 'RepositorieName'
    .EXAMPLE
        Get-AzDevOpsGitCommit -Project 'ProjectName' -RepositorieName 'RepositorieName' -CommitId 'CommitId'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Get-AzDevOpsGitCommit
    .NOTES
        PAT Permission Scope: vso.code
        Description: Grants the ability to read source code and metadata about commits, changesets, branches, and other version control artifacts.
        Also grants the ability to search code and get notified about version control events via service hooks.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$RepositorieName,
        [string]$CommitId = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $param = @{
                        Project         = $Project
                        RepositorieName = $RepositorieName
                    }
                }
                'Pipeline' {
                    $param = @{
                        Project         = $PipelineObject.project
                        RepositorieName = $PipelineObject.name
                    }
                }
            }
            $script:projectName = $param.Project
            $script:repositorieName = $param.RepositorieName
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsGitCommitList]::Get().where{ $_.CommitId -imatch "^$CommitId$" }
            [AzureDevOpsGitCommitList]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }
}
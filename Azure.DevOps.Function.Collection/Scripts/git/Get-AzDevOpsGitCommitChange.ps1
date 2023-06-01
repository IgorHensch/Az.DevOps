function Get-AzDevOpsGitCommitChange {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Commit Changes.
    .DESCRIPTION
        Gets Git Commit Changes from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitCommitList
    .EXAMPLE
        Get-AzDevOpsGitCommitChange -Project 'ProjectName' -RepositorieName 'RepositorieName' -CommitId 'CommitId'
    .EXAMPLE
        Get-AzDevOpsGitCommitList -Project 'ProjectName' -RepositorieName 'RepositorieName' -CommitId 'CommitId' | Get-AzDevOpsGitCommitChange
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
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [int]$CommitId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $param = @{
                        Project     = $Project 
                        Repositorie = $RepositorieName
                        CommitId    = $CommitId
                    }
                }
                'Pipeline' {
                    $param = @{
                        Project     = $PipelineObject.Project
                        Repositorie = $PipelineObject.Repositorie
                        CommitId    = $PipelineObject.CommitId
                    }
                }
            }
            $script:commitId = $param.CommitId
            $script:repositorieName = $param.Repositorie
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsGitCommitChange]::Get()
        }
        catch {
            throw $_
        }
    }
}
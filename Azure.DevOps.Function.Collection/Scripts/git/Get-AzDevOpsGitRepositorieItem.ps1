function Get-AzDevOpsGitRepositorieItem {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Items.
    .DESCRIPTION
        Gets Git Items from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Get-AzDevOpsGitRepositorieItem -Project 'ProjectName' -RepositorieName 'RepositorieName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Get-AzDevOpsGitRepositorieItem
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
        [string]$Path = '*',
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
            $script:repositorieName = $param.RepositorieName
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsGitRepositorieItem]::Get().where{ $_.Path -imatch "^$Path$" }
            [AzureDevOpsGitRepositorieItem]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }
}
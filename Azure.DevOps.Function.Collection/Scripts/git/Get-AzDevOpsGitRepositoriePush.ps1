function Get-AzDevOpsGitRepositoriePush {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Pushes.
    .DESCRIPTION
        Gets Git Pushes from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Get-AzDevOpsGitRepositoriePush -Project 'ProjectName' -RepositorieName 'RepositorieName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Get-AzDevOpsGitRepositoriePush
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
            [AzureDevOpsGitRepositoriePush]::Get()
        }
        catch {
            throw $_
        }
    }
}
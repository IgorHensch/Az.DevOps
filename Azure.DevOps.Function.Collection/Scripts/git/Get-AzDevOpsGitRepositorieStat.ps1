function Get-AzDevOpsGitRepositorieStat {
    <#
    .SYNOPSIS
        Gets Azure DevOps Git Stats.
    .DESCRIPTION
        Gets Git Stats from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Get-AzDevOpsGitRepositorieStat -Project 'ProjectName' -RepositorieName 'RepositorieName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorieStat -Project 'ProjectName' -RepositorieName 'RepositorieName' -Name 'StatName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Get-AzDevOpsGitRepositorieStat
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
        [string]$Name = '*',
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
            [AzureDevOpsGitRepositorieStat]::Get().where{ $_.Name -imatch "^$Name$" }
            [AzureDevOpsGitRepositorieStat]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }
}
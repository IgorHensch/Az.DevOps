function Rename-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Rename Azure DevOps Git Repositorie.
    .DESCRIPTION
        Rename Git Repositorie in Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Rename-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' -NewName 'NewName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Rename-AzDevOpsGitRepositorie -NewName 'NewName'
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
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [string]$NewName
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project = $Project
                    Name    = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.Project
                    Name    = $PipelineObject.Name
                }
            }
        }
        try {
            $script:gitRepositorieId = (Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name).Id
            $script:body = @{
                name = $NewName
            } | ConvertTo-Json -Depth 2
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsGitRepositorie]::new([AzureDevOps]::InvokeRequest())
        }
        catch {
            throw $_
        }
    }
}
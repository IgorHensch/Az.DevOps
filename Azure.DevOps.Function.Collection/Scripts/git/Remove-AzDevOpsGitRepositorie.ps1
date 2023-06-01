function Remove-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Removes Azure DevOps Git Repositorie.
    .DESCRIPTION
        Removes Git Repositorie from Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositorie
    .EXAMPLE
        Remove-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' | Remove-AzDevOpsGitRepositorie
    .EXAMPLE
        Get-AzDevOpsGitRepositorie -Project 'ProjectName' | Remove-AzDevOpsGitRepositorie
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
        [switch]$Force
    )
    process {
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
            Write-Output ($gitRepositorie = Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name)
            $script:projectName = $param.Project
            $script:gitRepositorieId = $gitRepositorie.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($gitRepositorie, $Force)
        }
        catch {
            throw $_
        }
    }
}

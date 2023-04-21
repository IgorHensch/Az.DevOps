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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'General')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Pipeline')]
        [string]$NewName
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    Project = $Project
                    Name    = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.project.name
                    Name    = $PipelineObject.name
                }
            }
        }
        $gitRepositorieUrl = (Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name).url
        $body = @{
            name = $NewName
        } | ConvertTo-Json -Depth 2
        try {
            [WebRequestAzureDevOpsCore]::Update($gitRepositorieUrl, $body, $script:sharedData.ApiVersion)
        }
        catch {
            throw $_
        }
    }
}
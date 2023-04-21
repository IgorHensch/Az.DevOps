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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
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
        $gitRepositorie = Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name
        try {
            $gitRepositorie
            [WebRequestAzureDevOpsCore]::Delete($gitRepositorie, $Force, $script:sharedData.ApiVersion).Value
        }
        catch {
            throw $_
        }
    }
}

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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$RepositoryId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    Project      = $Project
                    RepositoryId = $RepositoryId
                }
            }
            'Pipeline' {
                $param = @{
                    Project      = $PipelineObject.project.name
                    RepositoryId = $PipelineObject.id
                }
            }
        }
        $body = @{
            deleted = 'false'
        } | ConvertTo-Json -Depth 2
        try {
            [WebRequestAzureDevOpsCore]::Update("git/recycleBin/repositories/$($param.RepositoryId)", $body, 'application/json', $param.Project, $script:sharedData.ApiVersion, $null, $null)
        }
        catch {
            throw $_
        }
    }
}
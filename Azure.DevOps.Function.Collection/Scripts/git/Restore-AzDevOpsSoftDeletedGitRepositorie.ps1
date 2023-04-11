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
        $softDeletedGitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/git/recycleBin/repositories/$($param.RepositoryId)`?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            deleted = 'false'
        }
        $body = $bodyData | ConvertTo-Json
        try {
            Invoke-RestMethod -Uri $softDeletedGitRepositoriesUri -Body $body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
        }
        catch {
            throw $_
        }
    }
}
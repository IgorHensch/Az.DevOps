function Rename-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Rename Azure DevOps Git Repositorie.
    .DESCRIPTION
        Rename Git Repositorie in Azure Devops Repos.
    .LINK
        Get-AzDevOpsGitRepositories
    .EXAMPLE
        Rename-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName' -NewName 'NewName'
    .EXAMPLE
        Get-AzDevOpsGitRepositories -Project 'ProjectName' -Name 'RepositorieName' | Rename-AzDevOpsGitRepositorie -NewName 'NewName'
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
        $gitRepositorie = Get-AzDevOpsGitRepositories -Project $param.Project -Name $param.Name
        $gitRepositoriesUri = "$($gitRepositorie.url)?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            name = $NewName
        }
        $body = $bodyData | ConvertTo-Json
        try {
            Invoke-RestMethod -Uri $gitRepositoriesUri -Body $body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
        }
        catch {
            throw $_
        }
    }
}
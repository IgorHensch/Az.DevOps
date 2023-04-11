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
        $gitRepositoriesUri = "$($gitRepositorie.url)?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $gitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
                Write-Output "Git repository $($gitRepositorie.name) has been deleted."
            }
            else {
                $gitRepositorie
                $title = "Delete $($gitRepositorie.name) Git repository."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
            
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $gitRepositoriesUri -Method Delete -Headers $script:sharedData.Header
                    Write-Output "Git repository $($gitRepositorie.name) has been deleted."
                }
                else {
                    Write-Output 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
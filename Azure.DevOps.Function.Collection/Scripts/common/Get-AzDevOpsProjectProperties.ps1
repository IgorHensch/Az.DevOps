function Get-AzDevOpsProjectProperties {
    <#
    .SYNOPSIS
        Gets Azure DevOps Project Properties.
    .DESCRIPTION
        Gets Properties from Azure Devops Project.
    .LINK
        Get-AzDevOpsProjects
    .EXAMPLE
        Get-AzDevOpsProjectProperties -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsProjects -Name 'ProjectName' | Get-AzDevOpsProjectProperties
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    ProjectPropertieUrl = (Get-AzDevOpsProjects -Name $Project).url
                }
            }
            'Pipeline' {
                $param = @{
                    ProjectPropertieUrl = $PipelineObject.url
                }
            }
        }
        $projectPropertiesUri = "$($param.ProjectPropertieUrl)/properties?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $projectPropertiesUri -Method Get -Headers $script:sharedData.Header).value
        }
        catch {
            throw $_
        }
    }
}
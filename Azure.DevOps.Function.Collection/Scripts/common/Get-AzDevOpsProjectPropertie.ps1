function Get-AzDevOpsProjectPropertie {
    <#
    .SYNOPSIS
        Gets Azure DevOps Project Properties.
    .DESCRIPTION
        Gets Propertie from Azure Devops Project.
    .LINK
        Get-AzDevOpsProject
    .EXAMPLE
        Get-AzDevOpsProjectPropertie -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsProject -Name 'ProjectName' | Get-AzDevOpsProjectPropertie
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
                    ProjectPropertieUrl = (Get-AzDevOpsProject -Name $Project).url
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
function Get-AzDevOpsPipeline {
    <#
    .SYNOPSIS
        Gets Azure DevOps Pipelines.
    .DESCRIPTION
        Gets Pipelines from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsPipeline -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsPipeline -Project 'ProjectName' -Name 'PipelineName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('pipelines', $script:sharedData.ApiVersionPreview, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }.foreach{ $_ | Add-Member @{ project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}
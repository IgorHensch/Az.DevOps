function Get-AzDevOpsBuildMetric {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Metrics.
    .DESCRIPTION
        Gets Build Metric from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildMetric -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildMetric -Project 'ProjectName' -Name 'MetricName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('build/metrics', $script:sharedData.ApiVersionPreview, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
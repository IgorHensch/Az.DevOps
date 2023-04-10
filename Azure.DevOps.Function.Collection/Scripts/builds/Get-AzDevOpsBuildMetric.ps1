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
    $buildsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/build/metrics?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $buildsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
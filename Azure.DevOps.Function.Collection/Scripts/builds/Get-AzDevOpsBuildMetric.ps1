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
    .NOTES
        PAT Permission Scope: vso.build
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Name = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildMetric]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}
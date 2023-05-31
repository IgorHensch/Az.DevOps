function Get-AzDevOpsPipelineApproval {
    <#
    .SYNOPSIS
        Gets Azure DevOps Pipeline Approvals.
    .DESCRIPTION
        Gets Pipeline Approvals from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsPipelineApproval -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsPipelineApproval -Project 'ProjectName' -BuildNumber 'BuildNumber'
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
        [string]$BuildNumber = '*'
    )
    end {
        try {
            [AzureDevOpsPipelineApproval]::Get($Project).where{ $_.buildNumber -imatch "^$BuildNumber$" }
        }
        catch {
            throw $_
        }
    }
}
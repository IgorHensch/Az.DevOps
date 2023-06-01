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
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Name = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsPipeline]::Get().where{ $_.name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}
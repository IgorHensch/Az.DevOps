function Get-AzDevOpsBuildResourceUsage {
    <#
    .SYNOPSIS
        Gets Azure DevOps resource usage data.
    .DESCRIPTION
        Gets resource usage data from Azure Devops Organization.
    .EXAMPLE
        Get-AzDevOpsBuildResourceUsage
    .NOTES
        PAT Permission Scope: vso.build
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding()]
    param ()
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildResourceUsage]::Get()
        }
        catch {
            throw $_
        }
    }
}
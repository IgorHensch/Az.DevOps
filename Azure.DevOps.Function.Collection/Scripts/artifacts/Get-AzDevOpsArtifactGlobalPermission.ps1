function Get-AzDevOpsArtifactGlobalPermission {
    <#
    .SYNOPSIS
        Gets Azure DevOps Global Permissions.
    .DESCRIPTION
        Gets Global Permissions from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsArtifactGlobalPermission
    .EXAMPLE
        Get-AzDevOpsArtifactGlobalPermission -Role 'administrator'
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding()]
    param (
        [string]$Role = '*'
    )
    end {
        try {
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsArtifactGlobalPermission]::Get().where{ $_.role -imatch "^$Role$" }
        }
        catch {
            throw $_
        }
    }
}
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
    #>
    
    [CmdletBinding()]
    param (
        [string]$Role = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('packaging/globalpermissions', $script:sharedData.ApiVersionPreview, $Project, 'feeds.', $null)
        Write-Output -InputObject $request.value.where{ $_.role -imatch "^$Role$" }
    }
    catch {
        throw $_
    }
}
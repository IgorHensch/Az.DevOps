function Get-AzDevOpsUser {
    <#
    .SYNOPSIS
        Gets Azure DevOps User.
    .DESCRIPTION
        Gets User from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsUser
    .EXAMPLE
        Get-AzDevOpsUser -PrincipalName 'PrincipalName'
    #>

    [CmdletBinding()]
    param (
        [string]$PrincipalName = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('graph/users', $script:sharedData.ApiVersionPreview, $null, 'vssps.', $null)
        Write-Output -InputObject $request.value.where{ $_.principalName -imatch "^$PrincipalName$" }
    }
    catch {
        throw $_
    }
}
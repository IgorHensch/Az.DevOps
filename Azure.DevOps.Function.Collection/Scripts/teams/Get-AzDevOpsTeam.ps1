function Get-AzDevOpsTeam {
    <#
    .SYNOPSIS
        Gets Azure DevOps Teams.
    .DESCRIPTION
        Gets Teams from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsTeam
    .EXAMPLE
        Get-AzDevOpsTeam -Name 'TeamName'
    #>

    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('teams', $script:sharedData.ApiVersionPreview2, $null, $null, '$mine=false&$top=100&$skip&')
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}
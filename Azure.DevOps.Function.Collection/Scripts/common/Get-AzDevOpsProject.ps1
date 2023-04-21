function Get-AzDevOpsProject {
    <#
    .SYNOPSIS
        Gets Azure DevOps Projects.
    .DESCRIPTION
        Gets Projects from Azure Devops.
    .EXAMPLE
        Get-AzDevOpsProject
    .EXAMPLE
        Get-AzDevOpsProject -Name 'ProjectName'
    #>

    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('projects', $script:sharedData.ApiVersionPreview, $null, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}

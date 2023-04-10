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
    $projectsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $projectsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}
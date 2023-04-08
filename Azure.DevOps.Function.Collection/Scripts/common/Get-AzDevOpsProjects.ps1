function Get-AzDevOpsProjects {
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
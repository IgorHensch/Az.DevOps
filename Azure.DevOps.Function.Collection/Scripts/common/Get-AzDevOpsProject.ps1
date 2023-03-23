function Get-AzDevOpsProject {
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )

    $ProjectsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $ProjectsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}
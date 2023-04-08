function Get-AzDevOpsBuilds {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Id = '*'
    )
    $buildsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/build/builds?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $buildsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.id -imatch "^$Id$" }
    }
    catch {
        throw $_
    }
}
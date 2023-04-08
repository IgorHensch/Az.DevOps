function Get-AzDevOpsTeams {
    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    $teamsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/teams?$mine=false&$top=100&$skip&api-version=$($script:sharedData.ApiVersionPreview2)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $teamsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}
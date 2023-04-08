function Get-AzDevOpsArtifactGlobalPermissions {
    [CmdletBinding()]
    param (
        [string]$Role = '*'
    )
    $globalPermissionsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/globalpermissions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $globalPermissionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.role -imatch "^$Role$" }
    }
    catch {
        throw $_
    }
}
function Get-AzDevOpsVariableGroups {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )

    $VariablegroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/distributedtask/variablegroups?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $VariablegroupsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" } | ForEach-Object { $_ | Add-Member @{project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}
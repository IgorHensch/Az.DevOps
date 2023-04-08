function Get-AzDevOpsPipelines {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $buildDefinitionsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/pipelines?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $buildDefinitionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" } | ForEach-Object { $_ | Add-Member @{ project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}
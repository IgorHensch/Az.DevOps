function New-AzDevOpsTeams {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$Description
    )
    $projectUrl = (Get-AzDevOpsProject -Name $Project).url
    $teamsUri = "$ProjectUrl/teams?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        name        = $Name
        description = $Description
    }
    $body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $teamsUri -Body $body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
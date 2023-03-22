function Connect-AzDevOps {
    [CmdletBinding()]
    param (        
        [Parameter(Mandatory = $true)]
        [string]$PersonalAccessToken,
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [string]$ApiVersion = '7.1-preview.1',
        [string]$CoreServer = 'dev.azure.com'
    )

    $header = @{Authorization = ("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $null, $PersonalAccessToken)))) }
    $script:sharedData = @{
        Header       = $header
        Organization = $Organization
        ApiVersion   = $ApiVersion
        CoreServer   = $CoreServer
    }
    $ProfileUri = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/profile/profiles/me?api-version=$($script:sharedData.ApiVersion)"
    try {
        Invoke-RestMethod -Method Get -Uri $ProfileUri -Headers $script:sharedData.Header
    }
    catch {
        throw $_
    }
}
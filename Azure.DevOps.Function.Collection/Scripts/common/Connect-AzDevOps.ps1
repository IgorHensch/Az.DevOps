function Connect-AzDevOps {
    [CmdletBinding()]
    param (        
        [Parameter(Mandatory = $true)]
        [string]$PersonalAccessToken,
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [string]$ApiVersion = '7.0',
        [string]$ApiVersionPreview = '7.1-preview.1',
        [string]$ApiVersion1Preview2 = '7.1-preview.2',
        [string]$CoreServer = 'dev.azure.com'
    )

    $header = @{Authorization = ("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $null, $PersonalAccessToken)))) }
    $script:sharedData = @{
        Header             = $header
        Organization       = $Organization
        ApiVersion         = $ApiVersion
        ApiVersionPreview  = $ApiVersionPreview
        ApiVersionPreview2 = $ApiVersionPreview2
        CoreServer         = $CoreServer
    }
    $ProfileUri = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/profile/profiles/me?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Invoke-RestMethod -Method Get -Uri $ProfileUri -Headers $script:sharedData.Header
    }
    catch {
        throw $_
    }
}
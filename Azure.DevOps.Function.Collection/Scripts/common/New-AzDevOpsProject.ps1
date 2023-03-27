function New-AzDevOpsProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$Description,
        [string]$Visibility = 'private',
        [string]$SourceControlType = 'Git',
        [string]$TemplateTypeId = '6b724908-ef14-45cf-84f8-768b5384da45'
    )

    $ProjectUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        name         = $Name
        description  = $Description
        visibility   = $Visibility
        capabilities = @{
            versioncontrol  = @{
                sourceControlType = $SourceControlType
            }
            processTemplate = @{
                templateTypeId = $TemplateTypeId
            }
        }
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $ProjectUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}


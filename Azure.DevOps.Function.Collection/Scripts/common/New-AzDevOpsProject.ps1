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
    $projectUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects?api-version=$($script:sharedData.ApiVersion)"
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
    $body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $projectUri -Body $body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}


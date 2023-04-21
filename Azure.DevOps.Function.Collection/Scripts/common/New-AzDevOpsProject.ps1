function New-AzDevOpsProject {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Project.
    .DESCRIPTION
        Creates new Project in Azure Devops.
    .EXAMPLE
        New-AzDevOpsProject -Name 'ProjectName'
    .EXAMPLE
        New-AzDevOpsProject -Name 'ProjectName' -Description 'Description' -Visibility 'private' -SourceControlType 'Git' -TemplateTypeId '6b724908-ef14-45cf-84f8-768b5384da45'
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$Description,
        [string]$Visibility = 'private',
        [string]$SourceControlType = 'Git',
        [string]$TemplateTypeId = '6b724908-ef14-45cf-84f8-768b5384da45'
    )
    $body = @{
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
    } | ConvertTo-Json -Depth 4
    try {
        $request = [WebRequestAzureDevOpsCore]::Create($null, $body, 'projects', $script:sharedData.ApiVersion, $null, $null)
        Write-Output -InputObject $request.value 
    }
    catch {
        throw $_
    }
}

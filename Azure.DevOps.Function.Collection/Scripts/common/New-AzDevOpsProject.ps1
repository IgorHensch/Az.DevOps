function New-AzDevOpsProject {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Project.
    .DESCRIPTION
        Creates new Project in Azure Devops.
    .EXAMPLE
        New-AzDevOpsProject -Name 'ProjectName'
    .EXAMPLE
        New-AzDevOpsProject -Name 'ProjectName' -Description 'Description' -Visibility 'private' -SourceControlType 'Git' -ProcessTemplate 'Scrum'
    .NOTES
        PAT Permission Scope: vso.project_manage
        Description: Grants the ability to create, read, update, and delete projects and teams.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [string]$Description,
        [ValidateSet('private', 'public')]
        [string]$Visibility = 'private',
        [ValidateSet('Git', 'Tfvc')]
        [string]$SourceControlType = 'Git',
        [ValidateSet('Agile', 'Basic', 'CMMI', 'Scrum')]
        [string]$ProcessTemplate = 'Scrum'
    )
    end {
        try {
            $script:body = @{
                name         = $Name
                description  = $Description
                visibility   = $Visibility
                capabilities = @{
                    versioncontrol  = @{
                        sourceControlType = $SourceControlType
                    }
                    processTemplate = @{
                        templateTypeId = [AzureDevOpsProcessTemplate]::GetTemplateTypeId($ProcessTemplate)
                    }
                }
            } | ConvertTo-Json -Depth 2
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsProject]::Create()
        }
        catch {
            throw $_
        }
    }
}

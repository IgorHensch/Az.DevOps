function New-AzDevOpsVariableGroup {
    <#
    .SYNOPSIS
        Creates Azure DevOps Variable Group.
    .DESCRIPTION
        Creates Variable Group in Azure Devops Library.
    .EXAMPLE
        New-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableName 'VariableName' -VariableValue 'VariableValue'
    .EXAMPLE
        New-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableName 'VariableName' -VariableValue 'VariableValue' -IsSecret
    .EXAMPLE
        New-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableCollectionJson '[{"VariableName": {"value": "VariableValue", "isSecret": false}}]'
    .NOTES
        PAT Permission Scope: vso.variablegroups_write
        Description: Grants the ability to read and create variable groups.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'JSON')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(ParameterSetName = 'JSON')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [string]$Description,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$VariableName,
        [Parameter(ParameterSetName = 'Default')]
        [switch]$IsSecret,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$VariableValue,
        [Parameter(Mandatory, ParameterSetName = 'JSON')]
        [ValidateScript(
            {
                [VarGroupJsonSchema]$_
            },
            ErrorMessage = 'The JSON has incorrect schema.')]
        [string]$VariableCollectionJson
    )
    end {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $script:body = @{
                        variables   = @{
                            $VariableName = @{
                                value    = $VariableValue
                                isSecret = $IsSecret.IsPresent
                            }
                        }
                        createdBy   = @{
                            
                        }
                        name        = $Name
                        type        = 'Vsts'
                        description = $Description
                    } | ConvertTo-Json -Depth 10
                }
                'JSON' {
                    $VariableCollectionHashtable = $VariableCollectionJSON | ConvertFrom-Json | ConvertTo-PSFHashtable
                    $script:body = @{
                        variables   = $VariableCollectionHashtable
                        name        = $Name
                        type        = 'Vsts'
                        description = $Description
                    } | ConvertTo-Json -Depth 10
                }
            }
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsVariableGroup]::Create()
        }
        catch {
            throw $_
        }
    }
}
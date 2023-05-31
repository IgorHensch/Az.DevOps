function Update-AzDevOpsVariableGroup {
    <#
    .SYNOPSIS
        Updates Azure DevOps Variable Group.
    .DESCRIPTION
        Updates Variable Group in Azure Devops Library.
    .EXAMPLE
        Update-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableName 'VariableName' -VariableValue 'VariableValue'
    .EXAMPLE
        Update-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableName 'VariableName' -VariableValue 'VariableValue' -IsSecret
    .EXAMPLE
        Update-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -VariableCollectionJson '[{"VariableName": {"value": "VariableValue", "isSecret": false}}]'
    .NOTES
        PAT Permission Scope: vso.variablegroups_manage
        Description: Grants the ability to read, create and manage variable groups.
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
            $variableGroup = Get-AzDevOpsVariableGroup -Project $Project -VariableGroupName $Name
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $script:body = @{
                        variables = @{
                            $VariableName = @{
                                value    = $VariableValue
                                isSecret = $IsSecret.IsPresent
                            }
                        }
                        name      = $Name
                        type      = 'Vsts'
                    } | ConvertTo-Json -Depth 10
                }
                'JSON' {
                    $VariableCollectionHashtable = $VariableCollectionJSON | ConvertFrom-Json | ConvertTo-PSFHashtable
                    $script:body = @{
                        variables = $VariableCollectionHashtable
                        name      = $Name
                        type      = 'Vsts'
                    } | ConvertTo-Json -Depth 10
                }
            }
            Write-Debug "Function body data: $($script:body ? $script:body : 'None')"
            $script:projectName = $Project
            $script:variableGroupId = $VariableGroup.VariableGroupId
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsVariableGroup]::Create()
        }
        catch {
            throw $_
        }
    }
}
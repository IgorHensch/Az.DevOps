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
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(ParameterSetName = 'JSON')]
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(ParameterSetName = 'JSON')]
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$VariableName,
        [Parameter(ParameterSetName = 'General')]
        [switch]$IsSecret,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$VariableValue,
        [Parameter(Mandatory, ParameterSetName = 'JSON')]
        [ValidateScript(
            {
                [VarGroupJsonSchema]$_
            },
            ErrorMessage = 'The JSON has incorrect schema.')]
        [string]$VariableCollectionJson
    )
    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $body = @{
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
            $body = @{
                variables = $VariableCollectionHashtable
                name      = $Name
                type      = 'Vsts'
            } | ConvertTo-Json -Depth 10
        }
    }
    try {
        $request = [WebRequestAzureDevOpsCore]::Create($Project, $body, 'distributedtask/variablegroups', $script:sharedData.ApiVersionPreview, $null, $null)
        Write-Output -InputObject $request.value 
    }
    catch {
        throw $_
    }
}
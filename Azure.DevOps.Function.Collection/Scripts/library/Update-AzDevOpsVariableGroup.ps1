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
                $HashTable = $_ | ConvertFrom-Json | ConvertTo-PSFHashtable 
                foreach ($key in $HashTable.Keys) {
                    $HashTable | ForEach-Object {
                        [bool]($key -cmatch '.+') -and ($_.$key | Get-Member -MemberType NoteProperty).Name -Contains 'IsSecret' -and ($_.$key | Get-Member -MemberType NoteProperty).Name -Contains 'Value'
                    }
                }
            },
            ErrorMessage = 'The JSON has incorrect schema.')]
        $VariableCollectionJSON
    )
    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $bodyData = @{
                variables = @{
                    $VariableName = @{
                        value    = $VariableValue
                        isSecret = $IsSecret.IsPresent
                    }
                }
                name      = $Name
                type      = 'Vsts'
            }
        }
        'JSON' {
            $VariableCollectionHashtable = $VariableCollectionJSON | ConvertFrom-Json | ConvertTo-PSFHashtable
            $bodyData = @{
                variables = $VariableCollectionHashtable
                name      = $Name
                type      = 'Vsts'
            }
        }
    }
    $variableGroup = Get-AzDevOpsVariableGroups -Project $Project -Name $Name
    $variableGroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/distributedtask/variablegroups/$($variableGroup.id)?api-version=$($script:sharedData.ApiVersionPreview)"
    $body = $bodyData | ConvertTo-Json -Depth 10
    try {
        Invoke-RestMethod -Uri $variableGroupsUri -Body $body -Method Put -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
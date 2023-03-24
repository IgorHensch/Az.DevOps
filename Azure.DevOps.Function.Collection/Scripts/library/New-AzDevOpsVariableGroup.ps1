function New-AzDevOpsVariableGroup {
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
    
    $VariableCollectionHashtable = $VariableCollectionJSON | ConvertFrom-Json | ConvertTo-PSFHashtable
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
            $bodyData = @{
                variables = $VariableCollectionHashtable
                name      = $Name
                type      = 'Vsts'
            }
        }
    }

    $VariablegroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/distributedtask/variablegroups/?api-version=$($script:sharedData.ApiVersion)"
    $Body = $bodyData | ConvertTo-Json -Depth 10
    try {
        $Body 
        Invoke-RestMethod -Uri $VariablegroupsUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
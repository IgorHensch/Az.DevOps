function Remove-AzDevOpsVariableGroup {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$VariableGroupId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline', ValueFromRemainingArguments)]
        $PipelineObject,
        [switch]$Force
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Project         = $Project
                VariableGroupId = $VariableGroupId
            }
        }
        'Pipeline' {
            $param = @{
                Project         = $PipelineObject.project
                VariableGroupId = $PipelineObject.id
            }
        }
    }

    $VariablegroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/distributedtask/variablegroups/$($param.VariableGroupId)?api-version=$($script:sharedData.ApiVersion)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $VariablegroupsUri -Method Delete -Headers $script:sharedData.Header
        }
        else {
            $response = Invoke-RestMethod -Uri $VariablegroupsUri -Method Get -Headers $script:sharedData.Header
            $response
            $title = "Delete $($response.name) variable group."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $VariablegroupsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Variable group $($response.name) has been deleted."
            }
            else {
                Write-Host 'Canceled!'
            }
        }
    }
    catch {
        throw $_
    }
}
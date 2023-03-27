function Remove-AzDevOpsVariableGroup {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline', ValueFromRemainingArguments)]
        $PipelineObject,
        [switch]$Force
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Project         = $Project
                VariableGroupId = $Name
            }
        }
        'Pipeline' {
            $param = @{
                Project = $PipelineObject.project
                Name    = $PipelineObject.name
            }
        }
    }
    $Variablegroup = Get-AzDevOpsVariableGroups -Project $param.Project -Name $param.Name
    $VariablegroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/distributedtask/variablegroups/$($Variablegroup.id)?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        if ($Force) {
            Invoke-RestMethod -Uri $VariablegroupsUri -Method Delete -Headers $script:sharedData.Header
            Write-Host "Variable group $($Variablegroup.name) has been deleted."
        }
        else {
            $Variablegroup
            $title = "Delete $($Variablegroup.name) variable group."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $VariablegroupsUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Variable group $($Variablegroup.name) has been deleted."
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
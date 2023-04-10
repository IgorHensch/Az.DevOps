function Remove-AzDevOpsVariableGroup {
    <#
    .SYNOPSIS
        Removes Azure DevOps Variable Group.
    .DESCRIPTION
        Removes Variable Group from Azure Devops Library.
    .LINK
        Get-AzDevOpsVariableGroup
    .EXAMPLE
        Remove-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName'
    .EXAMPLE
        Remove-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' -Force
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName' | Remove-AzDevOpsVariableGroup
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName' | Remove-AzDevOpsVariableGroup
    #>

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
    process {
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
        $variableGroup = Get-AzDevOpsVariableGroup -Project $param.Project -Name $param.Name
        $variableGroupsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/distributedtask/variablegroups/$($variableGroup.id)?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            if ($Force) {
                Invoke-RestMethod -Uri $variableGroupsUri -Method Delete -Headers $script:sharedData.Header
                Write-Output "Variable group $($variableGroup.name) has been deleted."
            }
            else {
                $variableGroup
                $title = "Delete $($variableGroup.name) variable group."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
            
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod -Uri $variableGroupsUri -Method Delete -Headers $script:sharedData.Header
                    Write-Output "Variable group $($variableGroup.name) has been deleted."
                }
                else {
                    Write-Output 'Canceled!'
                }
            }
        }
        catch {
            throw $_
        }
    }
}
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
        try {
            $variableGroup = Get-AzDevOpsVariableGroup -Project $param.Project -Name $param.Name
            $variableGroup | Add-Member @{ url = [AzureDevOpsCoreUri]::new("distributedtask/variablegroups/$($variableGroup.id)", $param.Project, $null, $null, $null).Uri -replace '(.+)\?.+', '$1' }
            $variableGroup
            [WebRequestAzureDevOpsCore]::Delete($variableGroup, $Force, $($script:sharedData.ApiVersionPreview)).Value
        }
        catch {
            throw $_
        }
    }
}
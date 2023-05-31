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
    .NOTES
        PAT Permission Scope: vso.variablegroups_manage
        Description: Grants the ability to read, create and manage variable groups.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()] 
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline', ValueFromRemainingArguments)]
        [ValidateNotNullOrEmpty()]
        $PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project         = $Project
                    VariableGroupId = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.Project
                    Name    = $PipelineObject.VariableGroupName
                }
            }
        }
        try {
            Write-Output ($variableGroup = Get-AzDevOpsVariableGroup -Project $param.Project -VariableGroupName $param.Name)
            $script:projectName = $param.Project
            $script:variableGroupId = $VariableGroup.VariableGroupId
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($variableGroup, $Force)
        }
        catch {
            throw $_
        }
    }
}
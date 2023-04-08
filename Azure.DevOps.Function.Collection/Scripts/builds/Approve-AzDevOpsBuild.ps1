function Approve-AzDevOpsBuild {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [string]$Comment,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    ApprovalId = $ApprovalId
                    Project    = $Project
                }
            }
            'Pipeline' {
                $param = @{
                    ApprovalId = $PipelineObject.approvalId
                    Project    = $PipelineObject.project.name
                }
            }
        }
        $approvalsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$($param.Project)/_apis/pipelines/approvals/?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            approvalId = $param.ApprovalId
            status     = 4
            comment    = $Comment
        }
        $body = $bodyData | ConvertTo-Json -AsArray
        try {
            Write-Output -InputObject (Invoke-RestMethod -Uri $approvalsUri -Method Patch -Body $body -Headers $script:sharedData.Header -ContentType 'application/json').value
        }
        catch {
            throw $_
        }
    }
}
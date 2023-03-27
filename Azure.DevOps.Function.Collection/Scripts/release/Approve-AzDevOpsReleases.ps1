function Approve-AzDevOpsReleases {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ApprovalId,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                ApprovalId = $ApprovalId
                Project    = $Project
            }
        }
        'Pipeline' {
            $param = @{
                ApprovalId = $PipelineObject.id
                Project    = PipelineObject.project
            }
        }
    }

    $ApprovalUrl = (Get-AzDevOpsApprovals -Project $param.Project -Id $param.ApprovalId).url
    $ApprovalsUri = "$ApprovalUrl`?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        status = "approved"
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $ApprovalsUri -Method Patch -Body $Body -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}
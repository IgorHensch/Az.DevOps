function Approve-AzDevOpsReleases {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [array]$ApprovalUrls,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                ApprovalUrls = $ApprovalUrls
            }
        }
        'Pipeline' {
            $param = @{
                ApprovalUrls = $PipelineObject.url
            }
        }
    }
    $bodyData = @{
        status = "approved"
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        foreach($url in $param.ApprovalUrls) {
            $ApprovalsUri = "$url?api-version=$($script:sharedData.ApiVersion)"
            Invoke-RestMethod -Uri $ApprovalsUri -Method Patch -Body $Body -Headers $script:sharedData.Header -ContentType 'application/json'
        }
    }
    catch {
        throw $_
    }
}
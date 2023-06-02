class WebRequestAzureDevOpsCore {
    [PSCustomObject]$private:Value
    WebRequestAzureDevOpsCore ($Value) {
        $this.Value = $Value
        $this.ClearScriptVariables()
    }
    static [WebRequestAzureDevOpsCore]Invoke([object]$apiData) {
        if ($null -ne $script:sharedData) {
            $param = @{
                Uri         = "$($apiData.Uri)$($apiData.Query)"
                Method      = $apiData.Mathod
                Body        = $apiData.Body
                Headers     = $script:sharedData.Header
                ContentType = $apiData.ContentType
            }
            if ($apiData.IsValuePath) {
                Write-Debug -Message "Value path"
                Write-Debug -Message "Send $($param.Method.ToUpper()) request to $($param.Uri)"
                Write-Debug -Message "WebRequestAzureDevOpsCore body data: $($script:body ? $script:body : 'None')"
                return (Invoke-RestMethod @param).value
            }
            else {
                Write-Debug -Message "None value path"
                Write-Debug -Message "Send $($param.Method.ToUpper()) request to $($param.Uri)"
                Write-Debug -Message "WebRequestAzureDevOpsCore body data: $($script:body ? $script:body : 'None')"
                return (Invoke-RestMethod @param)
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [void]Remove([PSCustomObject]$object, [object]$apiData, [bool]$force) {
        if ($null -ne $script:sharedData) {
            $param = @{
                Uri         = "$($apiData.Uri)$($apiData.Query)"
                Method      = $apiData.Mathod
                Body        = $apiData.Body
                Headers     = $script:sharedData.Header
                ContentType = $apiData.ContentType
            }
            if ($force) {
                Write-Debug -Message "Send $($param.Method.ToUpper()) request to $($param.Uri)"
            }
            else {
                $title = "Delete $($object.name)."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                $decision = $global:Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Write-Debug -Message "Send $($param.Method.ToUpper()) request to $($param.Uri)"
                    Invoke-RestMethod @param
                }
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
        }
    }
    [void]ClearScriptVariables() {
        $script:function = $null
        $script:body = $null
        $script:projectId = $null
        $script:projectName = $null
        $script:deletedRepositoryId = $null
        $script:gitRepositorieId = $null
        $script:repositorieName = $null
        $script:descriptor = $null
        $script:variableGroupId = $null
        $script:buildId = $null
        $script:definitionId = $null
        $script:Path = $null
        $script:packageId = $null
        $script:teamId = $null
        $script:feedId = $null
        $script:commitId = $null
        $script:buildDefinitionId = $null
        $script:pipelineId = $null
        $script:approvalId = $null
    }
}
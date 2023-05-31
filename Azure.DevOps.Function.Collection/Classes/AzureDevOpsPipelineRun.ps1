class AzureDevOpsPipelineRun {
    [string]$private:Name
    [int]$private:Id
    [string]$private:State
    [string]$private:Result
    $private:CreatedDate
    $private:FinishedDate
    $private:TemplateParameters
    [object]$private:Pipeline
    hidden [object]$private:Raw

    AzureDevOpsPipelineRun($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.State = $Value.state
        $this.Result = $Value.result
        $this.CreatedDate = $Value.createdDate
        $this.TemplateParameters = $Value.templateParameters
        $this.Pipeline = $Value.pipeline
        $this.FinishedDate = $Value.finishedDate
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsPipelineRun[]]Get() {
        $script:project = $script:projectName
        $pipelineRuns = [AzureDevOps]::InvokeRequest()
        $output = $pipelineRuns | ForEach-Object {
            [AzureDevOpsPipelineRun]::new($_)
        }
        return $output
    }
}
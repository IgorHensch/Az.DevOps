class AzureDevOpsBuildMetric {
    [string]$private:Name
    [int]$private:Value
    hidden [object]$private:Raw

    AzureDevOpsBuildMetric($Value) {
        $this.Name = $Value.name
        $this.Value = $Value.intValue
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildMetric[]]Get() {
        $bildMetrics = [AzureDevOps]::InvokeRequest()
        $output = $bildMetrics | ForEach-Object {
            [AzureDevOpsBuildMetric]::new($_)
        }
        return $output
    }
}
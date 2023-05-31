class AzureDevOpsBuildTimeline {
    [string]$private:Id
    [int]$private:ChangeId
    [string]$private:LastChangedBy
    $private:LastChangedOn
    [object]$private:Records
    hidden [object]$private:Raw

    AzureDevOpsBuildTimeline($Value) {
        $this.Id = $Value.id
        $this.ChangeId = $Value.changeId
        $this.LastChangedBy = $Value.lastChangedBy
        $this.LastChangedOn = $Value.lastChangedOn
        $this.Records = $Value.records
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildTimeline[]]Get() {
        $bildTimelines = [AzureDevOps]::InvokeRequest()
        $output = $bildTimelines | ForEach-Object {
            [AzureDevOpsBuildTimeline]::new($_)
        }
        return $output
    }
}
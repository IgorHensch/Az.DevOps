class AzureDevOpsBuildResourceUsage {
    [int]$private:XamlControllers
    [int]$private:DistributedTaskAgents
    [int]$private:TotalUsage
    [int]$private:PaidPrivateAgentSlots
    hidden [object]$private:Raw

    AzureDevOpsBuildResourceUsage($Value) {
        $this.XamlControllers = $Value.xamlControllers
        $this.DistributedTaskAgents = $Value.distributedTaskAgents
        $this.TotalUsage = $Value.totalUsage
        $this.PaidPrivateAgentSlots = $Value.paidPrivateAgentSlots
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildResourceUsage[]]Get() {
        $bildResourceUsage = [AzureDevOps]::InvokeRequest()
        $output = $bildResourceUsage | ForEach-Object {
            [AzureDevOpsBuildResourceUsage]::new($_)
        }
        return $output
    }
}
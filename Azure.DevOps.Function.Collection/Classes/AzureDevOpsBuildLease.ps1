class AzureDevOpsBuildLease {
    [int]$private:LeaseId
    [string]$private:OwnerId
    [int]$private:RunId
    [int]$private:DefinitionId
    $private:CreatedOn
    $private:ValidUntil
    [bool]$private:ProtectPipeline
    hidden [object]$private:Raw

    AzureDevOpsBuildLease($Value) {
        $this.LeaseId = $Value.leaseId
        $this.OwnerId = $Value.ownerId
        $this.RunId = $Value.runId
        $this.DefinitionId = $Value.definitionId
        $this.CreatedOn = $Value.createdOn
        $this.ValidUntil = $Value.validUntil
        $this.ProtectPipeline = $Value.protectPipeline
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildLease[]]Get() {
        $bildLeases = [AzureDevOps]::InvokeRequest()
        $output = $bildLeases | ForEach-Object {
            [AzureDevOpsBuildLease]::new($_)
        }
        return $output
    }
}
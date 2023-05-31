class AzureDevOpsProcess {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Description
    [bool]$private:IsDefault
    [string]$private:Type
    hidden [object]$private:Raw

    AzureDevOpsProcess($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Description = $Value.description
        $this.IsDefault = $Value.isDefault
        $this.Type = $Value.type
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsProcess[]]Get() {
        $process = [AzureDevOps]::InvokeRequest()
        $output = $process | ForEach-Object {
            [AzureDevOpsProcess]::new($_)
        }
        return $output
    }
}
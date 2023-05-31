class AzureDevOpsBuildOptions {
    [int]$private:Ordinal
    [string]$private:Name
    [string]$private:Description
    [object]$private:Inputs
    [object]$private:Groups
    [string]$private:Id
    hidden [object]$private:Raw

    AzureDevOpsBuildOptions($Value) {
        $this.Ordinal = $Value.ordinal
        $this.Name = $Value.name
        $this.Description = $Value.description
        $this.Inputs = $Value.inputs
        $this.Groups = $Value.groups
        $this.Id = $Value.id
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildOptions[]]Get() {
        $bildOptions = [AzureDevOps]::InvokeRequest()
        $output = $bildOptions | ForEach-Object {
            [AzureDevOpsBuildOptions]::new($_)
        }
        return $output
    }
}
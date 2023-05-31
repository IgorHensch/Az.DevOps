class AzureDevOpsPersonalAccessToken {
    [string]$private:DisplayName
    [string]$private:AccessId
    [string]$private:AuthorizationId
    [string]$private:ValidFrom
    [string]$private:ValidTo
    [object]$private:ValidDuration
    [object]$private:ExpireIn
    [string]$private:Scope
    [bool]$private:IsValid
    [bool]$private:isPublic
    hidden [object]$private:Raw

    AzureDevOpsPersonalAccessToken ($Value) {
        $this.DisplayName = $Value.displayName
        $this.AccessId = $Value.accessId
        $this.AuthorizationId = $Value.authorizationId
        $this.ValidFrom = $Value.validFrom
        $this.ValidTo = $Value.validTo
        $this.Scope = $Value.scope
        $this.IsValid = $Value.isValid
        $this.IsPublic = $Value.isPublic
        $this.ValidDuration = [TimeSpan]::new([datetime]$Value.validFrom, [datetime]$Value.validTo).TimeSpan
        $this.ExpireIn = [TimeSpan]::new((Get-Date), [datetime]$Value.validTo).TimeSpan
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsPersonalAccessToken[]]Get() {
        $pats = [AzureDevOps]::InvokeRequest()
        $output = $pats.ForEach{
            [AzureDevOpsPersonalAccessToken]::new($_)
        }
        return $output 
    }
    hidden static [void]Revoke() {
        [AzureDevOps]::InvokeRequest()
    }
}
class AzureDevOpsConnectionProfile {
    [string]$private:DisplayName
    [string]$private:ProfileId
    [string]$private:EmailAddress
    [string]$private:OrganizationUrl
    [string]$private:CoreRevision
    $private:TimeStamp
    [string]$private:CountryName
    hidden [object]$private:Raw

    AzureDevOpsConnectionProfile ([object]$Value) {
        $this.DisplayName = $Value.coreAttributes.DisplayName.value
        $this.ProfileId = $Value.Id
        $this.EmailAddress = $Value.coreAttributes.EmailAddress.value
        $this.CountryName = $Value.coreAttributes.CountryName.value
        $this.CoreRevision = $Value.coreRevision
        $this.TimeStamp = $Value.timeStamp
        $this.OrganizationUrl = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)"
        $this.Raw = $Value
    }
    static [AzureDevOpsConnectionProfile]GetUser() {
        return [AzureDevOps]::InvokeRequest()
    }
}
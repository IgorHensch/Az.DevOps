class AzureDevOpsBuildChange {
    [string]$private:Message
    [string]$private:Id
    [string]$private:Type
    [string]$private:Author
    $private:Timestamp
    [bool]$private:MessageTruncated
    [string]$private:DisplayUri
    [string]$private:PusherId
    hidden [object]$private:Raw

    AzureDevOpsBuildChange([Object]$Value) {
        $this.Message = $Value.message
        $this.Id = $Value.id
        $this.Type = $Value.type
        $this.Author = $Value.author.uniqueName
        $this.Timestamp = $Value.timestamp
        $this.MessageTruncated = $Value.messageTruncated
        $this.DisplayUri = $Value.displayUri
        $this.PusherId = $Value.pusher
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildChange[]]Get() {
        $buildChanges = [AzureDevOps]::InvokeRequest()
        $output = $buildChanges | ForEach-Object {
            [AzureDevOpsBuildChange]::new($_)
        }
        return $output
    }
}
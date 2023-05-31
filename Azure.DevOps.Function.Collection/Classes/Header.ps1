class Header {
    [hashtable] $private:Header
    Header([string]$PAT) {
        $this.header = @{ Authorization = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($null):$PAT")))" }
    }
}
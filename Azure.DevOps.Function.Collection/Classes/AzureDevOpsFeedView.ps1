class AzureDevOpsFeedView {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Type
    [string]$private:Visibility
    hidden [object]$private:Raw

    AzureDevOpsFeedView($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Type = $Value.type
        $this.Visibility = $Value.visibility
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsFeedView[]]Get() {
        $artifactFeedViews = [AzureDevOps]::InvokeRequest()
        $output = $artifactFeedViews | ForEach-Object {
            [AzureDevOpsFeedView]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsFeedView[]]Create() {
        $view = ($script:body | ConvertFrom-Json).name
        $feed = $script:feedName
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            while (-not (Get-AzDevOpsFeedView -FeedName $feed -Name $view)) {}
            return Get-AzDevOpsFeedView -FeedName $feed -Name $view
        }
        else {
            return $null
        }
    }
}
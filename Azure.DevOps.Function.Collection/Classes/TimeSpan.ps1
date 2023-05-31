class TimeSpan {
    [object]$private:TimeSpan
    TimeSpan ([datetime]$StartDate, [datetime]$EndDate) {
        $StartDate = $StartDate
        [int]$Years = [Math]::Truncate($($EndDate.Subtract((Get-Date -Date $StartDate)).Days) / 365)
        [int]$Months = [Math]::Truncate($($EndDate.Subtract((Get-Date -Date $StartDate)).Days) % 365 / 30.46)
        [int]$Days = [Math]::Truncate($($EndDate.Subtract((Get-Date -Date $StartDate)).Days) % 365 % 30.46)
        $this.TimeSpan = [PSCustomObject]@{
            Years  = $Years
            Months = $Months
            Days   = $Days
        }
    }
}
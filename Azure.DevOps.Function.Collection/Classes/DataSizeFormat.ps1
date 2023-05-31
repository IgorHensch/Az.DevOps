class DataSizeFormat {
    $provate:FormatSize
    DataSizeFormat($size) {
        if ($size -lt 1KB) {
            $this.FormatSize = "$size B"
        }
        elseif ($size -lt 1MB) {
            $size = $size / 1KB
            $size = "{0:N2}" -f $size
            $this.FormatSize = "$size KB"
        }
        elseif ($size -lt 1GB) {
            $size = $size / 1MB
            $size = "{0:N2}" -f $size
            $this.FormatSize = "$size MB"
        }
        elseif ($size -lt 1TB) {
            $size = $size / 1GB
            $size = "{0:N2}" -f $size
            $this.FormatSize = "$size GB"
        }
        elseif ($size -lt 1PB) {
            $size = $size / 1TB
            $size = "{0:N2}" -f $size
            $this.FormatSize = "$size TB"
        }
        else {
            $size = $size / 1PB
            $size = "{0:N2}" -f $size
            $this.FormatSize = "$size PB"
        }
    }
}
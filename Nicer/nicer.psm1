<#
    Nicer - Render stuff Nicer...
#>

function ConvertTo-NicerDuration {
    [CmdletBinding()]
    param (
        [int]$seconds
    )
    
    begin {
        
    }
    
    process {
        $return = ("{0:hh\:mm\:ss}" -f ([timespan]::fromseconds( $seconds )))
    }
    
    end {
        return $return
    }
}

Export-ModuleMember `
    -Function `
        ConvertTo-NicerDuration
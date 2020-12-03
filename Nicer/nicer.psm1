<#
    Nicer - Render stuff Nicer...
#>

Function ConvertTo-NicerDuration {
    [CmdletBinding()]
    param (
        [int]$seconds
    )

    $return = ("{0:hh\:mm\:ss}" -f ([timespan]::fromseconds( $seconds )))
    return $return
}

Function ConvertTo-NicerCase {
    [CmdletBinding()]
    param (
        [string]$string
    )

    $ti = (Get-Culture).TextInfo
    return $ti.ToTitleCase( $string.ToLower() )
}
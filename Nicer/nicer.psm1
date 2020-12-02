<#
    Nicer - Render stuff Nicer...
#>

function ConvertTo-NicerDuration {
    [CmdletBinding()]
    param (
        [int]$seconds
    )

    $return = ("{0:hh\:mm\:ss}" -f ([timespan]::fromseconds( $seconds )))
    return $return
}

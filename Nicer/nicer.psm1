<#
    Nicer - Render stuff Nicer...
#>
    
Function ConvertTo-NicerCase {
    [CmdletBinding()]
    param (
        [string]$string
    )
    
    $ti = (Get-Culture).TextInfo
    return $ti.ToTitleCase( $string.ToLower() )
}

Function ConvertTo-NicerDuration {
    [CmdletBinding()]
    param (
        [int]$seconds
    )

    $return = ( "{0:hh\:mm\:ss}" -f ([timespan]::fromseconds( $seconds )))
    return $return
}

Function ConvertTo-NicerHashtable {
    <# 
    .USAGE
        $json | ConvertFrom-Json | ConvertTo-HashTable
    #>
    [CmdletBinding()]
    [OutputType('hashtable')]
    param
    (
        [Parameter(ValueFromPipeline)]
        [Alias( "Input" )]
        $objects
    )

    begin
    {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ( $null -eq $objects ) {
            $output =  $null
        }
    }

    process
    {
        # 
        if ( $objects -is [System.Collections.IEnumerable] -and $objects -isnot [string] )
        {
            $collection = @(
                foreach ( $object in $objects )
                {
                    ConvertTo-NicerHashtable -Input $object
                }
            )
            $output = $collection
        }
        elseif ( $objects -is [PSCustomObject] ) # If the object has properties that need enumeration
        { 
            # Finally a Custom Object, let's convert it!
            $hash = @{}
            foreach ( $property in $objects.PSObject.Properties )
            {
                $hash[$property.Name] = ConvertTo-NicerHashtable -Input $property.Value
            }
            $output = $hash
        }
        else
        {
            # If we're here, $objects is already an hashtable
            $output = $objects
        }
    }

    end
    {   
        return $output
    }
}

Function ConvertTo-NicerHashtableToString {
    <# 
    .USAGE
        
    #>
    [CmdletBinding()]
    [OutputType('string')]
    param
    (
        [Parameter(ValueFromPipeline)]
        [Alias( "Input" )]
        [hashtable]$hashtable,
        [Parameter()]
        [string]$join
    )

    begin {
        $output = ""
    }
    
    process {
        foreach ( $key in $hashtable.keys ) {
            $output += "{0}{1}{2};" -f $key, $join, $hashtable[$key]
        }
    }

    end {
        return $output
    }
}
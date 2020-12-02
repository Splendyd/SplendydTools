<#
    Randomer - get Random stuff
#>

Function Get-RdCharacter {
    $rdChar = Get-Random -Minimum 97 -Maximum 122
    return [char]$rdChar
}

Function Get-RdInteger {
    $rdInt = Get-Random -Minimum 0 -Maximum 9
    return $rdInt
}

Function Get-RdSpecial {
    $rdSpecial = "!", "?", "$", "#" | Get-Random
    return $rdSpecial
}

Function Get-RdPassword {
<#
    Create a temp password
    <UpperCase>($num-1)*<LowerCase>$num*<Digit><SpecialCharacter>
#>
    param (
        [int]$num
    )

    # Init empty string that will contain the password
    $password = ""

    # First character of the password will be uppercase
    $password += ([string](Get-RdCharacter)).ToUpper()

    # The following characters will be lowercase 
    for ( $i = 1; $i -lt $num; $i++ ) {
        $password += Get-RdCharacter
    }

    # Then we had the integers
    for ( $i = 0; $i -lt $num; $i++ ) {
        $password += Get-RdInteger
    }

    # Finally we had a special character just for fun
    $password += Get-RdSpecial

    # Return the random generated password
    return $password
}

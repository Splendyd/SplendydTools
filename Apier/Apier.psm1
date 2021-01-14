Function Receive-ApierData {
    <# 
    .USAGE
        
    #>
    [CmdletBinding()]
    [OutputType('hashtable')]
    param
    (
        [Parameter(ValueFromPipeline)]
        [Alias( "Input" )]
        $uri
    )

    Invoke-RestMethod -Uri $uri
}
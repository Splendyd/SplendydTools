<# 
    Sqler!
#>

Function Get-SqlerDataList {
    param(
        [string]$pathAssemblyMySqlConnector = "C:\tools\MySQLConnector\MySql.Data.dll",
        [string]$connectionParameters,
        [string]$query
    )

    # TODO ErrorHandling
    begin
    {
        add-type -Assembly $pathAssemblyMySqlConnector
    
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection
        $connection.ConnectionString = Get-SqlerConnectionString $connectionParameters
        
        $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand
        $cmd.CommandText = $query
        $cmd.Connection = $connection

        $rows = 0 # Limit the numbers of rows to add in DataList
        $datalist = @()
    }
    
    process
    {
        $connection.Open()
        $cmd.Prepare()
        $data = $cmd.ExecuteReader()

        While ( $data.Read() -eq $true && $rows -lt 256 )
        {     
            $tempArray = New-Object -TypeName psobject
            
            For ( $i=0 ; $i -lt $data.FieldCount; $i++ )
            {
                $fieldType = $data.GetFieldType( $i )
                Switch ( $fieldType.Name )
                {
                    "Int32"
                    {
                        $rawData = $data.GetInt32( $i )
                        break
                    }
                    "String"
                    {
                        $rawData = $data.GetString( $i ).Trim()
                        $rawData = $rawData.Replace( `
                            $rawData[0], `
                            $rawData[0].ToString().ToUpper() `
                        )
                        break
                    }
                    default
                    {
                        $fieldType.Name
                    }
                }
                Add-Member -InputObject $tempArray -MemberType 'NoteProperty' -Name $data.GetName($i) -Value $rawData
            }

            $datalist += $tempArray
            $rows++
        }
    }
    
    end {
        $connection.close()
        return $datalist
    }
}

# $gb = $datalist | Measure-Object 'Task Duration' -sum -Maximum -Minimum -Average -StandardDeviation
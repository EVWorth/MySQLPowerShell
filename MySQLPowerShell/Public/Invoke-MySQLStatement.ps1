function Invoke-MySQLStatement {
    <#
    .SYNOPSIS
        runs a prepared SQL statement against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection], [String]
    .OUTPUTS
        $Null | [System.Data.Dataset]
    .LINK
    #>
    
        [CmdletBinding(ConfirmImpact = 'High')]
        param (
            [Parameter(ValueFromPipeline)]
            [MySql.Data.MySqlClient.MySqlConnection]$Session,

            [Parameter(Mandatory)]
            [String]$Statement,

            [Parameter()]
            [Switch]$ReturnData
        )
        
        begin {}
        
        process {
            $Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Statement, $Session)
            If ($ReturnData) {
                $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
                $DataSet = New-Object MySql.Data.Dataset
                $DataAdapter.Fill($DataSet)
                Return $DataSet
            } Else {
                $Command.ExecuteNonQuery() | Out-Null
            }
        }
        
        end {
        }
    }
    

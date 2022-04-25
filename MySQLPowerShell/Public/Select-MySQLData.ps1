function Select-MySQLData {
    <#
    .SYNOPSIS
        Accepts specific inputs and generates a prepared SQL statement to run against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS
        [System.Data.Dataset]
    .LINK
    #>
    
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline)]
            [MySql.Data.MySqlClient.MySqlConnection]$Session,

            [Parameter()]
            [String]$Select = '*',

            [Parameter(Mandatory)]
            [String]$From,

            [Parameter()]
            [String]$Where

            #Build out other SQL statement options
        )
        
        begin {}
        
        process {
            $Parameters = @{
                Select = $Select;
                From = $From;
                Where = $Where;
            }

            #Build Connection String
            [String]$Statement = ''
            ForEach ($Key in $Parameters.Keys) {
                If ( -Not $Null -eq $Parameters["$Key"]) {
                    $Statement += "$Key $($Parameters["$Key"]) "
                }
            }
            
            Try {
                Return $Session | Open-MySQLSession | Invoke-MySQLStatement -Statement $Statement -ReturnData -Confirm:$False
            } Catch {
                Throw
            }
        }
        
        end {
        }
    }
    

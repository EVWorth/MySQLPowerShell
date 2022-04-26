function Add-MySQLData {
    <#
    .SYNOPSIS
        Accepts specific inputs and generates a prepared SQL statement to run against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS

    .LINK
    #>
    
    [CmdletBinding(DefaultParameterSetName = 'Where', ConfirmImpact = 'High')]
    param (
        [Parameter(ValueFromPipeline)]
        [MySql.Data.MySqlClient.MySqlConnection]$Session,

        [Parameter(Mandatory)]
        [String]$Table,

        [Parameter(ParameterSetName = 'Where', Mandatory)]
        [String]$Where,

        [Parameter(ParameterSetName = 'All')]
        [Switch]$All
    )
        
    begin {}
        
    process {
        Switch ($All.IsPresent) {
            $True {
                $Statement = "DELETE FROM $Table;"
            }
            $False {
                $Statement = "DELETE FROM $Table WHERE $Where;"
            }
        }
            
        Try {
            $Session | Open-MySQLSession | Invoke-MySQLStatement -Statement $Statement -Confirm:$False
        }
        Catch {
            Throw
        }
    }
        
    end {
    }
}
    

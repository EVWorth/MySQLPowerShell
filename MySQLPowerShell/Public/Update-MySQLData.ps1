function Update-MySQLData {
    <#
    .SYNOPSIS
        Accepts specific inputs and generates a prepared SQL statement to run against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS

    .LINK
    #>
    
    [CmdletBinding(ConfirmImpact = "High")]
    param (
        [Parameter(ValueFromPipeline)]
        [MySql.Data.MySqlClient.MySqlConnection]$Session,

        [Parameter(Mandatory)]
        [String]$Table,

        [Parameter(Mandatory)]
        [String]$Set,

        [Parameter()]
        [String]$Where = $null
    )
        
    begin {}
        
    process {
        Switch ($null -eq $Where) {
            $True { $Statement = "UPDATE $Table SET $Set;" }
            $False { $Statement = "UPDATE $Table SET $Set WHERE $Where;" }
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
    

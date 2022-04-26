function Remove-MySQLTable {
    <#
    .SYNOPSIS
        Accepts specific inputs and generates a prepared SQL statement to run against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS

    .LINK
    #>
    
    [CmdletBinding(ConfirmImpact = 'High')]
    param (
        [Parameter(ValueFromPipeline)]
        [MySql.Data.MySqlClient.MySqlConnection]$Session,

        [Parameter(Mandatory)]
        [String]$Table
    )
        
    begin {}
        
    process {
        $Statement = "DROP TABLE ``$($Session.Database)``.``$Table``;"

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
    

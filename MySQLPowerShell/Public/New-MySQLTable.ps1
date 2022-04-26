function New-MySQLTable {
    <#
    .SYNOPSIS
        Accepts specific inputs and generates a prepared SQL statement to run against a MySQL Session object
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS

    .LINK
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [MySql.Data.MySqlClient.MySqlConnection]$Session,

        [Parameter(Mandatory)]
        [String]$Table,

        [Parameter(Mandatory)]
        [String]$Column
    )
        
    begin {}
        
    process {
        $Statement = "CREATE TABLE ``$($Session.Database)``.``$Table`` ($Column);"

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
    

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
    
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [MySql.Data.MySqlClient.MySqlConnection]$Session,

        [Parameter(Mandatory)]
        [String]$Table,

        [Parameter(Mandatory)]
        [String[]]$Value,

        [Parameter()]
        [String]$Column,

        [Parameter()]
        [Switch]$Bulk
    )
        
    begin {}
        
    process {
        Switch ($Bulk.IsPresent) {
            $True {
                If ($Column) {
                    $Statement = "INSERT INTO $Table ($Column) VALUES $Value;"
                }
                Else {
                    $Statement = "INSERT INTO $Table VALUES $Value;"
                }
            }
            $False {
                If ($Column) {
                    $Statement = "INSERT INTO $Table ($Column) VALUES ($Value);"
                }
                Else {
                    $Statement = "INSERT INTO $Table VALUES ($Value);"
                }
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
    

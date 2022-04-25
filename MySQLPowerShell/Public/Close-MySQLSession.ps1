function Open-MySQLSession {
    <#
    .SYNOPSIS
        Closes a [MySql.Data.MySqlClient.MySqlConnection] object and returns the object to the pipeline
    .DESCRIPTION
    
    .INPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .OUTPUTS
        [MySql.Data.MySqlClient.MySqlConnection]
    .LINK

    #>
    
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline)]
            [MySql.Data.MySqlClient.MySqlConnection]$Session
        )
        
        begin {}
        
        process {
            #If the session is already closed, just return the session object
            If ($Session.State -eq 'Closed') {
                Return $Session
            #If the session isn't closed, try to close the session and return the session object. if that fails, Throw the error
            } Else {
                Try {
                    $Session.Close()
                    Return $Session
                } Catch {
                    Throw
                }
            }
        }
        
        end {}
    }
    
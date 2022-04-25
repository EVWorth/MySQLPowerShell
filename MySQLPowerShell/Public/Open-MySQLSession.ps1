function Open-MySQLSession {
    <#
    .SYNOPSIS
        Opens a [MySql.Data.MySqlClient.MySqlConnection] object and returns the object to the pipeline
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
            #If the session is already open, just return the session object
            If ($Session.State -eq 'Open') {
                Return $Session
            #If the session isn't open, try to open the session and return the session object. if that fails, Throw the error
            } Else {
                Try {
                    $Session.Open()
                    Return $Session
                } Catch {
                    Throw
                }
            }
        }
        
        end {}
    }
    
function New-MySQLSession {
    <#
.SYNOPSIS
    Creates a session object for a MySQL Database connection
.DESCRIPTION

.PARAMETER ConnectionTimeout
Default: 15
The length of time (in seconds) to wait for a connection to the server before terminating the attempt and generating an error.

.PARAMETER Server
Default: localhost
The name or network address of the instance of MySQL to which to connect.
Multiple hosts can be specified separated by &.
This can be useful where multiple MySQL servers are configured for replication and you are not concerned about the precise server you are connecting to.
No attempt is made by the provider to synchronize writes to the database so care should be taken when using this option.

.PARAMETER Port
Default: 3306
The port MySQL is using to listen for connections.
This value is ignored if the connection protocol is anything but socket.

.PARAMETER Protocol
Default: socket
Specifies the type of connection to make to the server.

.PARAMETER CharacterSet
Default:
Specifies the character set that should be used to encode all queries sent to the server.
Resultsets are still returned in the character set of the data returned.

.PARAMETER Logging
Default: false
When true, various pieces of information is output to any configured TraceListeners.

.PARAMETER AllowBatch
Default: true
When true, multiple SQL statements can be sent with one command execution.

.PARAMETER Encrypt
Default: false
When true, SSL/TLS encryption is used for all data sent between the client and server if the server has a certificate installed.

.PARAMETER Database
Default: mysql
The name of the database to use initially

.PARAMETER PersistSecurityInfo
Default: false
When set to false or no (strongly recommended), security-sensitive information, such as the password, is not returned as part of the connection if the connection is open or has ever been in an open state.
Resetting the connection string resets all connection string values including the password.

.PARAMETER SharedMemoryName
Default: MYSQL
The name of the shared memory object to use for communication if the connection protocol is set to memory.

.PARAMETER AllowZeroDatetime
Default: false
True to have MySqlDataReader.GetValue() return a MySqlDateTime for date or datetime columns that have illegal values.
False will cause a DateTime object to be returned for legal values and an exception will be thrown for illegal values.

.PARAMETER ConvertZeroDatetime
Default: false
True to have MySqlDataReader.GetValue() and MySqlDataReader.GetDateTime() return DateTime.MinValue for date or datetime columns that have illegal values.

.PARAMETER PipeName
Default: mysql
When set to the name of a named pipe, the MySqlConnection will attempt to connect to MySQL on that named pipe.
This settings only applies to the Windows platform.

.PARAMETER UsePerformanceMonitor
Default: false
Posts performance data that can be tracked using perfmon

.PARAMETER ProcedureCacheSize
Default: 25
How many stored procedure definitions can be held in the cache

.PARAMETER IgnorePrepare
Default: true
Instructs the provider to ignore any attempts to prepare commands.
This option was added to allow a user to disable prepared statements in an entire application without modifying the code.
A user might want to do this if errors or bugs are encountered with MySQL prepared statements.

.PARAMETER UseProcedureBodies
Default: true
Instructs the provider to attempt to call the procedure without first resolving the metadata.
This is useful in situations where the calling user does not have access to the mysql.proc table.
To use this mode, the parameters for the procedure must be added to the command in the same order as they appear in the procedure definition and their types must be explicitly set.

.PARAMETER AutoEnlist
Default: true
Indicates whether the connection should automatically enlist in the current transaction, if there is one.

.PARAMETER RespectBinaryFlags
Default: true
Indicates whether the connection should respect all binary flags sent to the client as part of column metadata.
False will cause the connector to behave like Connector/Net 5.0 and earlier.

.PARAMETER BlobAsUTF8IncludePattern
Default: 
Pattern that should be used to indicate which blob columbs should be treated as UTF-8.

.PARAMETER BlobAsUTF8ExcludePattern
Default: 
Pattern that should be used to indicate which blob columns should not be treated as UTF-8.

.PARAMETER DefaultCommandTimeout
Default: 30
The default timeout that new MySqlCommand objects will use unless changed.

.PARAMETER AllowUserVariables
Default: false
Should the provider expect user variables in the SQL.

.PARAMETER InteractiveSession
Default: false
Should this session be considered interactive?

.PARAMETER FunctionsReturnString
Default: false
Set this option to true to force the return value of SQL functions to be string.

.PARAMETER UseAffectedRows
Default: false
Set this option to true to cause the affected rows reported to reflect only the rows that are actually changed.
By default, the number of rows that are matched is returned.

.PARAMETER ConnectionLifetime
Default: 0
When a connection is returned to the pool, its creation time is compared with the current time, and the connection is destroyed if that time span (in seconds) exceeds the value specified by Connection Lifetime. 
This is useful in clustered configurations to force load balancing between a running server and a server just brought online.
A value of zero (0) causes pooled connections to have the maximum connection timeout.

.PARAMETER MaxPoolSize
Default: 100
The maximum number of connections allowed in the pool.

.PARAMETER MinPoolSize
Default: 0
The minimum number of connections allowed in the pool.

.PARAMETER Pooling
Default: true
When true, the MySqlConnection object is drawn from the appropriate pool, or if necessary, is created and added to the appropriate pool.

.PARAMETER ConnectionReset
Default: false
Specifies whether the database connection should be reset when being drawn from the pool.
Leaving this as false will yeild much faster connection opens but the user should understand the side effects of doing this such as temporary tables and user variables from the previous session not being cleared out.

.PARAMETER CacheServerProperties
Default: false
Specifies whether the server variables are cached between pooled connections.
On systems where the variables change infrequently and there are lots of connection attempts, this can speed up things dramatically.

.INPUTS
    None
.OUTPUTS
    [MySql.Data.MySqlClient.MySqlConnection]
.LINK
    This function requires that the MySQL Connection/NET is installed on the computer this function will be running against
    https://dev.mysql.com/downloads/connector/net/

    MySQL .Net ConnectionString Settings: https://dev.mysql.com/doc/dev/connector-net/6.10/html/P_MySql_Data_MySqlClient_MySqlConnection_ConnectionString.htm

#>

    [CmdletBinding(DefaultParameterSetName = 'Socket')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter()]
        [Switch]$Open,

        [Parameter()]
        [Int]$ConnectionTimeout = 15,
        
        [Parameter()]
        [String]$Server = 'localhost',

        [Parameter()]
        [Int]$Port = 3306,

        [Parameter(ParameterSetName = 'Socket')]
        [Parameter(ParameterSetName = 'Pipe')]
        [Parameter(ParameterSetName = 'Unix')]
        [Parameter(ParameterSetName = 'Memory')]
        [ValidateSet('socket', 'pipe', 'unix', 'memory')]
        [String]$Protocol = 'socket',
        
        [Parameter()]
        [String]$CharacterSet,

        [Parameter()]
        [Switch]$Logging,

        [Parameter()]
        [Switch]$AllowBatch,

        [Parameter()]
        [Switch]$Encrypt,

        [Parameter()]
        [String]$Database = 'mysql',

        [Parameter()]
        [Switch]$PersistSecurityInfo,

        [Parameter(ParameterSetName = 'Memory')]
        [String]$SharedMemoryName = 'MYSQL',

        [Parameter()]
        [Switch]$AllowZeroDateTime,

        [Parameter()]
        [Switch]$ConvertZeroDateTime,

        [Parameter(ParameterSetName = 'Pipe')]
        [String]$PipeName = 'mysql',

        [Parameter()]
        [Switch]$UsePerformanceMonitor,

        [Parameter()]
        [Int]$ProcedureCacheSize = 25,

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]$IgnorePrepare = 'True',

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]$UseProcedureBodies = 'True',

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]$AutoEnlist = 'True',

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]$RespectBinaryFlags = 'True',

        [Parameter()]
        [String]$BlobAsUTF8IncludePattern,

        [Parameter()]
        [String]$BlobAsUTF8ExcludePattern,

        [Parameter()]
        [Int]$DefaultCommandTimeout = 30,

        [Parameter()]
        [Switch]$AllowUserVariables,

        [Parameter()]
        [Switch]$InteractiveSession,

        [Parameter()]
        [Switch]$FunctionsReturnString,

        [Parameter()]
        [Switch]$UseAffectedRows,

        [Parameter()]
        [Int]$ConnectionLifetime = 0,

        [Parameter()]
        [Int]$MaxPoolSize = 100,

        [Parameter()]
        [Int]$MinPoolSize = 0,

        [Parameter()]
        [ValidateSet('True', 'False')]
        [String]$Pooling = 'True',

        [Parameter()]
        [Switch]$ConnectionReset,

        [Parameter()]
        [Switch]$CacheServerProperties
    )
    
    begin {
        #Load MySQL .Net Framework MySql.Data Assembly files
        $SearchScope = 'C:\Program Files (x86)\MySQL'
        $MySQLDataTypes = Get-ChildItem -Path $SearchScope -Include 'MySql.Data.dll' -Force -Recurse | Sort-Object -Descending
        Add-Type -Path $MySQLDataTypes[0].FullName
        Try {
            $Session = New-Object MySql.Data.MySqlClient.MySqlConnection
        }
        Catch {
            Throw
        }
    }
    
    process {
        $UserName = $Credential.UserName
        $Password = $Credential.GetNetworkCredential().Password

        $CommonParameters = @{
            'Connection Timeout'       = $ConnectionTimeout;
            Server                     = $Server;
            Port                       = $Port;
            'Character Set'            = $CharacterSet;
            Logging                    = $Logging;
            'Allow Batch'              = $AllowBatch;
            Encrypt                    = $Encrypt;
            Database                   = $Database;
            Password                   = $Password;
            'Persist Security Info'    = $PersistSecurityInfo;
            Username                   = $UserName;
            'Allow Zero Datetime'      = $AllowZeroDateTime;
            'Convert Zero Datetime'    = $ConvertZeroDateTime;
            'Use Performance Monitor'  = $UsePerformanceMonitor;
            'Ignore Prepare'           = $IgnorePrepare;
            'Use Procedure Bodies'     = $UseProcedureBodies;
            'Auto Enlist'              = $AutoEnlist;
            'Respect Binary Flags'     = $RespectBinaryFlags;
            'BlobAsUTF8IncludePattern' = $BlobAsUTF8IncludePattern;
            'BlobAsUTF8ExcludePattern' = $BlobAsUTF8ExcludePattern;
            'Default Command Timeout'  = $Timeout;
            'Allow User Variables'     = $AllowUserVariables;
            'Interactive Session'      = $InteractiveSession;
            'Functions Return String'  = $FunctionsReturnString;
            'Use Affected Rows'        = $UseAffectedRows;
            'Connection Lifetime'      = $ConnectionLifetime;
            'Max Pool Size'            = $MaxPoolSize;
            'Min Pool Size'            = $MinPoolSize;
            Pooling                    = $Pooling;
            'Connection Reset'         = $ConnectionReset;
            'Cache Server Properties'  = $CacheServerPoperties;
        }
        switch ($PSCmdlet.ParameterSetName) {
            'Socket' { 
                $OtherParameters = @{
                    Protocol = $Protocol;
                }
            }
            'Pipe' { 
                $OtherParameters = @{
                    Protocol    = $Protocol;
                    'Pipe Name' = $PipeName;
                }
            }
            'Unix' { 
                $OtherParameters = @{
                    Protocol = $Protocol;
                }
            }
            'Memory' { 
                $OtherParameters = @{
                    Protocol             = $Protocol;
                    'Shared Memory Name' = $SharedMemoryName;
                }
            }
        }
        $Parameters = $CommonParameters + $OtherParameters

        #Build Connection String
        [String]$ConnectionString = ''
        ForEach ($Key in $Parameters.Keys) {
            If ( -Not $Null -eq $Parameters["$Key"]) {
                $ConnectionString += "$Key=$($Parameters["$Key"]);"
            }
        }

        $Session.ConnectionString = $ConnectionString
        If ($Open) {
            $Session | Open-MySQLSession
        }
    }
    
    end {
        Return $Session
    }
}

# HTTP URl for the web server
$url = 'http://127.0.0.1:8081/'

# subscribe to the demo pubsub topic
$daprSubscribeObject = , @( 
    @{
        pubsubname = 'dapr-demo-pubsub'
        topic      = 'dapr-demo-messages'
        route      = 'messageendpoint'
    }
)

# content that is returned after a client sends a request
$returnContents = @{
    'GET /dapr/subscribe'  = $daprSubscribeObject | ConvertTo-Json
    'GET /messageendpoint' = ''
}

# start the web server
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
$listener.Start()

try {
    while ($listener.IsListening) {  
        
        $context = $listener.GetContext()
        $Response = $context.Response

        # if content is available, return the (pubsub) message from it
        if ($context.Request.HasEntityBody) {
            $requestBody = [System.IO.StreamReader]::new($context.Request.InputStream).ReadToEnd()
            (ConvertFrom-Json $requestBody | Select-Object -expand 'data' ) -replace '.+text=(.+)}', '$1'        
        }

        # create the response
        $received = '{0} {1}' -f $context.Request.httpmethod, $context.Request.url.localpath
        $html = $returnContents[$received]
        if ($null -eq $html) {
            $html = ''
        }
        
        $buffer = [Text.Encoding]::UTF8.GetBytes($html)
        $Response.ContentLength64 = $buffer.length
        $Response.OutputStream.Write($buffer, 0, $buffer.length)
    
        $Response.Close()
    }
}
finally {
    $listener.Stop()
}
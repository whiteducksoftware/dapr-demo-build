$componentsPath = Join-Path $PSScriptRoot './../../dapr'
$pwshScriptPath = Join-Path $PSScriptRoot 'subscriber.ps1'

#ps pwsh | where Id -ne $pid | kill

dapr run `
    --app-id dapr-demo-pwsh-service `
    --app-port 8081 `
    --components-path $componentsPath `
    -- cmd /c pwsh $pwshScriptPath /WAIT
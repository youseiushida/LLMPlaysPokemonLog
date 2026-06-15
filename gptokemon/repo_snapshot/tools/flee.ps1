param(
    [string]$Port = "COM8",
    [int]$TextMs = 650,
    [int]$DpadMs = 170,
    [int]$Gap = 250,
    [int]$MenuDelay = 2800,
    [int]$ResultDelay = 900
)

function Invoke-Pad {
    param([string[]]$ArgsList)
    & magichid --port $Port horipad @ArgsList | Out-Null
    if ($Gap -gt 0) {
        Start-Sleep -Milliseconds $Gap
    }
}

Invoke-Pad @("hold", "--button", "a", "--duration-ms", "$TextMs", "--interval-ms", "50")
Start-Sleep -Milliseconds $MenuDelay
Invoke-Pad @("dpad", "--direction", "down", "--duration-ms", "$DpadMs", "--interval-ms", "50")
Invoke-Pad @("dpad", "--direction", "right", "--duration-ms", "$DpadMs", "--interval-ms", "50")
Invoke-Pad @("hold", "--button", "a", "--duration-ms", "$TextMs", "--interval-ms", "50")
Start-Sleep -Milliseconds $ResultDelay
Invoke-Pad @("hold", "--button", "a", "--duration-ms", "$TextMs", "--interval-ms", "50")

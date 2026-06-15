param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Action,

    [Parameter(Position = 1)]
    [string]$Value = "",

    [int]$Ms = 160,
    [int]$N = 1,
    [int]$Gap = 90,
    [string]$Port = "COM8"
)

function Invoke-Pad {
    param([string[]]$ArgsList)
    & magichid --port $Port horipad @ArgsList | Out-Null
}

for ($i = 0; $i -lt $N; $i++) {
    switch ($Action) {
        "tap" {
            Invoke-Pad @("tap", "--button", $Value)
        }
        "hold" {
            Invoke-Pad @("hold", "--button", $Value, "--duration-ms", "$Ms", "--interval-ms", "50")
        }
        "dpad" {
            Invoke-Pad @("dpad", "--direction", $Value, "--duration-ms", "$Ms", "--interval-ms", "50")
        }
        "release" {
            Invoke-Pad @("release-all")
        }
        default {
            throw "Unknown action: $Action"
        }
    }
    if ($Gap -gt 0) {
        Start-Sleep -Milliseconds $Gap
    }
}

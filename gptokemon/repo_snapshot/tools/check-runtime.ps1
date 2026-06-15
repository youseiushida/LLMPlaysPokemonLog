param(
    [string]$RuntimePath = ".gptwitch/runtime.json",
    [string]$LatestPath = "latest.png",
    [int]$StaleMinutes = 5
)

$ErrorActionPreference = "Stop"

function Write-Status {
    param(
        [string]$Name,
        [string]$Value
    )
    Write-Output ("{0}: {1}" -f $Name, $Value)
}

function Get-SerialDeviceMap {
    $path = "HKLM:\HARDWARE\DEVICEMAP\SERIALCOMM"
    if (-not (Test-Path $path)) {
        return @()
    }

    $item = Get-ItemProperty -Path $path
    return @(
        $item.PSObject.Properties |
            Where-Object { $_.Name -notlike "PS*" } |
            Sort-Object Value |
            ForEach-Object { "{0}={1}" -f $_.Value, $_.Name }
    )
}

if (Test-Path $RuntimePath) {
    $runtime = Get-Content $RuntimePath -Raw | ConvertFrom-Json
    $switchPort = [string]$runtime.switchPort
    $obsSource = [string]$runtime.obsSource
} else {
    $switchPort = ""
    $obsSource = ""
}

$ports = [System.IO.Ports.SerialPort]::GetPortNames() | Sort-Object
$portStatus = if ($switchPort -and ($ports -contains $switchPort)) { "present" } else { "missing" }

Write-Status "runtime" (Resolve-Path $RuntimePath -ErrorAction SilentlyContinue)
Write-Status "switchPort" ($(if ($switchPort) { "$switchPort ($portStatus)" } else { "not set" }))
Write-Status "availablePorts" ($(if ($ports.Count) { $ports -join ", " } else { "none" }))
$serialMap = Get-SerialDeviceMap
Write-Status "serialDevices" ($(if ($serialMap.Count) { $serialMap -join "; " } else { "none" }))
Write-Status "obsSource" ($(if ($obsSource) { $obsSource } else { "not set" }))

$obs = Get-Process | Where-Object { $_.ProcessName -match "^obs" } | Select-Object -First 1
Write-Status "obsProcess" ($(if ($obs) { "running ($($obs.ProcessName), pid $($obs.Id))" } else { "not running" }))

if (Test-Path $LatestPath) {
    $latest = Get-Item $LatestPath
    $age = (Get-Date) - $latest.LastWriteTime
    $freshness = if ($age.TotalMinutes -le $StaleMinutes) { "fresh" } else { "stale" }
    Write-Status "latestPng" ("{0} ({1:N1} min old, {2})" -f $latest.LastWriteTime, $age.TotalMinutes, $freshness)
} else {
    Write-Status "latestPng" "missing"
}

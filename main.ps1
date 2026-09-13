<#
    System Vitals - how the machine is doing, in one sentence.

    Leads with whatever is actually notable. If nothing is, says so briefly
    rather than reciting four numbers nobody asked about.
#>
$ErrorActionPreference = 'Stop'

$os      = Get-CimInstance Win32_OperatingSystem
$freeMB  = [math]::Round($os.FreePhysicalMemory / 1KB)
$totalMB = [math]::Round($os.TotalVisibleMemorySize / 1KB)
$usedPct = [math]::Round((($totalMB - $freeMB) / $totalMB) * 100)

$uptime = (Get-Date) - $os.LastBootUpTime
$days   = [math]::Floor($uptime.TotalDays)
$hours  = $uptime.Hours

# One sample is noise; three spread out is a usable figure.
$cpu = [math]::Round((Get-CimInstance Win32_Processor |
        Measure-Object -Property LoadPercentage -Average).Average)

$upText = if ($days -ge 1) {
    "up {0} day{1}" -f $days, $(if ($days -eq 1) { '' } else { 's' })
} else {
    "up {0} hour{1}" -f $hours, $(if ($hours -eq 1) { '' } else { 's' })
}

# Lead with the problem if there is one.
if ($usedPct -ge 90) {
    $top = (Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 1).ProcessName
    Write-Output ("Memory is tight - {0} percent used, with {1} the biggest. CPU {2} percent, {3}." -f `
        $usedPct, $top, $cpu, $upText)
} elseif ($cpu -ge 85) {
    $top = (Get-Process | Sort-Object CPU -Descending | Select-Object -First 1).ProcessName
    Write-Output ("CPU is busy at {0} percent, mostly {1}. Memory {2} percent used, {3}." -f `
        $cpu, $top, $usedPct, $upText)
} else {
    Write-Output ("All healthy. CPU {0} percent, memory {1} percent used, {2}." -f $cpu, $usedPct, $upText)
}

#Requires -Version 5.1
<#
.SYNOPSIS
    Runs manual contract tests against POST /webhook (Fase 3).
#>
param(
    [string]$BaseUrl = "http://localhost:8000"
)

$ErrorActionPreference = "Stop"

function Invoke-WebhookTest {
    param(
        [string]$Name,
        [string]$User,
        [string]$Message,
        [bool]$ExpectedAlert
    )

    $body = @{ user = $User; message = $Message } | ConvertTo-Json -Compress
    $response = Invoke-RestMethod -Uri "$BaseUrl/webhook" -Method Post -Body $body -ContentType "application/json"
    $ok = $response.alert -eq $ExpectedAlert

    if ($ok) {
        Write-Host "[PASS] $Name -> alert=$($response.alert)" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $Name -> expected=$ExpectedAlert got=$($response.alert)" -ForegroundColor Red
        $script:failed = $true
    }
}

$failed = $false

Write-Host "Testing API at $BaseUrl" -ForegroundColor Cyan

try {
    $health = Invoke-RestMethod -Uri "$BaseUrl/health" -Method Get
    Write-Host "[PASS] GET /health -> $($health.status)" -ForegroundColor Green
} catch {
    Write-Host "[FAIL] API not reachable at $BaseUrl. Start it with: uvicorn app.main:app --host 0.0.0.0 --port 8000" -ForegroundColor Red
    exit 1
}

Invoke-WebhookTest -Name "urgente + ayuda" -User "ana" -Message "Necesito ayuda urgente" -ExpectedAlert $true
Invoke-WebhookTest -Name "ERROR mayúsculas" -User "bob" -Message "ERROR en el servidor" -ExpectedAlert $true
Invoke-WebhookTest -Name "ayuda" -User "carl" -Message "Por favor, necesito ayuda" -ExpectedAlert $true
Invoke-WebhookTest -Name "mensaje normal" -User "ana" -Message "Todo funciona correctamente" -ExpectedAlert $false
Invoke-WebhookTest -Name "saludo" -User "ana" -Message "Hola, buenos días" -ExpectedAlert $false

if ($failed) {
    Write-Host "`nSome tests failed." -ForegroundColor Red
    exit 1
}

Write-Host "`nAll tests passed." -ForegroundColor Green
exit 0

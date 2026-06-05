#Requires -Version 5.1
<#
.SYNOPSIS
    Sends a test payload to the n8n webhook workflow (Fase 6).
#>
param(
    [string]$WebhookUrl = "http://localhost:5678/webhook/chat-message",
    [string]$User = "nombre",
    [string]$Message = "Necesito ayuda urgente"
)

$ErrorActionPreference = "Stop"

$body = @{ user = $User; message = $Message } | ConvertTo-Json -Compress

Write-Host "POST $WebhookUrl" -ForegroundColor Cyan
Write-Host "Body: $body"

try {
    $response = Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $body -ContentType "application/json"
    Write-Host "Response: $($response | ConvertTo-Json -Compress)" -ForegroundColor Green

    if ($response.alert -eq $true) {
        Write-Host "[PASS] alert=true" -ForegroundColor Green
        exit 0
    }

    Write-Host "[INFO] alert=$($response.alert)" -ForegroundColor Yellow
    exit 0
} catch {
    Write-Host "[FAIL] $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Ensure: docker compose up -d, webhook workflow imported and ACTIVE." -ForegroundColor Yellow
    exit 1
}

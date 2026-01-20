# backup.ps1 - Скрипт резервного копирования

param(
    [string] = ".\backups"
)

 = Get-Date -Format "yyyyMMdd_HHmmss"
 = "\backup_.zip"

Write-Host "?? Создание резервной копии..." -ForegroundColor Yellow

# Создаем папку для бэкапов
if (!(Test-Path )) {
    New-Item -ItemType Directory -Path  -Force | Out-Null
}

# Копируем важные файлы
 = @(
    "DOCUMENTATION",
    "WEEK-1-START",
    "WEEK-2-DATABASE",
    "WEEK-3-AUTH",
    "WEEK-4-INTEGRATION",
    "WEEK-5-FRONTEND",
    "WEEK-6-DEVOPS",
    "FINAL-PROJECT"
)

# Создаем временную папку
 = "C:\Users\popov\AppData\Local\Temp\tradeos_backup_"
New-Item -ItemType Directory -Path  -Force | Out-Null

foreach (docs in ) {
    if (Test-Path docs) {
        Copy-Item -Path docs -Destination  -Recurse -Force
    }
}

# Копируем конфигурационные файлы
 = @("README.md", "docker-compose.yml", "requirements.txt", "package.json")
foreach (System.Collections.Hashtable in ) {
    if (Test-Path System.Collections.Hashtable) {
        Copy-Item -Path System.Collections.Hashtable -Destination  -Force
    }
}

# Архивируем
Compress-Archive -Path "\*" -DestinationPath  -CompressionLevel Optimal

# Удаляем временную папку
Remove-Item -Path  -Recurse -Force

 = (Get-Item ).Length / 1MB
Write-Host "? Резервная копия создана: " -ForegroundColor Green
Write-Host "?? Размер: {0:N2} MB" -f  -ForegroundColor Gray

# Удаляем старые бэкапы (оставляем 5 последних)
 = Get-ChildItem -Path  -Filter "backup_*.zip" | 
    Sort-Object CreationTime -Descending | 
    Select-Object -Skip 5

foreach ( in ) {
    Remove-Item -Path .FullName -Force
    Write-Host "???  Удален старый бэкап: " -ForegroundColor Gray
}

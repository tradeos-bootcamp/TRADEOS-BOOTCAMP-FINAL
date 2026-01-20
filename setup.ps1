# setup.ps1 - Скрипт настройки TradeOS Bootcamp

Write-Host "?? Настройка TradeOS Bootcamp..." -ForegroundColor Cyan

# Проверка установленного ПО
Write-Host "
?? Проверка необходимого ПО..." -ForegroundColor Yellow

 = @(
    @{Name="Python"; Check="python --version"},
    @{Name="Git"; Check="git --version"},
    @{Name="Docker"; Check="docker --version"},
    @{Name="Node.js"; Check="node --version"}
)

foreach ( in ) {
    try {
        Invoke-Expression .Check 2>&1 | Out-Null
        Write-Host "  ?  установлен" -ForegroundColor Green
    } catch {
        Write-Host "  ?  не установлен" -ForegroundColor Red
    }
}

# Создание виртуального окружения
Write-Host "
?? Создание виртуального окружения Python..." -ForegroundColor Yellow
if (!(Test-Path "venv")) {
    python -m venv venv
    Write-Host "  ? Виртуальное окружение создано" -ForegroundColor Green
}

# Установка зависимостей
Write-Host "
?? Установка Python зависимостей..." -ForegroundColor Yellow
venv\Scripts\activate
pip install -r requirements.txt
Write-Host "  ? Зависимости установлены" -ForegroundColor Green

Write-Host "
?? Настройка завершена! Вы можете приступить к обучению." -ForegroundColor Green
Write-Host "?? Начните с папки WEEK-1-START" -ForegroundColor Cyan

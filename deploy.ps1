# deploy.ps1 - Скрипт деплоя TradeOS

param(
    [Parameter(Mandatory=True)]
    [ValidateSet('development', 'staging', 'production')]
    [string] = 'development'
)

Write-Host "?? Деплой TradeOS в окружение: " -ForegroundColor Cyan

switch () {
    'development' {
        Write-Host "?? Деплой в development..." -ForegroundColor Yellow
        docker-compose up -d
    }
    'staging' {
        Write-Host "?? Деплой в staging..." -ForegroundColor Yellow
        docker-compose -f docker-compose.prod.yml up -d --build
    }
    'production' {
        Write-Host "?? Деплой в production..." -ForegroundColor Red
        Write-Host "??  Внимание! Это production окружение!" -ForegroundColor Red
        
        # Создание backup
        & "\scripts\backup.ps1"
        
        # Деплой
        docker-compose -f docker-compose.prod.yml up -d --build --force-recreate
        
        # Проверка здоровья
        Start-Sleep -Seconds 30
         = Invoke-WebRequest -Uri "http://localhost/health" -UseBasicParsing
        if (.StatusCode -eq 200) {
            Write-Host "? Деплой успешен!" -ForegroundColor Green
        } else {
            Write-Host "? Ошибка деплоя!" -ForegroundColor Red
        }
    }
}

Write-Host "
?? Статус контейнеров:" -ForegroundColor Cyan
docker-compose ps

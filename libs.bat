@echo off
setlocal enabledelayedexpansion

set "VERSION=v2.8.0"
set "URL=https://github.com/datso/react-native-pjsip-builder/releases/download/%VERSION%/release.tar.gz"
set "LOCK=.libs.lock"
set "DEST=.libs.tar.gz"
set "DOWNLOAD=true"

REM Verifica se o curl e o tar estão disponíveis
where curl >nul 2>nul
if errorlevel 1 (
    echo Curl não encontrado. Instale-o antes de prosseguir.
    exit /b 1
)

where tar >nul 2>nul
if errorlevel 1 (
    echo Tar não encontrado. Instale-o antes de prosseguir.
    exit /b 1
)

REM Verifica se o arquivo de controle existe e contém a versão atual
if exist %LOCK% (
    set /p CURRENT_VERSION=<%LOCK%
    if "%CURRENT_VERSION%"=="%VERSION%" (
        set "DOWNLOAD=false"
    )
)

REM Baixa e extrai a biblioteca PJSIP se necessário
if "%DOWNLOAD%"=="true" (
    curl -L --silent "%URL%" -o "%DEST%"
    tar -xvf "%DEST%"
    del "%DEST%"
    echo %VERSION% > %LOCK%
)

endlocal

@echo off
:: Comprobar si se está ejecutando como Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ========================================================
    echo ERROR: Debes ejecutar este archivo como ADMINISTRADOR.
    echo Haz clic derecho sobre el archivo y elige:
    echo "Ejecutar como administrador"
    echo ========================================================
    pause
    exit /b
)

:MENU
cls
echo ========================================================
echo        GUILLION TECHNOLOGIES - CONTROL DE SERVICIOS
echo ========================================================
echo.
echo [1] DESHABILITAR de forma permanente (SysMain y Telemetria)
echo [2] RE-HABILITAR servicios (Volver al estado original)
echo [3] EXCLUIR carpeta actual de Windows Defender (Acelera procesos)
echo [4] Salir
echo.
echo ========================================================
set /p opcion="Selecciona una opcion [1-4] y presiona Enter: "

if "%opcion%"=="1" goto DESHABILITAR
if "%opcion%"=="2" goto HABILITAR
if "%opcion%"=="3" goto EXCLUIR
if "%opcion%"=="4" goto SALIR

echo Opcion invalida. Intenta de nuevo.
pause
goto MENU

:DESHABILITAR
cls
echo ========================================================
echo   DESHABILITANDO SERVICIOS DE FORMA PERMANENTE...
echo ========================================================
echo Deteniendo y deshabilitando SysMain (SuperFetch)...
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled

echo Deteniendo y deshabilitando DiagTrack (Telemetria Microsoft)...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled

echo.
echo [OK] Servicios deshabilitados permanentemente.
echo No se volveran a encender ni al reiniciar la PC.
echo.
pause
goto MENU

:HABILITAR
cls
echo ========================================================
echo   RE-HABILITANDO SERVICIOS (ESTADO DE FABRICA)...
echo ========================================================
echo Activando SysMain...
sc config SysMain start= auto
sc start SysMain >nul 2>&1

echo Activando DiagTrack...
sc config DiagTrack start= auto
sc start DiagTrack >nul 2>&1

echo.
echo [OK] Servicios re-habilitados y en ejecucion normal.
echo.
pause
goto MENU

:EXCLUIR
cls
echo ========================================================
echo   AGREGANDO EXCLUSION EN WINDOWS DEFENDER...
echo ========================================================
echo Agregando la carpeta actual a las exclusiones de Defender...
powershell -Command "Add-MpPreference -ExclusionPath '%~dp0' -ErrorAction SilentlyContinue"
echo.
echo [OK] Windows Defender ya no gastara CPU ni RAM analizando esta carpeta.
echo.
pause
goto MENU

:SALIR
exit
@echo off
setlocal enabledelayedexpansion

:: Ir a la carpeta donde se encuentra este archivo .bat
cd /d "%~dp0"

echo ========================================================
echo   GUILLION TECHNOLOGIES - CREADOR DE ESTRUCTURA
echo ========================================================
echo Creando la arquitectura oficial de carpetas y archivos...
echo.

:: 1. Crear carpetas de Documentacion
if not exist "docs" mkdir "docs"

:: 2. Crear carpetas del Modulo 1 (Sincronizacion)
if not exist "modulo_1_sincronizacion\entrada\video" mkdir "modulo_1_sincronizacion\entrada\video"
if not exist "modulo_1_sincronizacion\entrada\audio" mkdir "modulo_1_sincronizacion\entrada\audio"
if not exist "modulo_1_sincronizacion\salida" mkdir "modulo_1_sincronizacion\salida"
if not exist "modulo_1_sincronizacion\src" mkdir "modulo_1_sincronizacion\src"

:: 3. Crear archivos de documentacion iniciales si no existen
if not exist "docs\01_HISTORIAS_DE_USUARIO.md" (
    echo # Historias de Usuario - Guillion Technologies > "docs\01_HISTORIAS_DE_USUARIO.md"
)
if not exist "docs\02_ARQUITECTURA_SISTEMA.md" (
    echo # Arquitectura del Sistema - Guillion Technologies > "docs\02_ARQUITECTURA_SISTEMA.md"
)
if not exist "docs\03_BITACORA_MODULO_1.md" (
    echo # Bitacora de Desarrollo - Modulo 1: Sincronizacion > "docs\03_BITACORA_MODULO_1.md"
)

:: 4. Crear archivos .gitkeep para que Git no ignore las carpetas vacias
type nul > "modulo_1_sincronizacion\entrada\video\.gitkeep"
type nul > "modulo_1_sincronizacion\entrada\audio\.gitkeep"
type nul > "modulo_1_sincronizacion\salida\.gitkeep"

:: 5. Crear archivos base de codigo del Modulo 1
if not exist "modulo_1_sincronizacion\src\sincronizador.py" (
    echo # Modulo 1: Sincronizador de Audio y Video > "modulo_1_sincronizacion\src\sincronizador.py"
)
if not exist "modulo_1_sincronizacion\Dockerfile" (
    echo # Dockerfile del Modulo 1 > "modulo_1_sincronizacion\Dockerfile"
)
if not exist "modulo_1_sincronizacion\requirements.txt" (
    echo # Dependencias Python del Modulo 1 > "modulo_1_sincronizacion\requirements.txt"
)

:: 6. Crear docker-compose.yml maestro
if not exist "docker-compose.yml" (
    echo # Docker Compose Maestro - Guillion Technologies > "docker-compose.yml"
)

echo.
echo ========================================================
echo  [OK] ESTRUCTURA GENERADA CON EXITO:
echo ========================================================
echo.
echo  C:\guillion-technologies\
echo  ├── docs\
echo  │   ├── 01_HISTORIAS_DE_USUARIO.md
echo  │   ├── 02_ARQUITECTURA_SISTEMA.md
echo  │   └── 03_BITACORA_MODULO_1.md
echo  ├── modulo_1_sincronizacion\
echo  │   ├── entrada\
echo  │   │   ├── audio\
echo  │   │   └── video\
echo  │   ├── salida\
echo  │   ├── src\
echo  │   │   └── sincronizador.py
echo  │   ├── Dockerfile
echo  │   └── requirements.txt
echo  ├── docker-compose.yml
echo  └── README.md
echo.
echo ========================================================
echo Presiona cualquier tecla para salir...
pause >nul

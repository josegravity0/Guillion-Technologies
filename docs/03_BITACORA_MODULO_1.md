# GUILLION TECHNOLOGIES — BITÁCORA DE DESARROLLO DEL MÓDULO 1

Este documento registra los avances técnicos, decisiones tomadas, problemas encontrados y soluciones implementadas durante la construcción del **Módulo 1: Sincronización Automática de Audio y Video**.

---

## ESTADO DEL MÓDULO: [EN PROCESO]

### Registro de Actividades

#### [Fase 0: Preparación del Entorno]
- **Objetivo:** Establecer la base del repositorio, control de versiones y documentación.
- **Acciones Realizadas:**
  - Repositorio Git inicializado en `C:\guillion-technologies` y vinculado con GitHub Desktop.
  - Script `control_servicios.bat` creado y ejecutado para optimizar el consumo de RAM en la máquina local (ganancia de +650 MB de memoria libre).
  - Estructura de carpetas creada mediante el script `crear_estructura.bat`.
  - Documentos teóricos inicializados: `01_HISTORIAS_DE_USUARIO.md`, `02_ARQUITECTURA_SISTEMA.md`.

#### [Fase 1: Implementación del Motor de Sincronización (Próximo)]
- **Objetivo:** Crear el algoritmo de correlación cruzada en Python y acoplarlo con FFmpeg.
- **Pruebas pendientes:**
  - Prueba de extracción de señal de referencia del video.
  - Prueba de cálculo de retardo (offset en milisegundos).
  - Prueba de multiplexado sin pérdida (`-c:v copy`) generando `video_sincronizado.mp4`.

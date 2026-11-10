# GUILLION TECHNOLOGIES — ARQUITECTURA TÉCNICA DEL SISTEMA

Este documento describe la arquitectura global, los flujos de datos y la integración de herramientas locales y en la nube para el funcionamiento de **Guillion Technologies**.

---

## 1. PRINCIPIO FUNDAMENTAL: ORQUESTACIÓN LIGERA (LOW-SPEC PC)

El sistema opera bajo una regla estricta:
> **Cero procesamiento pesado en la máquina local.** Toda tarea intensiva de inteligencia artificial (transcripción de audio, análisis semántico de texto y visión de video) se delega a servicios externos gratuitos mediante llamadas API. La computadora local solo ejecuta orquestación de I/O y multiplexado de video con FFmpeg sin re-renderizado (`-c:v copy`).

---

## 2. DIAGRAMA DE FLUJO GENERAL DE DATOS

```mermaid
flowchart TD
    subgraph Fase0 ["Fase 0: Inteligencia de Competencia"]
        A0["Video Viral de Competencia"] -->|yt-dlp| B0["Audio / Low-res Video"]
        B0 -->|API Gratis| C0["Gemini Multimodal Vision"]
        C0 -->|JSON| D0["Directrices de Edicion & Empaquetado"]
    end

    subgraph Fase1 ["Fase 1: Pre-procesamiento (Módulo 1)"]
        A1["Video de Cámara (1080p/4K)"] --> E1["Extractor de Audio Referencia"]
        B1["Audio de Consola (.wav/.mp3)"] --> F1["Analizador de Correlacion Cruzada"]
        E1 --> F1
        F1 -->|Offset ms| G1["FFmpeg Multiplexer (-c:v copy)"]
        A1 --> G1
        G1 --> H1["video_sincronizado.mp4"]
    end

    subgraph Fase2 ["Fase 2: Cerebro y Edición Semántica"]
        H1 -->|Extraer Audio 32k mono| I2["audio_ligero.mp3"]
        I2 -->|API Groq Whisper| J2["Transcripcion con Timestamps"]
        J2 -->|Prompt Maestro| K2["Gemini Flash LLM"]
        D0 -.-> K2
        K2 -->|JSON Estructurado| L2["Coordenadas de Cortes"]
    end

    subgraph Fase3 ["Fase 3: Exportación Ultrarrápida"]
        L2 --> M3["FFmpeg Master YouTube 16:9 (-c:v copy)"]
        L2 --> N3["FFmpeg Shorts/Reels 9:16 (Crop muy ligero)"]
        M3 --> O3["Video Final YouTube"]
        N3 --> P3["1 a 5 Clips Verticales"]
    end
```

---

## 3. COMPONENTES TECNOLÓGICOS Y MOTIVO DE ELECCIÓN

| Componente | Función | Justificación Técnica |
| :--- | :--- | :--- |
| **Docker** | Contenedorización | Garantiza que todo corra idéntico en Windows, Linux o servidores sin configurar rutas del sistema operativo. |
| **Python 3.11** | Orquestador | Lenguaje estándar para conectar APIs, scripts de cálculo y llamadas al sistema. |
| **FFmpeg** | Motor multimedia | El motor C de procesamiento de video más rápido y eficiente del mundo. Copia flujos sin usar RAM. |
| **NumPy / SciPy** | Sincronización matemática | Calcula la correlación cruzada de señales de audio en segundos con mínimo consumo de memoria. |
| **Groq (Whisper)** | Transcripción Cloud | Procesa horas de audio en segundos con su tecnología LPU a costo \$0. |
| **Google AI Studio (Gemini)** | Razonamiento y LLM | Ventana de contexto masiva (1M tokens) y salidas JSON estrictas para cortes precisos. |

---

## 4. ESPECIFICACIÓN DE CONTENEDOR DOCKER (MÓDULO 1)

El contenedor del Módulo 1 se basa en una imagen ligera `python:3.11-slim`:
1. Instala el paquete binario de `ffmpeg`.
2. Instala las librerías científicas (`numpy`, `scipy`, `soundfile`).
3. Monta las carpetas de `entrada/` y `salida/` mediante volúmenes para que los archivos queden en tu disco de Windows automáticamente.

# GUILLION TECHNOLOGIES — HISTORIAS DE USUARIO Y ALCANCE

Este documento define los requerimientos funcionales del sistema Guillion Technologies, siguiendo el estándar ágil de desarrollo por módulos independientes.

---

## MÓDULO 1: PRE-PROCESAMIENTO Y SINCRONIZACIÓN AUTOMÁTICA (FOCO ACTUAL)

### Historia de Usuario 1.1: Alineación de Audio de Consola con Video de Cámara
- **Como:** Creador de contenido audiovisual.
- **Quiero:** Entregar un video largo grabado en cámara y una pista de audio externa de alta calidad grabada desde consola/micrófono.
- **Para:** Que el sistema compare automáticamente ambas señales de sonido mediante correlación cruzada, detecte el desfase exacto en milisegundos y me entregue un único archivo de video con la pista de audio de consola perfectamente sincronizada con los labios.

#### Criterios de Aceptación:
1. El procesamiento de video no debe re-renderizar fotogramas (debe usar `-c:v copy` para no consumir CPU/GPU).
2. El audio de cámara de baja calidad debe ser descartado por completo.
3. El audio final debe quedar multiplexado en formato compatible (AAC a 320 kbps).
4. El archivo resultante debe guardarse automáticamente en la carpeta `salida/` con el nombre `video_sincronizado.mp4`.

---

## MÓDULO 2: TRANSCRIPCIÓN LIGERA EN LA NUBE (FUTURO)

### Historia de Usuario 2.1: Extracción de Transcripción con Timestamps sin Cargar la PC
- **Como:** Operador del sistema en una PC de bajos recursos.
- **Quiero:** Que el sistema extraiga un audio ultraligero (mono, 16kHz, 32kbps) y lo envíe a la API gratuita de Groq (Whisper).
- **Para:** Obtener la transcripción completa del video con marcas de tiempo exactas por palabra en cuestión de segundos y sin superar el límite de 25 MB.

---

## MÓDULO 3: CEREBRO EDITORIAL Y DETECCIÓN DE CORTES (FUTURO)

### Historia de Usuario 3.1: Poda de Tomas Falsas y Digresiones
- **Como:** Director audiovisual.
- **Quiero:** Inyectar la transcripción y el Prompt Maestro al LLM (Gemini Flash API).
- **Para:** Recibir una estructura JSON con los cortes limpios que descartan equivocaciones, repeticiones de frases y cambios de tema que no aportan a la tesis del video.

---

## MÓDULO 4: EXPORTACIÓN HORIZONTAL Y VERTICAL (FUTURO)

### Historia de Usuario 4.1: Renderizado de Master YouTube (16:9)
- **Como:** Editor de YouTube.
- **Quiero:** Que FFmpeg una los fragmentos aprobados sin re-renderizar video.
- **Para:** Obtener el video final de YouTube en segundos sin congelar la computadora.

### Historia de Usuario 4.2: Generación de Clips Verticales (9:16 Shorts/Reels/TikTok)
- **Como:** Estratega de redes sociales.
- **Quiero:** Extraer entre 1 y 5 fragmentos autocontenidos con gancho (Hook) inicial y remate, recortados a formato vertical.
- **Para:** Publicar contenido corto de alto impacto sin editar manualmente.

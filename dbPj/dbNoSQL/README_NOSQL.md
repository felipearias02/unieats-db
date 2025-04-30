# Documentacion de archivos JSON - Sistema de Notificaciones y Anuncios UniEats

Este archivo describe la estructura y proposito de los archivos `notifications.json` y `announcements.json` utilizados en la base de datos NoSQL del sistema UniEats.

## Archivo: notifications.json

Este archivo contiene notificaciones generadas por el sistema en tiempo real. Cada entrada representa un mensaje dirigido a los usuarios de una cafeteria especifica.

### Estructura:
- CAFE_ID: identificador numerico de la cafeteria.
- MESSAGE: contenido textual de la notificacion.
- TYPE: tipo de notificacion. Puede ser:
  - "estado": mensajes sobre pedidos, pagos, cancelaciones, o disponibilidad.
  - "especial": mensajes unicos para cada cafeteria, adaptados a su contexto.

### Uso:
Estas notificaciones se muestran en la app del usuario cuando ocurren eventos relacionados con su pedido o entorno operativo de la cafeteria.

## Archivo: announcements.json

Este archivo contiene anuncios institucionales o promocionales emitidos por cada cafeteria.

### Estructura:
- CAFE_ID: identificador numerico de la cafeteria.
- MESSAGE: contenido del anuncio.
- TYPE: tipo de contenido, siempre "anuncio".

### Uso:
Los anuncios son utilizados para informar sobre promociones, productos nuevos, cambios de horario, cierres temporales, o eventos relevantes. Se pueden mostrar como banners o mensajes destacados en la aplicacion.

## Observaciones:
Ambos archivos permiten que cada cafeteria tenga su propia estrategia de comunicacion, tanto en mensajes operativos como comerciales.


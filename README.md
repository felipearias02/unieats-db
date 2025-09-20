# UniEats DB

Este repositorio contiene la configuración y estructura de bases de datos relacional y no relacional utilizadas en el proyecto **UniEats**, una plataforma orientada a facilitar la gestión de pedidos y menús en entornos universitarios.

## Propósito

El objetivo de este repositorio es centralizar y documentar los esquemas de datos utilizados por UniEats, tanto para sistemas basados en SQL (relacionales) como para bases de datos NoSQL documentales. Esta separación permite aprovechar lo mejor de cada enfoque según las necesidades de almacenamiento, consulta y escalabilidad.

## Contenido del repositorio

- `/dbPj`: Contiene scripts de bases de datos relacionales (SQL), como la creación de tablas y relaciones entre entidades.
- `/src`: Contiene estructuras en formato JSON utilizadas para modelar las colecciones de la base de datos no relacional.
- Otros archivos relacionados a la definición de datos, configuración o posibles migraciones futuras.

## Tecnologías consideradas

- **Relacional**: PostgreSQL o MySQL (dependiendo del entorno de despliegue).
- **No Relacional**: MongoDB o sistemas equivalentes orientados a documentos.

## Estructura de datos

El modelo de datos combina lo mejor de ambos mundos:

- La base de datos **relacional** gestiona información estructurada con relaciones claras, como usuarios, menús, pedidos y restaurantes.
- La base de datos **no relacional** se utiliza para datos más flexibles o altamente anidados, como historiales de pedidos, registros de actividad o datos que cambian frecuentemente sin estructura fija.

## Uso del repositorio

1. Clona el repositorio:
   ```bash
   git clone https://github.com/felipearias02/unieats-db.git

## Proyecto!
Este repositorio forma parte del ecosistema técnico de UniEats, y está pensado para ser utilizado por desarrolladores que trabajen en la implementación de funcionalidades backend, sincronización de datos entre servicios o validación de integridad de información. Su objetivo es servir como una referencia centralizada y confiable para el diseño de datos de la plataforma.
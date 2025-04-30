# UNIEATS_DB - Base de Datos Relacional

Este archivo contiene el script completo en SQL para la creacion de la base de datos `UNIEATS_DB`, utilizada en el sistema UniEats para la gestion de pedidos en cafeterías universitarias.

## Tablas incluidas

- **ROLES**: Define los roles de usuario (Estudiante, Profesor, Administrativo, Colaborador).
- **USERS**: Contiene la información de los usuarios del sistema, cada uno con su respectivo rol asignado desde la tabla ROLES.
- **PHONES**: Telefonos asociados a cada usuario en la tabla USERS.
- **CAFES**: Lista de cafeterías disponibles.
- **WORKSTATION**: Define los roles internos de empleados (cajero, cocinero, etc.).
- **EMPLOYEES_CAFE**: Registro de empleados por cafeteria.
- **CATEGORIES** y **PRODUCTS**: Gestion de productos ofrecidos por cada cafetería.
- **ORDERS** y **ORDER_DETAILS**: Gestion de los pedidos realizados.
- **PAYMENT_METHODS** y **PAYMENTS**: Metodos de pago y transacciones asociadas a las ordenes.

Cada tabla cuenta con validaciones, como por ejemplo en la tabla 'USERS' usamos check para validar la longitud de caracteres de la contrasena que en este caso debe ser mayor o igual a 8 caracteres , llaves foraneas y seguimiento de creacion/modificacion de registros con `TIMESTAMP`.

## Requisitos
- Motor: MariaDB / MySQL

## Relaciones entre Tablas

Las tablas estan correctamente enlazadas mediante llaves foraneas que garantizan la integridad referencial. Algunos ejemplos son :

- `PHONES.USER_ID` → `USERS.USER_ID`
- `EMPLOYEES_CAFE.WORKSTATION_ID` → `WORKSTATION.WORKSTATION_ID`
- `PRODUCTS.CATEGORY_ID` → `CATEGORIES.CATEGORY_ID`
- `ORDERS.USER_ID` → `USERS.USER_ID`
- `ORDER_DETAILS.ORDER_ID` → `ORDERS.ORDER_ID`
- `PAYMENTS.PAYMENT_METHOD_ID` → `PAYMENT_METHODS.PAYMENT_METHOD_ID`

## Normalizacion

Toda la base de datos ha sido estructurada y validada para cumplir con la 3FN, asi mismo quedamos asegurando:

- Atributos completamente atomicos.
- Eliminacion de dependencias parciales.
- Eliminacion de dependencias transitivas entre columnas que no eran clave para las tablas principales.

## Convenciones de Nombres

- Se ha utilizado el formato de mayusculas para todas las columnas (ej. `FIRST_NAME`, `CAFE_ID`).
- Esto asegura que tenga legibilidad, consistencia y facilidad la lectura del script para el equipo, y asegura un buen mantenimiento a largo plazo.

## Integridad de Datos

- Se han aplicado restricciones como `NOT NULL`, `UNIQUE`, `CHECK`, y valores por defecto (`DEFAULT`) para garantizar datos validos.
- Cada tabla incluye un campo `TIMESTAMP` con `CURRENT_TIMESTAMP` y `ON UPDATE CURRENT_TIMESTAMP` para registrar creacion y modificaciones de forma automatica.

## Gestión de Usuarios y Empleados

- **Usuarios como Clientes** estan en la tabla `USERS`, con su respectivo `ROLE_ID`.
- **Empleados** están completamente separados en la tabla `EMPLOYEES_CAFE`, con datos personales, puesto de trabajo y cafetería asignada.
- **Estado de Contrato de Empleados** se encuentran con creacion y modificacion 'TIMESTAMP' para registrar si siguen o no trabajando en la cafeteria.

## Trazabilidad y Autogeneración

- La mayoria de las claves primarias utilizan `AUTO_INCREMENT` para facilitar la insercion y trazabilidad de registros unicos.
- El sistema puede rastrear facilmente los cambios con el uso de campos `TIMESTAMP`.

## Uso Esperado

- El **frontend** consulta productos (`PRODUCTS`), categorías (`CATEGORIES`) y cafeterías (`CAFES`) para mostrar al usuario final.
- El **backend** gestiona inserciones y transacciones como pedidos (`ORDERS`, `ORDER_DETAILS`) y pagos (`PAYMENTS`).
- El sistema tambien permite mantener actualizados roles, metodos de pago y la gestion interna de empleados.


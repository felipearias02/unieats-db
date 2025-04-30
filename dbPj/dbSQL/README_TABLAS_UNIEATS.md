# UNIEATS_DB - Documentacion de Tablas de la Base de Datos

Este archivo describe cada tabla incluida en el esquema relacional UNIEATS_DB.

## 1. ROLES
Almacena los roles de los usuarios como estudiante, profesor, administrativo o colaborador.
- ROLE_ID: Llave primaria.
- ROLE_NAME: Nombre unico del rol.

## 2. USERS
Almacena los usuarios del sistema (excepto empleados de cafeteria).
- USER_ID: Llave primaria.
- Incluye nombres, cedula, correo, direccion y contrasena.
- ROLE_ID: Llave foranea hacia ROLES.
- Indexado por correo institucional.

## 3. PHONES
Telefonos asociados a cada usuario.
- PHONE_ID: Llave primaria.
- USER_ID: Llave foranea hacia USERS (elimina en cascada).
- PHONE_NUMBER: Valida longitud (>=10).

## 4. CAFES
Informacion de cada cafeteria.
- CAFE_ID: Llave primaria.
- Incluye nombre, ubicacion y empresa operadora.

## 5. WORKSTATION
Define los cargos o funciones de los empleados.
- WORKSTATION_ID: Llave primaria.
- WORKSTATION_NAME: Nombre unico del puesto.

## 6. EMPLOYEES_CAFE
Registra los empleados de cada cafeteria.
- EMPLOYEES_ID: Llave primaria.
- Incluye nombre, cedula, correo, direccion, contrasena, cafe y cargo.
- Llaves foraneas: CAFE_ID, WORKSTATION_ID.
- Indexado por CAFE_ID.

## 7. CATEGORIES
Categorias de productos.
- CATEGORY_ID: Llave primaria.
- CATEGORY_NAME: Nombre unico.
- CAT_DESCRIPTION: Descripcion opcional.

## 8. PRODUCTS
Productos que se venden en las cafeterias.
- PRODUCT_ID: Llave primaria.
- CATEGORY_ID y CAFE_ID: Llaves foraneas.
- PRODUCT_NAME: Nombre unico, precio, stock, descripcion.
- Indexado por CAFE_ID.

## 9. ORDERS
Pedidos realizados por los usuarios.
- ORDER_ID: Llave primaria.
- USER_ID, CAFE_ID: Llaves foraneas.
- TAKEN_BY_EMPLOYEE_ID, DELIVERED_BY_EMPLOYEE_ID: Empleados responsables.
- Incluye estado, fecha y monto total.
- Indexado por USER_ID y CAFE_ID.

## 10. ORDER_DETAILS
Detalle de productos por cada pedido.
- DETAIL_ID: Llave primaria.
- ORDER_ID y PRODUCT_ID: Llaves foraneas.
- Cantidad, precio unitario, llave compuesta unica (ORDER_ID, PRODUCT_ID).
- Indexado por ambas llaves.

## 11. PAYMENT_METHODS
Metodos de pago disponibles (efectivo, tarjeta, etc).
- PAYMENT_METHOD_ID: Llave primaria.
- METHOD_NAME: Nombre del metodo.

## 12. PAYMENTS
Pagos realizados por los pedidos.
- PAYMENT_ID: Llave primaria.
- ORDER_ID y PAYMENT_METHOD_ID: Llaves foraneas.
- Incluye valor pagado, fecha, estado, codigo de referencia y devolucion.

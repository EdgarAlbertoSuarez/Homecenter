DROP TABLE  Clientes;
/

CREATE TABLE  Clientes  (
   id_cliente             NUMBER  ,
   primer_nombre          VARCHAR2(255),
   segundo_nombre         VARCHAR2(255),
   primer_apellido        VARCHAR2(255),
   segundo_apellido       VARCHAR2(255),
   tipo_de_documento      VARCHAR2(255),
   documento              VARCHAR2(255),
   celular                VARCHAR2(255),
   direccion              VARCHAR2(255),
   correo_electronico     VARCHAR2(255),
   valor_maximo_factura   NUMBER,
   CONSTRAINT Clientes_pk PRIMARY KEY  (id_cliente)
)
/

DROP TABLE  Vehiculos;
/ 
CREATE TABLE  Vehiculos  (
   id_vehiculo            NUMBER  ,
   placa                  VARCHAR2(255),
   marca                  VARCHAR2(255),
   modelo                 VARCHAR2(255),
   cilindraje             NUMBER,
  CONSTRAINT Vehiculos_pk PRIMARY KEY  (id_vehiculo)
)
/

DROP TABLE  Clientes_Vehiculos;
/
CREATE TABLE  Clientes_Vehiculos  (
   id_cliente_vehiculo             NUMBER  ,
   id_cliente                      NUMBER,
   id_vehiculo                     NUMBER,
   estado                          VARCHAR2(255),
  CONSTRAINT Clientes_Vehiculos_pk PRIMARY KEY  (id_cliente_vehiculo)
)
/

DROP TABLE  Tienda;
/
CREATE TABLE  Tienda  (
   id_tienda           NUMBER  ,
   nombre_tienda       VARCHAR2(255),
   direccion           VARCHAR2(255),
   telefono            VARCHAR2(255),
  CONSTRAINT Tienda_pk PRIMARY KEY  (id_tienda)
)
/

DROP TABLE  Mecanico;

CREATE TABLE  Mecanico  (
   id_mecanico            NUMBER  ,
   primer_nombre          VARCHAR2(255),
   segundo_nombre         VARCHAR2(255),
   primer_apellido        VARCHAR2(255),
   segundo_apellido       VARCHAR2(255),
   tipo_de_documento      VARCHAR2(255),
   documento              VARCHAR2(255),
   celular                VARCHAR2(255),
   direccion              VARCHAR2(255),
   correo_electronico     VARCHAR2(255),
   estado                 VARCHAR2(255),
   id_tienda              NUMBER,
   CONSTRAINT Mecanico_pk PRIMARY KEY  (id_mecanico)
)
/

DROP TABLE  Repuestos;

CREATE TABLE  Repuestos  (
   id_repuesto                     NUMBER  ,
   repuesto                        VARCHAR2(255),
   cantidad_inventario             NUMBER,
   valor_unitario                  NUMBER,
   estado                          VARCHAR2(255),
   valor_minimo_descuento          NUMBER,
   porcentaje_descuento_aplicable  NUMBER,
  CONSTRAINT Repuestos_pk          PRIMARY KEY  (id_repuesto)
)
/

DROP TABLE  Servicios;

CREATE TABLE  Servicios  (
   id_servicio                     NUMBER  ,
   descripcion_servicio            VARCHAR2(255),
   valor_minimo_servicio           NUMBER,
   valor_maximo_servicio           NUMBER,
   valor_minimo_descuento          NUMBER,
   porcentaje_descuento_aplicable  NUMBER,
  CONSTRAINT Servicios_pk          PRIMARY KEY  (id_servicio)
)
/

DROP TABLE  Mantenimientos;

CREATE TABLE  Mantenimientos  (
   id_mantenimiento            NUMBER  ,
   id_cliente_vehiculo         NUMBER,
   id_tienda                   NUMBER,
   fecha                       DATE,
   estado                      VARCHAR2(255),
  CONSTRAINT Mantenimientos_pk PRIMARY KEY  (id_mantenimiento)
)
/

DROP TABLE  Mantenimientos_Repuestos;
/
CREATE TABLE  Mantenimientos_Repuestos  (
   id_mantenimiento                NUMBER,
   id_repuesto                     NUMBER,
   cantidad                        NUMBER,
   valor_unitario                  NUMBER,
   subtotal                        NUMBER,
   porcentaje_descuento_aplicable  NUMBER,
   descuento_aplicado              NUMBER,
   valor_total                     NUMBER
)
/

DROP TABLE  Mantenimientos_Servicios;
/
CREATE TABLE  Mantenimientos_Servicios  (
   id_mantenimiento                     NUMBER,
   id_servicio                          NUMBER,
   id_mecanico                          NUMBER,
   subtotal                             NUMBER,
   porcentaje_descuento_aplicable       NUMBER,
   descuento_aplicado                   NUMBER,
   valor_total                          NUMBER
)
/

DROP TABLE  Factura;
/
CREATE TABLE  Factura  (
   id_factura           NUMBER  ,
   id_cliente           NUMBER,
   fecha_factura        DATE,
   subtotal             NUMBER,
   valor_descuento      NUMBER,
   iva                  NUMBER,
   valor_total          NUMBER,
   observaciones        VARCHAR2(255),
  CONSTRAINT Factura_pk PRIMARY KEY  (id_factura)
)
/

DROP TABLE  Factura_Mantenimiento;
/
CREATE TABLE  Factura_Mantenimiento  (
   id_factura        NUMBER,
   id_mantenimiento  NUMBER
)
/

ALTER TABLE  Factura_Mantenimiento  ADD FOREIGN KEY ( id_factura ) REFERENCES  Factura  ( id_factura )
/

ALTER TABLE  Factura_Mantenimiento  ADD FOREIGN KEY ( id_mantenimiento ) REFERENCES  Mantenimientos  ( id_mantenimiento )
/

ALTER TABLE  Clientes_Vehiculos  ADD FOREIGN KEY ( id_cliente ) REFERENCES  Clientes  ( id_cliente )
/

ALTER TABLE  Mantenimientos_Servicios  ADD FOREIGN KEY ( id_servicio ) REFERENCES  Servicios  ( id_servicio )
/

ALTER TABLE  Mantenimientos_Repuestos  ADD FOREIGN KEY ( id_repuesto ) REFERENCES  Repuestos  ( id_repuesto )
/

ALTER TABLE  Mantenimientos_Repuestos  ADD FOREIGN KEY ( id_mantenimiento ) REFERENCES  Mantenimientos  ( id_mantenimiento )
/

ALTER TABLE  Mantenimientos_Servicios  ADD FOREIGN KEY ( id_mantenimiento ) REFERENCES  Mantenimientos  ( id_mantenimiento )
/

ALTER TABLE  Mantenimientos_Servicios  ADD FOREIGN KEY ( id_mecanico ) REFERENCES  Mecanico  ( id_mecanico )
/

ALTER TABLE  Mantenimientos  ADD FOREIGN KEY ( id_tienda ) REFERENCES  Tienda  ( id_tienda )
/

ALTER TABLE  Clientes_Vehiculos  ADD FOREIGN KEY ( id_vehiculo ) REFERENCES  Vehiculos  ( id_vehiculo )
/

ALTER TABLE  Factura  ADD FOREIGN KEY ( id_cliente ) REFERENCES  Clientes  ( id_cliente )
/

ALTER TABLE  Mantenimientos  ADD FOREIGN KEY ( id_cliente_vehiculo ) REFERENCES  Clientes_Vehiculos  ( id_cliente_vehiculo )
/

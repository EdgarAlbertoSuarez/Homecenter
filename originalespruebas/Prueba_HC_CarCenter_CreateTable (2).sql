CREATE TABLE [Clientes] (
  [id_cliente] int PRIMARY KEY IDENTITY(1, 1),
  [primer_nombre] nvarchar(255),
  [segundo_nombre] nvarchar(255),
  [primer_apellido] nvarchar(255),
  [segundo_apellido] nvarchar(255),
  [tipo_de_documento] nvarchar(255),
  [documento] nvarchar(255),
  [celular] nvarchar(255),
  [direccion] nvarchar(255),
  [correo_electronico] nvarchar(255),
  [valor_maximo_factura] int
)
/

CREATE TABLE [Vehiculos] (
  [id_vehiculo] int PRIMARY KEY IDENTITY(1, 1),
  [placa] nvarchar(255),
  [marca] nvarchar(255),
  [modelo] nvarchar(255),
  [cilindraje] int
)
/

CREATE TABLE [Clientes_Vehiculos] (
  [id_cliente_vehiculo] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente] int,
  [id_vehiculo] int,
  [estado] nvarchar(255)
)
/

CREATE TABLE [Tienda] (
  [id_tienda] int PRIMARY KEY IDENTITY(1, 1),
  [nombre_tienda] nvarchar(255),
  [direccion] nvarchar(255),
  [telefono] nvarchar(255)
)
/

CREATE TABLE [Mecanico] (
  [id_mecanico] int PRIMARY KEY IDENTITY(1, 1),
  [primer_nombre] nvarchar(255),
  [segundo_nombre] nvarchar(255),
  [primer_apellido] nvarchar(255),
  [segundo_apellido] nvarchar(255),
  [tipo_de_documento] nvarchar(255),
  [documento] nvarchar(255),
  [celular] nvarchar(255),
  [direccion] nvarchar(255),
  [correo_electronico] nvarchar(255),
  [estado] nvarchar(255),
  [id_tienda] int
)
/

CREATE TABLE [Repuestos] (
  [id_repuesto] int PRIMARY KEY IDENTITY(1, 1),
  [repuesto] nvarchar(255),
  [cantidad_inventario] int,
  [valor_unitario] int,
  [estado] nvarchar(255),
  [valor_minimo_descuento] int,
  [porcentaje_descuento_aplicable] int
)
/

CREATE TABLE [Servicios] (
  [id_servicio] int PRIMARY KEY IDENTITY(1, 1),
  [descripcion_servicio] nvarchar(255),
  [valor_minimo_servicio] int,
  [valor_maximo_servicio] int,
  [valor_minimo_descuento] int,
  [porcentaje_descuento_aplicable] int
)
/

CREATE TABLE [Mantenimientos] (
  [id_mantenimiento] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente_vehiculo] int,
  [id_tienda] int,
  [fecha] datetime,
  [estado] nvarchar(255)
)
/

CREATE TABLE [Mantenimientos_Repuestos] (
  [id_mantenimiento] int,
  [id_repuesto] int,
  [cantidad] int,
  [valor_unitario] int,
  [subtotal] int,
  [porcentaje_descuento_aplicable] intd,
  [descuento_aplicado] int,
  [valor_total] int
)
/

CREATE TABLE [Mantenimientos_Servicios] (
  [id_mantenimiento] int,
  [id_servicio] int,
  [id_mecanico] int,
  [subtotal] int,
  [porcentaje_descuento_aplicable] intd,
  [descuento_aplicado] int,
  [valor_total] int
)
/

CREATE TABLE [Factura] (
  [id_factura] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente] int,
  [fecha_factura] datetime,
  [subtotal] int,
  [valor_descuento] int,
  [iva] int,
  [valor_total] int,
  [observaciones] nvarchar(255)
)
/

CREATE TABLE [Factura_Mantenimiento] (
  [id_factura] int,
  [id_mantenimiento] int
)
/

ALTER TABLE [Factura_Mantenimiento] ADD FOREIGN KEY ([id_factura]) REFERENCES [Factura] ([id_factura])
/

ALTER TABLE [Factura_Mantenimiento] ADD FOREIGN KEY ([id_mantenimiento]) REFERENCES [Mantenimientos] ([id_mantenimiento])
/

ALTER TABLE [Clientes_Vehiculos] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Clientes] ([id_cliente])
/

ALTER TABLE [Mantenimientos_Servicios] ADD FOREIGN KEY ([id_servicio]) REFERENCES [Servicios] ([id_servicio])
/

ALTER TABLE [Mantenimientos_Repuestos] ADD FOREIGN KEY ([id_repuesto]) REFERENCES [Repuestos] ([id_repuesto])
/

ALTER TABLE [Mantenimientos_Repuestos] ADD FOREIGN KEY ([id_mantenimiento]) REFERENCES [Mantenimientos] ([id_mantenimiento])
/

ALTER TABLE [Mantenimientos_Servicios] ADD FOREIGN KEY ([id_mantenimiento]) REFERENCES [Mantenimientos] ([id_mantenimiento])
/

ALTER TABLE [Mantenimientos_Servicios] ADD FOREIGN KEY ([id_mecanico]) REFERENCES [Mecanico] ([id_mecanico])
/

ALTER TABLE [Mantenimientos] ADD FOREIGN KEY ([id_tienda]) REFERENCES [Tienda] ([id_tienda])
/

ALTER TABLE [Clientes_Vehiculos] ADD FOREIGN KEY ([id_vehiculo]) REFERENCES [Vehiculos] ([id_vehiculo])
/

ALTER TABLE [Factura] ADD FOREIGN KEY ([id_cliente]) REFERENCES [Clientes] ([id_cliente])
/

ALTER TABLE [Mantenimientos] ADD FOREIGN KEY ([id_cliente_vehiculo]) REFERENCES [Clientes_Vehiculos] ([id_cliente_vehiculo])
/

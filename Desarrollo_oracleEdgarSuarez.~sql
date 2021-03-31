-----------------------------------------------------------------------------------------
---5.  Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días
SELECT clientes.id_cliente,
       clientes.primer_nombre || ' ' || clientes.segundo_nombre || ' ' ||
       clientes.primer_apellido || ' ' || clientes.segundo_apellido nombreApellidos,
       tipo_de_documento,
       documento,
       to_char(facturado.total_acumulado, '999,999,999,999.99') valor_facturado
  FROM clientes,
       (SELECT id_cliente, total_acumulado
          FROM (SELECT id_cliente, SUM(valor_total) total_acumulado
                  from factura
                 WHERE fecha_factura >= SYSDATE - 60
                 GROUP BY id_cliente)) facturado
 WHERE clientes.id_cliente = facturado.id_cliente
   AND total_acumulado > 100000
 ORDER BY clientes.id_cliente
 
--6.	Consulta de los 100 productos más vendidos en los últimos 30 días
SELECT r.id_repuesto, r.repuesto, ventas.masvendidos
  FROM Repuestos r,
       (SELECT mr.id_repuesto, SUM(mr.cantidad) masvendidos
          FROM Mantenimientos_Repuestos mr
         WHERE mr.id_mantenimiento IN
               (SELECT id_mantenimiento
                  FROM Mantenimientos m
                 WHERE m.fecha >= SYSDATE - 30)
         GROUP BY mr.id_repuesto) ventas
 WHERE r.id_repuesto = ventas.id_repuesto
   AND ROWNUM < 100
 ORDER BY ventas.masvendidos DESC
--7.	Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.
SELECT m.id_mantenimiento,
       m.id_tienda,
       (SELECT t.nombre_tienda 
       FROM tienda t 
       WHERE t.id_tienda = m.id_tienda
       AND ROWNUM<2) nombretienda,
       producto.id_repuesto,
       (
       SELECT  r.repuesto 
       FROM Repuestos r
       WHERE r.id_repuesto=producto.id_repuesto
       AND ROWNUM<2
      ) Nombrerepuesto,
       producto.cantidad
  FROM Mantenimientos m,
       (SELECT mr.id_mantenimiento, mr.id_repuesto, mr.cantidad
          FROM Mantenimientos_Repuestos mr
         WHERE mr.id_mantenimiento IN
               (SELECT id_mantenimiento
                  FROM Mantenimientos m
                 WHERE m.fecha >= SYSDATE - 60)
           AND mr.id_repuesto = 100) producto
 WHERE m.id_mantenimiento = producto.id_mantenimiento
 --------------------------------------------------------------------------------------------------
--8.	Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.

SELECT clv.id_cliente_vehiculo, 
       clv.id_cliente, 
       (
       SELECT 
       cli.primer_nombre || ' ' || cli.segundo_nombre || ' ' ||
       cli.primer_apellido || ' ' || cli.segundo_apellido|| ' ' ||tipo_de_documento || ' ' ||documento
       FROM Clientes cli
       WHERE clv.id_cliente=cli.id_cliente
       AND ROWNUM<2
       ) DescribeCliente,
       clv.id_vehiculo,
       (
       SELECT  'Placa: ' ||v.placa|| ' ' ||v.marca|| ' Modelo: ' ||v.modelo|| ' Cilindraje: ' ||v.cilindraje 
       FROM Vehiculos v 
       WHERE v.id_vehiculo=clv.id_vehiculo
       AND ROWNUM<2
       ) DESCRIBEVEHICULO
FROM Clientes_Vehiculos clv
WHERE clv.id_cliente_vehiculo 
IN ( 
SELECT id_cliente_vehiculo
FROM Mantenimientos m
WHERE m.fecha >= SYSDATE - 30
GROUP BY id_cliente_vehiculo
HAVING COUNT(*)>1
)
--------------------------------------------------------------------------------------------------
---9.	Procedimiento que reste la cantidad de productos del inventario de las tiendas cada que se presente una venta.
CREATE OR REPLACE PROCEDURE egreso_inventario(p_id_repuesto    repuestos.id_repuesto%TYPE,
                                              p_cantidad_venta NUMBER) IS
  v_cantidad_inventario repuestos.cantidad_inventario%type;
  v_error               number;

BEGIN
  --- Procedimiento que reste la cantidad de productos del inventario
  --- de las tiendas cada que se presente una venta.

  --Valor existencias en el inventario
  BEGIN
    SELECT cantidad_inventario
      INTO v_cantidad_inventario
      FROM repuestos
     WHERE id_repuesto = p_id_repuesto;
  EXCEPTION
    WHEN OTHERS THEN
      v_error := SQLCODE;
  END;

  --Egreso Inventario
  BEGIN
    UPDATE repuestos
       SET cantidad_inventario = v_cantidad_inventario - p_cantidad_venta
     WHERE id_repuesto = p_id_repuesto;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      v_error := SQLCODE;
  END;

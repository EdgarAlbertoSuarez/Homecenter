SELECT * FROM tienda
SELECT * FROM Vehiculos 
SELECT * FROM Clientes_Vehiculos 


select * from Repuestos FOR UPDATE
 
SELECT * FROM Mantenimientos 
SELECT * FROM Mantenimientos_Repuestos 



SELECT id_mantenimiento 
FROM Mantenimientos m 
WHERE m.fecha>=SYSDATE-30



SELECT  r.id_repuesto,r.repuesto,ventas.masvendidos 
FROM Repuestos r,
(
SELECT mr.id_repuesto, SUM(mr.cantidad) masvendidos
  FROM Mantenimientos_Repuestos mr
 WHERE mr.id_mantenimiento IN
       (SELECT id_mantenimiento
          FROM Mantenimientos m
         WHERE m.fecha >= SYSDATE - 30)
 GROUP BY mr.id_repuesto
) ventas
WHERE r.id_repuesto=ventas.id_repuesto
ORDER BY ventas.masvendidos DESC
 

         
 
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

SELECT t.id_tienda,t.nombre_tienda 
FROM tienda t
WHERE t.id_tienda

    

   
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


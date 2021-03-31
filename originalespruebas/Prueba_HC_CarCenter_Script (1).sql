--5.	Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días.

SELECT 
	c.id_cliente, 
	c.primer_nombre, 
	c.segundo_nombre, 
	c.primer_apellido,
	c.segundo_apellido
FROM
	clientes c
	INNER JOIN
			(SELECT 
				f.id_cliente,
				SUM(valor_total) valor_acumulado
			 FROM facturas
			 WHERE fecha_factura >= (sysdate-60)) f
	 ON  c.id_cliente = f.id_cliente
WHERE f.valor_acumulado >= '100000';

--6.	Consulta de los 100 productos más vendidos en los últimos 30 días

SELECT
	a.id_repuesto,
	a.repuesto
FROM
	(SELECT
		r.id_repuesto,
		r.repuesto,
		rownum
	FROM
		repuesto r
		INNER JOIN mantenimientos_repuestos mr ON mr.id_repuesto = r.id_repuesto
		INNER JOIN mantenimentos m ON m.id_mantenimiento = mr.id_mantenimiento
	WHERE m.fecha >= sysdate-30
	ORDER BY mr.cantidad desc) a
WHERE a.rownum <=100;
	
	

--7.	Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.

SELECT 
	t.id_tienda,
	t.nombre_tienda
	r.id_repuesto,
	r.repuesto,
	SUM(mr.cantidad) cantidad
FROM
	tienda t
	INNER JOIN mantenimentos m ON m.id_tienda = t.id_tienda
	INNER JOIN mantenimientos_repuestos mr ON mr.id_mantenimiento = m.id_mantenimiento
WHERE 
	mr.id_repuesto = '100'
	AND m.fecha >= sysdate-60
GROUP BY t.id_tienda,t.nombre_tienda,r.id_repuesto,r.repuesto
HAVING SUM(mr.cantidad) > 100;

--8.	Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.

SELECT 
	c.id_cliente, 
	c.primer_nombre, 
	c.segundo_nombre, 
	c.primer_apellido,
	c.segundo_apellido,
	SUM(m.id_mantenimiento)
FROM
	clientes c
	INNER JOIN clientes_vehiculos cv ON cv.id_cliente = c.id_cliente
	INNER JOIN mantenimientos m ON m.id_cliente_vehiculo = cv.id_cliente_vehiculo) a
WHERE 
	m.fecha >= sysdate-30
GROUP BY c.id_cliente, c.primer_nombre,c.segundo_nombre,c.primer_apellido,c.segundo_apellido
HAVING SUM(m.id_mantenimiento) > 1;


--9.	Procedimiento que reste la cantidad de productos del inventario de las tiendas cada que se presente una venta.

CREATE OR REPLACE PROCEDURE dismunuye_inventario(p_id_repuesto int, p_cantidad_vendida int)
IS
 v_cantidad_actual int;
BEGIN
 --Trae el valor actual de inventario
 SELECT cantidad_inventario INTO v_cantidad_actual
 FROM repuestos
 WHERE id_repuesto = p_id_repuesto;
 --Actualiza el valor de inventario
 UPDATE repuestos
 SET cantidad_inventario = v_cantidad_actual - p_cantidad_vendida
 WHERE id_repuesto = p_id_repuesto; 
 COMMIT; 
END;







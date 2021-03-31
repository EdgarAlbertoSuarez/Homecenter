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

END egreso_inventario;
/

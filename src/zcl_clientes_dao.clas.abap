CLASS zcl_clientes_dao DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_clientes TYPE STANDARD TABLE OF ztab_clientes WITH EMPTY KEY.
    METHODS create IMPORTING is_data TYPE ztab_clientes RAISING zcx_client_insert_error.
    METHODS read_by_id IMPORTING id TYPE ztab_clientes-cliente_id RETURNING VALUE(rs_data) TYPE ztab_clientes.
    METHODS read_all RETURNING VALUE(rs_data) TYPE tt_clientes.
    METHODS update IMPORTING is_data TYPE  ztab_clientes
                   RAISING
                     zcx_client_update_error.
    METHODS delete IMPORTING id TYPE ztab_clientes-cliente_id.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_clientes_dao IMPLEMENTATION.

  METHOD create .
   INSERT ztab_clientes FROM @is_data.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE zcx_client_insert_error
      EXPORTING  text = 'Error al intentar insertar datos en la tabla ZTAB_CLIENTES'.
  ENDIF.

 ENDMETHOD.

 METHOD read_by_id.
   SELECT SINGLE * FROM ztab_clientes
     WHERE cliente_id = @id
   INTO @rs_data.

   IF sy-subrc <> 0.
    CLEAR rs_data.
   ENDIF.

 ENDMETHOD.

 METHOD read_all.
   SELECT * FROM ztab_clientes
   INTO TABLE @rs_data.
 ENDMETHOD.

 METHOD update.
   UPDATE ztab_clientes FROM @is_data.

   IF sy-subrc <> 0.
     RAISE EXCEPTION TYPE zcx_client_update_error
      EXPORTING  text = 'Error al intentar insertar datos en la tabla ZTAB_CLIENTES'.
   ENDIF.

 ENDMETHOD.

 METHOD delete.

 ENDMETHOD.
ENDCLASS.

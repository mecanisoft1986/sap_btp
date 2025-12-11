CLASS zcl_use_dao_clientes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_use_dao_clientes IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lc_cliente) = VALUE ztab_clientes(
      cliente_id = '1' nombre = 'JUAN CONSTANTINE' email = 'mecanisoft@gmail.com' activo = abap_true
    ).

    TRY.

      NEW zcl_clientes_dao( )->create( lc_cliente ).

    CATCH zcx_client_insert_error INTO DATA(lx_error).
     out->write( |Error al crear cliente: { lx_error->get_text( ) }| ).
    ENDTRY.

    DATA(ls_result) = NEW zcl_clientes_dao( )->read_by_id( id = 1 ).

    out->write( | cliente: { ls_result-cliente_id } nombre: { ls_result-nombre } email : { ls_result-email } activo: { ls_result-activo  } | ).

    DATA(ls_result2) = new zcl_clientes_dao( )->read_all( ).

    LOOP AT ls_result2 ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | cliente: { <fs_result>-cliente_id } nombre: { <fs_result>-nombre } email : { <fs_result>-email } activo: { <fs_result>-activo  } | ).
    ENDLOOP.

    lc_cliente-nombre = 'JUAN CARLOS CONSTANTINE'.

    TRY.
      NEW zcl_clientes_dao( )->update( lc_cliente ).
    CATCH zcx_client_update_error INTO DATA(lx_error_update).
      out->write( |Error al update el cliente { lx_error_update->get_text( ) } | ).
    ENDTRY.

    TRY.
      NEW zcl_clientes_dao( )->delete( id = 1 ).
    CATCH zcx_client_delete_error INTO DATA(lx_error_delete).
      out->write( | ERROR AL ELIMINAR EL CLIENTE {  lx_error_delete->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

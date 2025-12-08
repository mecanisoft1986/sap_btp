CLASS zcl_test_cds_where DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: gt_empleado TYPE TABLE OF  zjc_empleado2.
ENDCLASS.



CLASS zcl_test_cds_where IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    INSERT LINES OF VALUE #( BASE gt_empleado
     ( id = 4 nombre = 'MARIO' depto_id = 1 salario = 1000  waers = 'USD' )
     ( id = 5 nombre = 'JESSY' depto_id = 1 salario = 2000 waers = 'USD' )
     ) INTO TABLE gt_empleado.

     INSERT zjc_empleado2 FROM TABLE @gt_empleado.

     SELECT * FROM z_i_empleado4_where INTO TABLE @DATA(lt_result).

     LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
       out->write( | id: { <fs_result>-Id } nombre: { <fs_result>-Nombre } departamento: { <fs_result>-departamento } | ).
     ENDLOOP.
  ENDMETHOD.
ENDCLASS.

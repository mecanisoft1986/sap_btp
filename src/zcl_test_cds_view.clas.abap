CLASS zcl_test_cds_view DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: gt_empleados TYPE TABLE OF zjc_empleado2,
          gt_dptos TYPE TABLE OF zjc_dptos2.
ENDCLASS.



CLASS zcl_test_cds_view IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    INSERT LINES OF VALUE #( BASE gt_dptos
     ( id = 1 nombre = 'TI' )
     ( id = 2 nombre = 'TTHHH' )
     ( id = 3 nombre = 'BI' )
    ) INTO TABLE gt_dptos.

    INSERT zjc_dptos2 FROM TABLE @gt_dptos.

    INSERT LINES OF VALUE #( BASE gt_empleados
      ( id = 1 nombre = 'JUAN' depto_id = 1 waers = 'USD' salario = '150000'  )
      ( id = 2 nombre = 'MARIA' depto_id = 2 waers = 'USD' salario = '90000' )
      ( id = 3 nombre = 'LUISA' depto_id = 3 waers = 'USD' salario = '80000' )
    ) INTO TABLE gt_empleados.

    INSERT zjc_empleado2 FROM TABLE @gt_empleados.

    SELECT * FROM z_i_empleados INTO TABLE @DATA(lt_result).

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).

     out->write( | id: { <fs_result>-id } nombre: { <fs_result>-Nombre } |
     && | salario : { <fs_result>-Waers } { <fs_result>-Salario } |
     && | departamento: { <fs_result>-departamento } | ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

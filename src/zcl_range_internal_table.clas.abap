" SIGN I (INCLUIR)|E (EXCLUIR)
" OPTION EQ|NE (DISTINTO)| BT (ENTRE) | NB (NO ENTRE) |CP NO CONTIENE PATRON
" LOW VALOR BAJO
" HIGH VALOR ALTO
CLASS zcl_range_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
     ty_range_departamento TYPE RANGE OF string ,

     BEGIN OF ty_empleado,
       id TYPE i,
       nombre TYPE c LENGTH 30,
       departamento TYPE c LENGTH 30,
     END OF ty_empleado.
   DATA:
       gr_departamento TYPE ty_range_departamento,
       gt_empleado TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id.
ENDCLASS.

CLASS zcl_range_internal_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    INSERT LINES OF VALUE #( BASE gt_empleado
      ( id = 1 nombre = 'JUAN' departamento = 'TI' )
      ( id = 2 nombre = 'JOSE' departamento = 'VE' )
      ( id = 3 nombre = 'MIRIAN' departamento = 'TTHH' )
      ( id = 4 nombre = 'MARIA' departamento = 'VE' )
      ( id = 5 nombre = 'RAUL' departamento = 'TTHH' )
      ( id = 6 nombre = 'MIGUEL' departamento = 'TI' )
    ) INTO TABLE gt_empleado.

    APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'TI' ) to gr_departamento.

    SELECT FROM @gt_empleado as e FIELDS id, nombre, departamento
      WHERE departamento IN @gr_departamento
      INTO TABLE @DATA(lt_result).

    out->write( |.::POR DEPARTAMENTO\n| ).
    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | id: { <fs_result>-id } nombre: { <fs_result>-nombre } departamento: { <fs_result>-departamento }| ).
    ENDLOOP.

    CLEAR lt_result.

  ENDMETHOD.
ENDCLASS.

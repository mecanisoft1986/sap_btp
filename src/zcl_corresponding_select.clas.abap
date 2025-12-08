CLASS zcl_corresponding_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
          BEGIN OF ty_empl,
            n TYPE c LENGTH 30,
            d  TYPE c LENGTH 30,
          END OF ty_empl.
   DATA:
       gt_empleado TYPE STANDARD TABLE OF ty_empl WITH EMPTY KEY,
       gr_departamento TYPE RANGE OF string.
ENDCLASS.



CLASS zcl_corresponding_select IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'TI' ) TO gr_departamento.

    SELECT nombre as n , departamento as d FROM z_i_empleados
      WHERE departamento IN @gr_departamento
      INTO CORRESPONDING FIELDS OF TABLE @gt_empleado.

    LOOP AT gt_empleado ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( |nombre { <fs_result>-n } departamento { <fs_result>-d }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

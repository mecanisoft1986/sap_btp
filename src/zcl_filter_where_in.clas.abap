* practica de filtro.
CLASS zcl_filter_where_in DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  TYPES:
      BEGIN OF ty_empleado,
        id TYPE i,
        nombre TYPE string,
      END OF ty_empleado,

      gt_empleado_table TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id.

  DATA:
      "tabla con la data
      gt_empleado TYPE gt_empleado_table,
      "ids para filtrar
      gt_id_empleados TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.

ENDCLASS.



CLASS ZCL_FILTER_WHERE_IN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado .

    gt_empleado = VALUE #(
     ( id = 1 nombre = 'JUAN' )
     ( id = 2 nombre = 'BYRON' )
     ( id = 3 nombre = 'GABRIELA' )
     ( id = 4 nombre = 'PAOLA' )
     ( id = 5 nombre = 'GISELLA' )
     ( id = 6 nombre = 'PRICILA' )
     ( id = 7 nombre = 'AMELIA' )

    ).

    APPEND 1 TO gt_id_empleados.
    APPEND 3 TO gt_id_empleados.
    APPEND 7 TO gt_id_empleados.

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
      out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre }| ) .
    ENDLOOP.

    out->write( | \n FILTRO \n| ) .

    DATA(gt_empleados_filtrados) = FILTER gt_empleado_table( gt_empleado IN gt_id_empleados WHERE id = table_line ).

    LOOP AT gt_empleados_filtrados ASSIGNING <fs_empleado>.
      out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

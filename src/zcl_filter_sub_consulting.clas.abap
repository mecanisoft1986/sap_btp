* esto es una prueba de concepto, siempre puedes usar un where edad > 18 directo en el LOOP AT
CLASS zcl_filter_sub_consulting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_empleado,
        id     TYPE i,
        nombre TYPE c LENGTH 30,
        edad   TYPE i,
      END OF ty_empleado,

      gt_empleado_table TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id.

    DATA: gt_empleado TYPE gt_empleado_table,
          gt_ids_filtro TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.

ENDCLASS.



CLASS ZCL_FILTER_SUB_CONSULTING IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado.

    gt_empleado = VALUE #(
      ( id = 1 nombre = 'JUAN'   edad = 39 )
      ( id = 2 nombre = 'RAUL'   edad = 18 )
      ( id = 3 nombre = 'MIGUEL' edad = 19 )
      ( id = 4 nombre = 'SAMUEL' edad = 17 )
      ( id = 5 nombre = 'MIRIAN' edad = 30 )
    ).

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
      out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } edad: { <fs_empleado>-edad } | ).
    ENDLOOP.

    out->write( |\n FILTRO \n| ).

    " Crear tabla de IDs filtrados
    gt_ids_filtro = VALUE #(
        FOR ls_empleado IN gt_empleado WHERE ( edad > 18 )
        ( ls_empleado-id )
    ).

    " Filtrar empleados según la tabla de IDs
    DATA(gt_empleados_filtrados) = FILTER gt_empleado_table( gt_empleado IN gt_ids_filtro WHERE id = table_line ).

    LOOP AT gt_empleados_filtrados ASSIGNING <fs_empleado>.
      out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } edad: { <fs_empleado>-edad } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

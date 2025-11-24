CLASS zcl_dinamic_key DEFINITION
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
          nombre TYPE c LENGTH 10,
          departamento TYPE c LENGTH 10,
        END OF ty_empleado.
    DATA:
        gt_empleado TYPE STANDARD TABLE OF ty_empleado
          WITH NON-UNIQUE KEY id
          WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTS nombre
          WITH NON-UNIQUE SORTED KEY k_departamento COMPONENTS departamento,
        gs_empleado TYPE ty_empleado.

ENDCLASS.



CLASS zcl_dinamic_key IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lv_key) = 'nombre'.
    DATA(lv_departamento) = 'departamento'.

    FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado.

    gt_empleado = VALUE #(
        ( id = 1 nombre = 'JUAN' departamento = 'TI' )
        ( id = 2 nombre = 'KAEL' departamento = 'TI' )
        ( id = 3 nombre = 'KEN' departamento = 'VE' )
     ).

     INSERT LINES OF VALUE #( BASE gt_empleado
       ( id = 4 nombre = 'JULIO' departamento = 'VE' )
       ( id = 5 nombre = 'MARCO' departamento = 'TTHH' )
       ( id = 6 nombre = 'MIRIAN' departamento = 'TTHH' )
     ) INTO TABLE gt_empleado .

     INSERT VALUE #( id = 7 nombre = 'HOMERO' departamento = 'TI' ) INTO TABLE gt_empleado.

     APPEND VALUE #( id = 8  nombre = 'LISA' departamento = 'BI' ) TO gt_empleado.

     gs_empleado-id = 9.
     gs_empleado-nombre = 'ROSA'.
     gs_empleado-departamento = 'BI'.

     INSERT gs_empleado INTO TABLE gt_empleado.

     gs_empleado-id = 10.
     gs_empleado-nombre = 'RAUL'.
     gs_empleado-departamento = 'BI'.

     APPEND gs_empleado TO gt_empleado.

     APPEND INITIAL LINE TO gt_empleado ASSIGNING <fs_empleado>.
     <fs_empleado>-id = 11.
     <fs_empleado>-nombre = 'MARIAM'.
     <fs_empleado>-departamento = 'BI'.

     READ TABLE gt_empleado WITH KEY (lv_key) = 'JUAN'  ASSIGNING <fs_empleado>.

     IF sy-subrc = 0.
       out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento }| ).
     ENDIF.

     out->write( |\n| ).

     LOOP AT gt_empleado ASSIGNING <fs_empleado>.
        out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento }| ).
     ENDLOOP.

  ENDMETHOD.
ENDCLASS.

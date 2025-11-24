CLASS zcl_secondary_keys2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        BEGIN OF ty_empl,
         id TYPE i,
         nombre TYPE string,
         depto TYPE string,
        END OF ty_empl.

    DATA: it  TYPE STANDARD TABLE OF ty_empl
          WITH NON-UNIQUE KEY id
          WITH NON-UNIQUE SORTED KEY por_nombre COMPONENTS nombre
          WITH NON-UNIQUE SORTED KEY por_dpto COMPONENTS depto.

ENDCLASS.



CLASS zcl_secondary_keys2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    FIELD-SYMBOLS <fs_empl> TYPE ty_empl.

    DATA(vl_empleado) = 'JUAN'.
    DATA(vl_dpto) = 'TI'.

    out->write( |.:: TODOS ::.\n|  ).

    it = VALUE #(
     ( id = 1 nombre = 'JUAN' depto = 'TI' )
     ( id = 2 nombre = 'JOSE' depto = 'BI' )
     ( id = 3 nombre = 'MARIO' depto = 'CA' )
     ( id = 4 nombre = 'MIGUEL' depto = 'CA' )
     ( id = 5 nombre = 'DANIEL' depto = 'TI' )
     ( id = 6 nombre = 'ERNESTO' depto = 'BI' )
     ).

     LOOP AT it ASSIGNING <fs_empl>.
       out->write( |id = { <fs_empl>-id } nombre = { <fs_empl>-nombre } depto = { <fs_empl>-depto }| ).
     ENDLOOP.

     out->write( |\n.:: POR NOMBRE ::.\n| ).

     READ TABLE it WITH TABLE KEY por_nombre COMPONENTS nombre = vl_empleado INTO DATA(ls).

     IF sy-subrc = 0.
       out->write( |id: { ls-id } nombre: { ls-nombre } depto: { ls-depto }| ).
     ELSE.
       out->write( |NO ENCONTRADO { vl_empleado }| ) .
     ENDIF.

     out->write( |\n.:: POR DEPARTAMENTO ::.\n| ).

     LOOP AT it ASSIGNING <fs_empl> USING KEY por_dpto WHERE depto = vl_dpto.
       out->write( |id = { <fs_empl>-id } nombre = { <fs_empl>-nombre } depto = { <fs_empl>-depto }| ).
     ENDLOOP.

  ENDMETHOD.
ENDCLASS.

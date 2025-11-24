CLASS zcl_binary_search DEFINITION
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
       WITH NON-UNIQUE SORTED KEY k_departamento COMPONENTS Departamento,
     gs_empleado TYPE ty_empleado.
ENDCLASS.



CLASS zcl_binary_search IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado.

    "esta forma borra el contenido inicial
    gt_empleado = VALUE #(
     ( id = 1 nombre = 'MIGUEL' departamento = 'TI' )
     ( id = 2 nombre = 'MARCO' departamento = 'BI' )
    ).

 " inserta al ultimo
    INSERT LINES OF VALUE #( BASE gt_empleado
        ( id = 3 nombre = 'JUAN' departamento = 'TI' )
        ( id = 4 nombre = 'MARIA' departamento = 'BI' )
        ( id = 5 nombre = 'LAURA' departamento = 'TTHH' )
        ( id = 6 nombre = 'MARIAN' departamento = 'BI' )
        ( id = 7 nombre = 'JOSE' departamento = 'TI' )
        ( id = 8 nombre = 'MARIO' departamento = 'TTHH' )
    ) INTO TABLE gt_empleado.


    "inserta al ultimo
    INSERT VALUE #( id = 9 nombre = 'LUIS' departamento = 'BI' ) INTO TABLE gt_empleado.

    APPEND VALUE #( id = 10 nombre = 'DAMIAN' departamento = 'VE' ) TO gt_empleado.


    gs_empleado-id = 11.
    gs_empleado-nombre = 'PAULIN'.
    gs_empleado-departamento = 'VE'.

    INSERT gs_empleado INTO TABLE gt_empleado.

     "inserta en una posicion index
    gs_empleado-id = 12.
    gs_empleado-nombre = 'ROBERT'.
    gs_empleado-departamento = 'VE'.

    INSERT gs_empleado INTO gt_empleado INDEX 3.

    "insertar al inicio
    APPEND INITIAL LINE TO gt_empleado ASSIGNING <fs_empleado>.
    <fs_empleado>-id = 13.
    <fs_empleado>-nombre = 'ISMAEL'.
    <fs_empleado>-departamento = 'VE'.

    INSERT INITIAL LINE INTO gt_empleado INDEX 1 ASSIGNING <fs_empleado>.
    <fs_empleado>-id = 14.
    <fs_empleado>-nombre = 'ISRAEL'.
    <fs_empleado>-departamento = 'TI'.

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
      out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).
    ENDLOOP.

    SORT gt_empleado BY departamento ASCENDING nombre DESCENDING.

    out->write( | \n.::SORTING::.\n| ).

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
     out->write(  |id: { <fs_empleado>-id } nombre:{ <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento }| ).
    ENDLOOP.

    out->write( |\n| ).
    READ TABLE gt_empleado ASSIGNING <fs_empleado> WITH KEY departamento = 'TI' nombre = 'JUAN' BINARY SEARCH.

    IF sy-subrc = 0.
      out->write( |ENCONTRADO JUAN { sy-tabix }.\n| ).
    ELSE.
      out->write( |NO ENCONTRADO JUAN.\n| ).
    ENDIF.

    SORT gt_empleado BY nombre ASCENDING.
    READ TABLE gt_empleado ASSIGNING <fs_empleado> WITH KEY nombre = 'ROBERT' BINARY SEARCH.

    IF sy-subrc = 0.
     out->write(  |ENCONTRADO ROBERT. { sy-tabix }. \n | ).
    ELSE.
     out->write(  |NO ENCONTRADO ROBERT.| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.

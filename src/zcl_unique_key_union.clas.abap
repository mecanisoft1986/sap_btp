CLASS zcl_unique_key_union DEFINITION
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
     nombre TYPE c LENGTH 10,
     departamento TYPE c LENGTH 12,
   END OF  ty_empl.

   DATA: gt_empleado TYPE STANDARD TABLE OF ty_empl
          WITH NON-UNIQUE KEY id
          WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTs nombre,
         gt_empleado1 TYPE STANDARD TABLE OF ty_empl
          WITH NON-UNIQUE KEY id
          WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTS nombre,
         gt_union_table TYPE STANDARD TABLE OF ty_empl WITH NON-UNIQUE KEY id
          WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTS nombre.
ENDCLASS.



CLASS zcl_unique_key_union IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS <fs_empleado> TYPE ty_empl.

    gt_empleado =  VALUE #(
     ( id = 1 nombre = 'MARIA' departamento = 'VE' )
     ( id = 2 nombre = 'ANA' departamento =  'TTHH' )
     ( id = 3 nombre = 'VALERIA' departamento = 'VE' )
    ).

    INSERT LINES OF VALUE #( BASE gt_empleado1
     ( id = 4 nombre = 'JUAN' departamento = 'TI' )
     ( id = 5 nombre = 'JOSE' departamento = 'TI' )
     ( id = 6 nombre = 'MARIAN' departamento = 'TTHH' )
    ) INTO TABLE gt_empleado1.


    APPEND LINES OF gt_empleado TO gt_union_table.
    APPEND LINES OF gt_empleado1 TO gt_union_table.

    SORT gt_union_table BY id nombre departamento.

    DELETE ADJACENT DUPLICATES FROM gt_union_table COMPARING ALL FIELDS.

    LOOP AT gt_union_table ASSIGNING <fs_empleado>.
        out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

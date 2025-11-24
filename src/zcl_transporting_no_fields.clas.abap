CLASS zcl_transporting_no_fields DEFINITION
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
        departamento TYPE C LENGTH 20,
      END OF ty_empleado.
  DATA:
      gt_empleado TYPE STANDARD TABLE OF ty_empleado
        WITH  NON-UNIQUE KEY id
        WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTS nombre
        WITH NON-UNIQUE SORTED KEY k_departamento COMPONENTS departamento.

ENDCLASS.



CLASS zcl_transporting_no_fields IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado.

    INSERT LINES OF VALUE  #( BASE gt_empleado
      ( id = 1 nombre = 'JUAN' departamento = 'TI' )
      ( id = 2 nombre = 'RAUL' departamento = 'BI' )
      ( id = 3 nombre = 'PAUL' departamento = 'RRHH' )
      ( id = 4 nombre = 'ERNESTO' departamento = 'TI' )
      ( id = 5 nombre  = 'JOSE' departamento = 'BI' )
      ( id = 6 nombre = 'PENELOPE' departamento = 'RRHH' )
     ) INTO TABLE gt_empleado.

     " if exist
     READ TABLE gt_empleado WITH KEY id = 6 TRANSPORTING NO FIELDS BINARY SEARCH.

     IF sy-subrc = 0.
       out->write( |EXISTS!!! { sy-tabix  }| ).
     ELSE.
       out->write( |NOT EXIST!!| ).
     ENDIF.

     "busca la fila en la tabla pero no me traigas los datos
     READ TABLE gt_empleado WITH KEY k_nombre COMPONENTS nombre = 'JUAN' TRANSPORTING NO FIELDS.

     IF sy-subrc = 0.
      READ TABLE gt_empleado WITH KEY k_nombre COMPONENTS nombre = 'JUAN'  ASSIGNING <fs_empleado>.
      out->write( |EXITS POSICION: { SY-tabix } id: { <fs_empleado>-id }| ).
     ENDIF.

     out->write( |\n| ).
     LOOP AT gt_empleado USING KEY k_nombre ASSIGNING <fs_empleado>.
       out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).
     ENDLOOP.
  ENDMETHOD.
ENDCLASS.

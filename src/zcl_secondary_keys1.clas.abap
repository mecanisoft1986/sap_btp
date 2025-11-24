CLASS zcl_secondary_keys1 DEFINITION
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
        nombre TYPE c LENGTH 30,
        departamento type c LENGTH 45,
      END OF ty_empleado.

  DATA:
      lt_empleado TYPE STANDARD TABLE OF ty_empleado
        WITH NON-UNIQUE key id
        WITH NON-UNIQUE SORTED KEY k_nombre COMPONENTS nombre
        WITH NON-UNIQUE SORTED KEY k_departamento COMPONENTS departamento.


ENDCLASS.


CLASS zcl_secondary_keys1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado.

   DATA c_nombre  TYPE c LENGTH 10  VALUE 'JUAN'.
   DATA c_departamento TYPE C LENGTH 10 VALUE 'TI'.

   INSERT LINES OF VALUE #( BASE lt_empleado
    ( id = 1 nombre = 'JUAN' departamento = 'TI' )
    ( id = 2 nombre = 'JOSE' departamento = 'BI' )
    ( id = 3 nombre = 'MARIO' departamento = 'TI' )
    ( id = 4 nombre = 'MIRIAN' departamento = 'BI' )
    ( id = 5 nombre = 'MARIA' departamento = 'BI' )
   ) INTO TABLE lt_empleado.

   READ TABLE lt_empleado WITH TABLE KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.

   IF sy-subrc = 0.
    out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento { <fs_empleado>-departamento } | ).
   ENDIF.

   out->write( |\n| ).

   LOOP AT lt_empleado ASSIGNING <fs_empleado> USING KEY k_departamento WHERE departamento = c_departamento.
     out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento { <fs_empleado>-departamento } | ).
   ENDLOOP.

   c_nombre = 'JOSE'.

   READ TABLE lt_empleado WITH TABLE KEY K_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.

   out->write( |\n| ).

   IF sy-subrc = 0 .
     out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento { <fs_empleado>-departamento } | ).
   ELSE.
     out->write( |ERROR| ).
   ENDIF.

   out->write( |\n| ).

   c_departamento = 'BI'.

   LOOP AT lt_empleado ASSIGNING <fs_empleado> USING KEY k_departamento WHERE departamento = C_departamento.
      out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento { <fs_empleado>-departamento } | ).
   ENDLOOP.

   INSERT LINES OF VALUE #( BASE lt_empleado
        ( id = 6 nombre = 'ROSARIO' departamento = 'RRHH' )
        ( id = 7 nombre = 'ROSA' departamento = 'RRHH' )
        ( id = 8 nombre = 'MIRNA' departamento = 'RRHH' )
   ) INTO TABLE lt_empleado.

  out->write( |\n | ).

  c_nombre = 'ROSA'.
  READ TABLE lt_empleado WITH KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.
  out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).

  out->write( |\n | ).

  c_nombre = 'MARIO'.
  READ TABLE lt_empleado WITH KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.
  out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).

  out->write( |\n | ).

  c_nombre = 'MIRNA'.
  READ TABLE lt_empleado WITH KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.
  out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).

  out->write( |\n | ).

  c_nombre = 'ROSA'.
  READ TABLE lt_empleado WITH KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.
  out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).

  out->write( |\n | ).

  c_departamento = 'RRHH'.
  LOOP AT lt_empleado ASSIGNING <fs_empleado> USING KEY k_departamento WHERE departamento = c_departamento.
     out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).
  ENDLOOP.

  out->write( |\n | ).

  c_departamento = 'TI'.
  LOOP AT lt_empleado ASSIGNING <fs_empleado> USING KEY k_departamento WHERE departamento = c_departamento.
    out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).
  ENDLOOP.

  INSERT LINES OF VALUE #( BASE lt_empleado
   ( id = 9  nombre = 'RAUL' departamento = 'FI' )
   ( id = 10 nombre = 'NORMA' departamento = 'FI' )
   ( id = 11 nombre = 'VERONICA' departamento = 'FI' )
   ( id = 12 nombre = 'PAOLA'  departamento = 'FI' )
  ) INTO TABLE lt_empleado.

  out->write( |\n | ).

  c_nombre = 'PAOLA'.
  READ TABLE lt_empleado WITH KEY k_nombre COMPONENTS nombre = c_nombre ASSIGNING <fs_empleado>.
  out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).

  out->write( |\n | ).
  c_departamento = 'FI'.
  LOOP AT lt_empleado ASSIGNING <fs_empleado> USING KEY k_departamento WHERE departamento = c_departamento .
   out->write( |id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre } departamento: { <fs_empleado>-departamento } | ).
  ENDLOOP.

  ENDMETHOD.
ENDCLASS.

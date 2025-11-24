* practica de sorted table
CLASS zcl_no_unique_key DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        id_type TYPE i,
        nombre_type TYPE C LENGTH 100,

        BEGIN OF ty_empleado,
          id TYPE id_type,
          nombre TYPE nombre_type,
          id_departamento TYPE id_type,
        END OF ty_empleado.

     DATA:
        gt_empleado TYPE SORTED TABLE OF ty_empleado WITH NON-UNIQUE KEY id_departamento .

ENDCLASS.



CLASS ZCL_NO_UNIQUE_KEY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   FIELD-SYMBOLS <fs_empleado> TYPE ty_empleado .

   gt_empleado = VALUE #(
    ( id = 1 nombre = 'MANUEL' id_departamento = 1 )
    ( id = 2 nombre = 'Miguel' id_departamento = 1 )
    ( id = 3 nombre = 'Jose' id_departamento = 2 )
   ).

   LOOP AT gt_empleado ASSIGNING <fs_empleado>.
     out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre }| ) .
   ENDLOOP.

   out->write( |\n| ).

   LOOP AT gt_empleado ASSIGNING <fs_empleado> WHERE id_departamento = 1.
     out->write( | id: { <fs_empleado>-id } nombre: { <fs_empleado>-nombre }| ).
   ENDLOOP.


  ENDMETHOD.
ENDCLASS.

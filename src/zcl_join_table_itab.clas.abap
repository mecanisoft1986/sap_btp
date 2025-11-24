* practica join tablas internas.
CLASS zcl_join_table_itab DEFINITION
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
             nombre TYPE c LENGTH 200,
             departamento_id TYPE i,
           END OF ty_empleado,

           BEGIN OF ty_departamento,
             id TYPE i,
             nombre TYPE c LENGTH 200,
           END OF ty_departamento,

           BEGIN OF ty_resultado,
             empleado TYPE c LENGTH 200,
             departamento TYPE c LENGTH 200,
           END OF ty_resultado.

    DATA:
        gt_empleado TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id,
        gt_departamento TYPE STANDARD TABLE OF ty_departamento WITH NON-UNIQUE KEY id,
        gt_resultado TYPE STANDARD TABLE OF ty_resultado WITH EMPTY KEY.

ENDCLASS.



CLASS ZCL_JOIN_TABLE_ITAB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    gt_empleado = VALUE #(
        ( id = 1  nombre = 'JUAN' departamento_id = 1 )
        ( id = 2 nombre = 'MARIA' departamento_id = 2 )
        ( id = 3 nombre = 'PABLO' departamento_id = 1 )
        ( id = 4 nombre = 'PEDRO' departamento_id = 2 )
     ) .

    APPEND VALUE #( id = 1 nombre = 'TI' ) TO gt_departamento.
    APPEND VALUE #( id = 2 nombre = 'BI' ) TO gt_departamento.

    " inner join

    SELECT e~nombre AS empleado, d~nombre as departamento FROM @gt_empleado AS e
    INNER JOIN @gt_departamento AS d ON e~departamento_id = d~id
    INTO TABLE @gt_resultado.

    LOOP AT gt_resultado ASSIGNING FIELD-SYMBOL(<fs_resultado>).
      out->write( |EMPLEADO: { <fs_resultado>-empleado } DEPARTAMENTO: { <fs_resultado>-departamento } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

* practica de clear table

CLASS zcl_clear_ejemplo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ti_empleado,
      id TYPE i,
      nombre TYPE string,
    END OF ti_empleado.

    DATA: gt_empleado TYPE STANDARD TABLE OF ti_empleado,
          gs_empleado TYPE ti_empleado.

ENDCLASS.



CLASS ZCL_CLEAR_EJEMPLO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    gs_empleado-id = 1.
    gs_empleado-nombre = 'JUAN CARLOS CONSTANTINE' .
    APPEND gs_empleado TO gt_empleado.

    gs_empleado-id = 2.
    gs_empleado-nombre = 'GABRIELA GAMBOA' .
    APPEND gs_empleado to gt_empleado .

    gs_empleado-id = 3.
    gs_empleado-nombre = 'EROS CONSTANTINE'.
    APPEND gs_empleado to gt_empleado .

    LOOP AT gt_empleado INTO gs_empleado .
      out->write( |{ gs_empleado-id } - { gs_empleado-nombre }| ) .
    ENDLOOP.

    CLEAR gt_empleado.

    out->write( |\n| ).

    IF gt_empleado IS INITIAL.
      out->write( | la tabla fue vaciada| ).
    ELSE.
      out->write( | ERROR la tabla contiene datos| ) .
    ENDIF.

    LOOP AT gt_empleado INTO gs_empleado .
      out->write( |{ gs_empleado-id } - { gs_empleado-nombre }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

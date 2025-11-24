CLASS zcl_asignacion_datos_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF ty_empleado,
      id TYPE i,
      nombre TYPE string,
    END OF ty_empleado.

    DATA gt_empleado TYPE STANDARD TABLE OF ty_empleado.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ASIGNACION_DATOS_TABLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS: <fs_empleado> TYPE ty_empleado .

    APPEND VALUE #( id = 1 nombre = 'JUAN CARLOS CONSTANTINE' ) TO gt_empleado.
    APPEND VALUE #( id = 2 nombre = 'GABRIELA GAMBOA' ) TO gt_empleado.
    APPEND VALUE #( id = 3 nombre = 'EROS CONSTANTINE' ) TO gt_empleado.
    APPEND VALUE #( id = 4 nombre = 'AMELIA CONSTANTINE' ) TO gt_empleado.

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
      out->write( |ID: { <fs_empleado>-id } NOMBRE: { <fs_empleado>-nombre }| ).
    ENDLOOP.

    LOOP AT gt_empleado ASSIGNING <fs_empleado> WHERE id = 2.
      <fs_empleado>-nombre = 'GABRIELA GAMBOA CALDERON'.
    ENDLOOP.

    READ TABLE gt_empleado ASSIGNING <fs_empleado> WITH KEY id = 1.

    IF sy-subrc = 0.
      out->write( |{ <fs_empleado>-nombre } | ).
    ELSE.
      out->write( |EMPLEADO NO ENCONTRADO.| ).
    ENDIF.

    LOOP AT gt_empleado ASSIGNING <fs_empleado>.
      out->write( |ID: { <fs_empleado>-id } NOMBRE:  { <fs_empleado>-nombre }| ).
    ENDLOOP.



  ENDMETHOD.
ENDCLASS.

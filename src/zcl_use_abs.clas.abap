CLASS zcl_use_abs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: go_implements_abs TYPE REF TO zcl_implement_abs.
ENDCLASS.



CLASS zcl_use_abs IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    go_implements_abs = NEW zcl_implement_abs( ).
    go_implements_abs->set_value( 'hola mundo ' ).
    out->write( | { go_implements_abs->get_value( ) } | ).


  ENDMETHOD.
ENDCLASS.

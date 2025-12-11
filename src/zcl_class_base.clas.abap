CLASS zcl_class_base DEFINITION PUBLIC FINAL.

  PUBLIC SECTION.

    METHODS suma_numeros IMPORTING number1 TYPE i number2 TYPE i RETURNING VALUE(total) TYPE i.
    CLASS-METHODS get_version RETURNING VALUE(rv_version) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_class_base IMPLEMENTATION.

 METHOD suma_numeros.
   total = number1 + number2.
 ENDMETHOD.

 METHOD get_version.
   rv_version = 'v1.0'.
 ENDMETHOD.

ENDCLASS.

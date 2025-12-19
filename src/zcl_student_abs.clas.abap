CLASS zcl_student_abs DEFINITION PUBLIC ABSTRACT
 CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS set_value ABSTRACT
      IMPORTING iv_a TYPE string.

    METHODS get_value
      RETURNING VALUE(rv_a) TYPE string.

  PROTECTED SECTION.
    DATA mv_value TYPE string.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_student_abs IMPLEMENTATION.
  METHOD get_value.
    rv_a = mv_value.
  ENDMETHOD.
ENDCLASS.

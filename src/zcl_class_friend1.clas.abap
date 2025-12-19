CLASS zcl_class_friend1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_class_fiend2.

  PUBLIC SECTION.
    METHODS setNombre IMPORTING nombre_ TYPE string.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA nombre TYPE string.

ENDCLASS.

CLASS zcl_class_friend1 IMPLEMENTATION.
 METHOD setNombre.
  nombre = nombre_.
 ENDMETHOD.
ENDCLASS.

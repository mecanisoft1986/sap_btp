CLASS zcl_class_fiend2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   METHODS crear_secreto IMPORTING s  TYPE string friend_class TYPE REF TO zcl_class_friend1
     RETURNING VALUE(text) TYPE STRING.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_class_fiend2 IMPLEMENTATION.
  METHOD crear_secreto.
    text = | { s } { friend_class->nombre } |.
  ENDMETHOD.
ENDCLASS.

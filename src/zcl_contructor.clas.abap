CLASS zcl_contructor DEFINITION PUBLIC FINAL.

  PUBLIC SECTION.
    CLASS-METHODS:
      CLASS_CONSTRUCTOR.
    METHODS:
      CONSTRUCTOR IMPORTING iv_marca TYPE string,
      mostrar_marca RETURNING VALUE(rv_marca) TYPE string.
    CLASS-DATA:
      gv_contador TYPE i VALUE 0.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_marca TYPE string.
ENDCLASS.



CLASS zcl_contructor IMPLEMENTATION.
  METHOD class_constructor.
     gv_contador = gv_contador + 1.
  ENDMETHOD.
  METHOD CONSTRUCTOR.
    me->mv_marca = iv_marca.
  ENDMETHOD.

  METHOD mostrar_marca.
    rv_marca = me->mv_marca.
  ENDMETHOD.
ENDCLASS.

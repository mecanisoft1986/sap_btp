CLASS zcl_base_instance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_base_instance IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_base_instance) = NEW zcl_class_base( ).
    DATA(total) = lo_base_instance->suma_numeros( number1 = 4 number2 = 5 ).
    DATA(version) = zcl_class_base=>get_version( ).

    out->write( |Total: { total } | ).
    out->write( |Versión de la clase: { version } | ).
  ENDMETHOD.
ENDCLASS.

CLASS zcl_do_times DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_do_times IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(count_) = 0.
    DO 8 TIMES.
     count_ = count_ + 1.
     out->write( |LOOP TIME { count_ } index  { sy-index }| ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.

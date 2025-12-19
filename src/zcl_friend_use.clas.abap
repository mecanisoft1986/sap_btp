CLASS zcl_friend_use DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_friend_use IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lc_friend1) = NEW zcl_class_friend1( ).
    lc_friend1->setNombre( 'casimiro pocas cejas' ).

    DATA(lc_friend2) = NEW zcl_class_fiend2( ).

    out->write( lc_friend2->crear_secreto( s = 'de la loma mas alta' friend_class = lc_friend1  ) ).


  ENDMETHOD.
ENDCLASS.

CLASS zcl_use_constructor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA construc_ TYPE REF TO zcl_contructor.
ENDCLASS.



CLASS zcl_use_constructor IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
      me->construc_ = NEW zcl_contructor( 'TOYOTA' ).

      out->write( | marca: { construc_->mostrar_marca( ) } | ) .

      out->write( | contador { construc_->gv_contador } | ).
  ENDMETHOD.

ENDCLASS.

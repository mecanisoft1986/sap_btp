CLASS zcx_client_update_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !text     TYPE string OPTIONAL.
    METHODS get_text REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_text TYPE string.
ENDCLASS.



CLASS zcx_client_update_error IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.


    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->mv_text = text.
  ENDMETHOD.

  METHOD get_text.

    IF me->mv_text IS NOT INITIAL.
      result = me->mv_text.
    ELSE.
      result = super->get_text( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

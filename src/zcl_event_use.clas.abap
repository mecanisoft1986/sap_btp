CLASS zcl_event_use DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: go_event  TYPE REF TO zcl_event,
          go_logger TYPE REF TO zcl_grade_logger.
ENDCLASS.

CLASS zcl_event_use IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    go_event = NEW zcl_event( ).
    go_logger = NEW zcl_grade_logger( ).

    SET HANDLER go_logger->on_grade_changed FOR go_event.

    go_event->set_grade( iv_student_id = 101 iv_grade = 18 ).
    go_event->set_grade( iv_student_id = 102 iv_grade = 11 ).
    go_event->set_grade( iv_student_id = 99 iv_grade = 17 ).

    DATA(message) = go_logger->get_messages( ).

    LOOP AT message ASSIGNING FIELD-SYMBOL(<fs_me>).
      out->write( <fs_me> ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

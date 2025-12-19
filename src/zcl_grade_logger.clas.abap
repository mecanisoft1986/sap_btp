CLASS zcl_grade_logger DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_string_list TYPE STANDARD TABLE OF string WITH DEFAULT KEY.
    METHODS on_grade_changed FOR EVENT grade_changed OF zcl_event IMPORTING student_id new_grade.
    METHODS get_messages RETURNING VALUE(rt_messages) TYPE tt_string_list.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mt_messages TYPE tt_string_list.

ENDCLASS.



CLASS zcl_grade_logger IMPLEMENTATION.
  METHOD on_grade_changed.
    APPEND | Student { student_id } -> grade { new_grade } | TO mt_messages.
  ENDMETHOD.

  METHOD get_messages.
    rt_messages = mt_messages.
  ENDMETHOD.
ENDCLASS.

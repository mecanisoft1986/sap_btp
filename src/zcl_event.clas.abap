CLASS zcl_event DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS set_grade IMPORTING iv_student_id TYPE i iv_grade TYPE i.
    EVENTS grade_changed EXPORTING VALUE(student_id) TYPE i VALUE(new_grade) type i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_event IMPLEMENTATION.
  METHOD set_grade.
    RAISE EVENT grade_changed EXPORTING student_id = iv_student_id  new_grade = iv_grade.
  ENDMETHOD.
ENDCLASS.

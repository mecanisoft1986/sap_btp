CLASS zcl_test_cds_one_to_one DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_cds_one_to_one IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT id,nombre, departamento FROM z_c_EmpleadoConDepartamento INTO TABLE @DATA(lt_result).

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | id: { <fs_result>-Id } nombre: { <fs_result>-Nombre  } departamento: { <fs_result>-departamento } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

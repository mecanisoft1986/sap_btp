CLASS zcl_limit_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_empleado,
        id TYPE i,
        nombre TYPE C LENGTH 30,
        dept_id TYPE i,
      END OF ty_empleado,

     ty_range_departamento TYPE RANGE OF string ,

      BEGIN OF ty_departamento,
        id TYPE i,
        nombre TYPE c LENGTH 30,
      END OF ty_departamento,

      BEGIN OF ty_result,
        empleado TYPE c LENGTH 30,
        departamento TYPE C LENGTH 30,
      END OF ty_result.

    DATA:
        gr_departamento_range TYPE ty_range_departamento,

        gt_empleado TYPE STANDARD TABLE OF ty_empleado WITH KEY id
          WITH NON-UNIQUE SORTED KEY key_nombre COMPONENTS nombre,

        gt_departamento TYPE STANDARD TABLE OF ty_departamento WITH KEY id
          WITH NON-UNIQUE SORTED KEY key_nombre COMPONENTS nombre,

        gt_result TYPE STANDARD TABLE OF ty_result
        WITH EMPTY KEY.


ENDCLASS.



CLASS zcl_limit_select IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_empleado TYPE ty_empleado.

    gt_departamento = VALUE #(
     ( id = 1 nombre = 'TI' )
     ( id = 2 nombre = 'TTHH' )
     ( id = 3 nombre = 'BI' )
      ( id = 4 nombre = 'CO' )
      ( id = 5 nombre = 'BO' )
    ).

    gt_empleado = VALUE #(
    ( id = 1 nombre = 'JUAN' dept_id = 1 )
    ( id = 2 nombre = 'RAUL' dept_id = 1 )
    ( id = 3 nombre = 'PAUL' dept_id = 2 )
    ( id = 4 nombre = 'JOSE' dept_id = 2 )
    ( id = 5 nombre = 'MIGUEL' dept_id = 3 )
    ( id = 6 nombre = 'RAFAEL' dept_id = 4 )
    ( id = 7 nombre = 'MARCIA' dept_id = 4 )
    ( id = 8 nombre = 'GABRIELA' dept_id = 1 )
    ( id = 9 nombre = 'JAVIER' dept_id = 5 )
    ( id = 10 nombre = 'DARIO' dept_id = 5 )
    ( id = 11 nombre = 'SAMUEL' dept_id = 5 )
    ( id = 12 nombre = 'ELENA' dept_id = 1 )
    ( id = 13 nombre = 'WENDY' dept_id = 2 )
    ).


   APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'TI' ) TO gr_departamento_range.
   APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'TTHH' ) TO gr_departamento_range.

   LOOP AT gt_empleado ASSIGNING FIELD-SYMBOL(<fs_empl2>).
     out->write( | id: { <fs_empl2>-id } nombre: { <fs_empl2>-nombre }  departamento: { <fs_empl2>-dept_id }| ).
   ENDLOOP.

   out->write( |\n\n| ).

    SELECT  e~nombre as empleado, d~nombre as departamento FROM @gt_empleado as e
     INNER JOIN @gt_departamento as d on ( d~id = e~dept_id  )
     WHERE d~nombre IN @gr_departamento_range
    INTO CORRESPONDING FIELDS OF TABLE @gt_result.

   SORT gt_result  BY empleado  ASCENDING departamento DESCENDING.

    LOOP AT gt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | empleado: { <fs_result>-empleado } departamento: { <fs_result>-departamento } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

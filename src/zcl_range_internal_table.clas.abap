" SIGN I (INCLUIR)|E (EXCLUIR)
" OPTION EQ|NE (DISTINTO)| BT (ENTRE) | NB (NO ENTRE) |CP COINCIDE PATRON| NP (NO COINCIDE P)| GE (>=)| GT (>)| LE (<=)|LT (<)|
" LOW VALOR BAJO
" HIGH VALOR ALTO
CLASS zcl_range_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
     ty_range_departamento TYPE RANGE OF string ,
     ty_range_nombre TYPE RANGE OF string,

     BEGIN OF ty_empleado,
       id TYPE i,
       nombre TYPE c LENGTH 30,
       departamento TYPE c LENGTH 30,
     END OF ty_empleado,
     gt_empleado_table TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id.

   DATA:
       gr_departamento TYPE ty_range_departamento,
       gr_nombre TYPE ty_range_nombre,
       gr_excluir_departamentos TYPE ty_range_departamento,
       gt_empleado TYPE STANDARD TABLE OF ty_empleado WITH NON-UNIQUE KEY id.
ENDCLASS.

CLASS zcl_range_internal_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    INSERT LINES OF VALUE #( BASE gt_empleado
      ( id = 1 nombre = 'JUAN' departamento = 'TI' )
      ( id = 2 nombre = 'JOSE' departamento = 'VE' )
      ( id = 3 nombre = 'MIRIAN' departamento = 'TTHH' )
      ( id = 4 nombre = 'MARIA' departamento = 'VE' )
      ( id = 5 nombre = 'RAUL' departamento = 'TTHH' )
      ( id = 6 nombre = 'MIGUEL' departamento = 'TI' )
    ) INTO TABLE gt_empleado.

    APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'TI' ) to gr_departamento.

    SELECT FROM @gt_empleado AS e FIELDS id, nombre, departamento
      WHERE departamento IN @gr_departamento
      INTO TABLE @DATA(lt_result).

    out->write( |.::POR DEPARTAMENTO::.\n| ).
    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | id: { <fs_result>-id } nombre: { <fs_result>-nombre } departamento: { <fs_result>-departamento }| ).
    ENDLOOP.

    CLEAR lt_result.

    out->write( |\n.::POR DEPARTAMENTO SIN MIGUEL::.\n| ).
    APPEND VALUE #( SIGN = 'E' OPTION = 'EQ' LOW = 'MIGUEL' ) to gr_nombre .

    SELECT FROM @gt_empleado AS e FIELDS id, nombre, departamento
      WHERE departamento IN @gr_departamento  AND nombre IN @gr_nombre
      INTO table @lt_result .

    LOOP AT lt_result ASSIGNING <fs_result>.
      out->write( | id: { <fs_result>-id } nombre: { <fs_result>-nombre } departamento: { <fs_result>-departamento }| ).
    ENDLOOP.

    CLEAR lt_result.
    out->write( |\n.:: SIN DEPARTAMENTO THHH Y TI ::.\n| ).

    " forma dinamica filtra con una tabla de valores.
    DATA(gt_depts) = VALUE string_table( ( CONV string( 'TTHH' ) ) ( CONV string( 'TI' ) ) ).
    gr_excluir_departamentos = VALUE #( FOR deps IN gt_depts ( SIGN = 'E' OPTION = 'EQ' LOW = deps ) ).

    " lt_result = VALUE gt_empleado_table( FOR emp IN gt_empleado WHERE ( departamento IN gr_tthh ) ( emp ) ).

    SELECT FROM @gt_empleado AS e FIELDS id, nombre, departamento
      WHERE departamento IN @gr_excluir_departamentos
      INTO TABLE @lt_result.

    LOOP AT lt_result ASSIGNING <fs_result>.
      out->write( | id: { <fs_result>-id } nombre: { <fs_result>-nombre } departamento: { <fs_result>-departamento }| ).
    ENDLOOP.

    CLEAR gr_departamento.
    CLEAR lt_result.

    out->write( |\n.:: SOLO DEPARTAMENTO TTHH Y TI ::.\n| ).

     " funciona como un OR
     INSERT LINES OF VALUE #( BASE gr_departamento
     ( SIGN = 'I' OPTION = 'EQ' LOW = 'TI' )
     ( SIGN = 'I' OPTION = 'EQ' LOW = 'TTHH' )
    ) INTO TABLE gr_departamento.

    SELECT FROM @gt_empleado AS emp FIELDS id, nombre, departamento
      WHERE departamento IN @gr_departamento
      INTO TABLE @lt_result.

    LOOP AT lt_result ASSIGNING <fs_result>.
      out->write( | id: { <fs_result>-id } nombre: { <fs_result>-nombre } departamento: { <fs_result>-departamento }| ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

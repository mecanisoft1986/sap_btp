CLASS zcl_corresponding_structure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES :
     BEGIN OF ty_empleado,
       id TYPE i,
       nombre TYPE c LENGTH 10,
       departamento TYPE c LENGTH 15,
     END OF ty_empleado,

     BEGIN OF ty_basic,
       nombre TYPE c LENGTH 10,
       departamento TYPE c LENGTH 10,
     END OF ty_basic,

     BEGIN OF ty_mapper,
       n TYPE c LENGTH 10,
       d TYPE C LENGTH 15,
     END OF ty_mapper.
ENDCLASS.



CLASS zcl_corresponding_structure IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(src) = VALUE ty_empleado( id = 1 nombre = 'JUAN' departamento = 'TI' ) .
    DATA(dst) = CORRESPONDING ty_basic( src ).
    DATA(mp) = CORRESPONDING ty_mapper( src MAPPING n = nombre d = departamento ).

    out->write( |nombre: { dst-nombre } departamento: { dst-departamento } | ).
    out->write( |nombre: { mp-n } departamento: { mp-d } | ).

  ENDMETHOD.
ENDCLASS.

CLASS zcl_sorted_by_field DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
        TYPES:
        BEGIN OF ty_producto,
          id_producto TYPE i,
          nombre TYPE string,
          precio TYPE p LENGTH 10 DECIMALS 2,
        END OF ty_producto.
    DATA:
        lt_producto TYPE STANDARD TABLE OF ty_producto WITH NON-UNIQUE KEY id_producto.


ENDCLASS.



CLASS zcl_sorted_by_field IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    FIELD-SYMBOLS <fs_producto> TYPE ty_producto.

    lt_producto = VALUE #(
     ( id_producto = 1 nombre = 'chocolate' precio = 2 )
     ( id_producto = 2 nombre = 'galletas' precio = 1 )
     ( id_producto = 3 nombre = 'caramelos' precio = 1 )
     ( id_producto = 4 nombre = 'leche' precio = 2 )
     ( id_producto = 5 nombre = 'azucar' precio = 3 )
    ) .

    LOOP AT lt_producto ASSIGNING <fs_producto>.
      out->write( |id: { <fs_producto>-id_producto } nombre: { <fs_producto>-nombre } precio: { <fs_producto>-precio } | ).
    ENDLOOP.

    out->write(  | \n | ).

    SORT lt_producto BY NOMBRE ASCENDING PRECIO DESCENDING.

    LOOP AT lt_producto ASSIGNING <fs_producto>.
      out->write( |id: { <fs_producto>-id_producto } nombre: { <fs_producto>-nombre } precio: { <fs_producto>-precio } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

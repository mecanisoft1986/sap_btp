* practica de tabla hashed con unique default key, no se recomienda usar esta forma por ser la menos optima
CLASS zcl_unique_default_key DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_registro,
        id_materiales TYPE c LENGTH 10,
        codigo_lote TYPE c LENGTH 20,
        cantidad TYPE i,
      END OF ty_registro.

    DATA gt_registro TYPE HASHED TABLE OF ty_registro WITH UNIQUE DEFAULT KEY.

ENDCLASS.



CLASS ZCL_UNIQUE_DEFAULT_KEY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TRY.

      gt_registro = VALUE #(
        ( id_materiales = 'MAT001' codigo_lote = 'LOTE-A' cantidad = 20  )
        ( id_materiales = 'MAT002' codigo_lote = 'LOTE-B' cantidad = 10 )
       ).

   CATCH cx_sy_itab_duplicate_key.

     out->write( | ERROR KEY DUPLICADA| ).

   ENDTRY.

   LOOP AT gt_registro ASSIGNING FIELD-SYMBOL(<fs_registro>).
    out->write( |id_material: { <fs_registro>-id_materiales } codigo_lote: { <fs_registro>-codigo_lote } cantidad: { <fs_registro>-cantidad } | ).
   ENDLOOP.

  ENDMETHOD.
ENDCLASS.

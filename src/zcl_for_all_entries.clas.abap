CLASS zcl_for_all_entries DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        BEGIN OF ty_cliente_filtro,
          cliente_id TYPE i,
        END OF ty_cliente_filtro,

        BEGIN OF ty_pedido_filtro,
          pedido_id TYPE i,
        END OF ty_pedido_filtro.

    DATA:
        gt_cliente TYPE STANDARD TABLE OF ty_cliente_filtro.
ENDCLASS.



CLASS zcl_for_all_entries IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " INSERT zjccd_pedidos FROM TABLE @(
    "    VALUE #(
    "      ( pedido_id = 10 cliente_id = 100 fecha = '20250101' valor = 20 )
    "      ( pedido_id = 20 cliente_id = 200 fecha = '20250102' valor = 30 )
    "      ( pedido_id = 30 cliente_id = 300 fecha = '20250103' valor = 40 )
    "      ( pedido_id = 40 cliente_id = 100 fecha = '20250104' valor = 50 )
    "     )
    " ).
    DATA lt_resultado TYPE TABLE OF zjccd_pedidos.

    INSERT LINES OF VALUE #( BASE gt_cliente
      ( cliente_id = 100 )
      ( cliente_id = 300 )
    ) INTO TABLE gt_cliente.



    DELETE ADJACENT DUPLICATES FROM gt_cliente COMPARING cliente_id .

    SELECT * FROM zjccd_pedidos FOR ALL ENTRIES IN @gt_cliente
     WHERE cliente_id = @gt_cliente-cliente_id
     INTO TABLE @lt_resultado .

    LOOP AT lt_resultado ASSIGNING FIELD-SYMBOL(<fs_resultado>).
      out->write( |cliente_id: { <fs_resultado>-cliente_id } pedido_id: { <fs_resultado>-pedido_id } fecha: { <fs_resultado>-fecha } valor: { <fs_resultado>-valor } | ) .
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

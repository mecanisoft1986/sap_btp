* practica de ANY TABLE BY JUAN CARLOS CONSTANTINE
CLASS zcl_any_table_run DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF ty_cliente,
             id TYPE i,
             nombre TYPE string,
           END OF ty_cliente.

    TYPES: BEGIN OF ty_producto ,
             id TYPE i,
             nombre TYPE string,
             precio TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_producto.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: procesar_tabla IMPORTING it_fuente TYPE ANY TABLE it_campo TYPE string
                                              EXPORTING et_salida TYPE string_table.
    METHODS: llenar_datos.

    DATA: lt_cliente TYPE STANDARD TABLE OF ty_cliente.
    DATA: lt_productos TYPE STANDARD TABLE OF ty_producto.


ENDCLASS.



CLASS ZCL_ANY_TABLE_RUN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    me->llenar_datos( ).

    DATA(lt_nombres_clientes) = VALUE string_table( ).

    me->procesar_tabla( EXPORTING it_fuente = me->lt_cliente it_campo = 'nombre' IMPORTING et_salida = lt_nombres_clientes ).

    out->write( '|--- PROCESANDO CLIENTE --|' ).
    out->write(  lt_nombres_clientes ).
    out->write( |\n| ).
    DATA(lt_nombres_productos) = VALUE string_table( ).

    me->procesar_tabla( EXPORTING it_fuente = me->lt_productos it_campo = 'nombre' IMPORTING et_salida = lt_nombres_productos ).

    out->write( '|--- PROCESANDO PRODUCTOS --|' ) .
    OUT->write( lt_nombres_productos ).

  ENDMETHOD.


  METHOD llenar_datos.
    APPEND INITIAL LINE TO me->lt_cliente ASSIGNING FIELD-SYMBOL(<fs_cliente>).
    <fs_cliente>-id = 1.
    <fs_cliente>-nombre = 'JUAN CONSTANTINE'.

    APPEND INITIAL LINE TO me->lt_cliente ASSIGNING <fs_cliente>.
    <fs_cliente>-id = 2.
    <fs_cliente>-nombre = 'GABRIELA GAMBOA'.

    APPEND INITIAL LINE TO me->lt_productos ASSIGNING FIELD-SYMBOL(<fs_producto>).
    <fs_producto>-id = 101.
    <fs_producto>-nombre = 'Monitor 17 pulgadas'.
    <fs_producto>-precio = 150 .

    APPEND INITIAL LINE TO me->lt_productos ASSIGNING <fs_producto>.
    <fs_producto>-id = 102.
    <fs_producto>-nombre = 'Teclado mecanico'.
    <fs_producto>-precio = 50.


  ENDMETHOD.


  METHOD procesar_tabla.
    FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
                   <fs_linea> TYPE ANY,
                   <fs_campo> TYPE ANY.

    ASSIGN it_fuente TO <fs_table>.

    IF <fs_table> IS ASSIGNED.
      LOOP AT <fs_table> ASSIGNING <fs_linea>.
        ASSIGN COMPONENT it_campo OF STRUCTURE <fs_linea> TO <fs_campo>.

        IF <fs_campo> IS ASSIGNED.
          APPEND <fs_campo> TO et_salida.
        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.
ENDCLASS.

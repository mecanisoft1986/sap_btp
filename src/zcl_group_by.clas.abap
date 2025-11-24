CLASS zcl_group_by DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
        BEGIN OF ty_flight,
         carrid TYPE string,
         connid TYPE string,
         fldate TYPE d,
         price TYPE  p LENGTH 8 DECIMALS 2 ,
        END OF ty_flight.

    DATA:
        it_flight TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY,
         total TYPE p LENGTH 8 DECIMALS 2 VALUE '0.00'.

ENDCLASS.



CLASS zcl_group_by IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    INSERT LINES OF VALUE #( BASE it_flight
      ( carrid = 'AA' connid = '100' fldate = '20250110' price = '120.50'  )
      ( carrid = 'AA' connid = '100' fldate = '20250112' price = '150.50' )
      ( carrid = 'AA' connid = '200' fldate = '20250120' price = '210.00' )
      ( carrid = 'LH' connid = '300' fldate = '20250115' price = '330.99' )
      ( carrid = 'LH' connid = '300' fldate = '20250116' price = '340.20' )
    ) INTO TABLE it_flight.

    out->write( |Registros cargados: { lines( it_flight ) } | ).

    SORT it_flight BY carrid connid fldate.

    LOOP AT it_flight INTO DATA(row)
      GROUP BY ( carrid = row-carrid connid = row-connid )
      INTO DATA(group).

      out->write( |------------------------------------| ).
      out->write( |AEROLINEA: { group-carrid }| ).
      out->write( |CONEXION: { group-connid } | ).
      out->write( |VUELOS:| ).


      DATA(count) = 0.
      total = '00.00'.

      LOOP AT GROUP group INTO DATA(member).
        out->write( |Fecha: { member-fldate DATE = USER } Precio: { member-price } | ).

        total = total + member-price.
        count = count + 1.
      ENDLOOP.

      out->write( | Total vuelos grupo: { count }| ).
      out->write( | SUBTOTAL precios: { total }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

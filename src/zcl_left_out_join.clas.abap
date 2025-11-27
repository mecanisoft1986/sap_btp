CLASS zcl_left_out_join DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
       BEGIN OF ty_flight,
        flight_id TYPE i,
        carrier_id TYPE i,
        connection_id TYPE i,
        price TYPE p LENGTH 15 DECIMALS 2,
       END OF ty_flight,

       BEGIN OF ty_carrier,
        carrier_id TYPE i,
        name TYPE c LENGTH 30,
       END OF ty_carrier,

       BEGIN OF ty_conn,
        connection_id TYPE i,
        departure_city TYPE c LENGTH 30,
        arrival_city   TYPE c LENGTH 30,
       END OF ty_conn,

       BEGIN OF ty_result,
         flight_id      TYPE i,
         carrier_id     TYPE i,
         carrier_name   TYPE string,
         departure_city TYPE string,
         arrival_city   TYPE string,
         price          TYPE p LENGTH 15 DECIMALS 2,
       END OF ty_result.

       DATA:
           gt_flight TYPE STANDARD TABLE OF ty_flight WITH NON-UNIQUE KEY flight_id,
           gt_carrier TYPE STANDARD TABLE OF ty_carrier WITH NON-UNIQUE KEY carrier_id,
           gt_conn TYPE STANDARD TABLE OF ty_conn WITH NON-UNIQUE KEY connection_id,
           gt_result TYPE STANDARD TABLE OF ty_result WITH NON-UNIQUE KEY flight_id.

ENDCLASS.



CLASS zcl_left_out_join IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    FIELD-SYMBOLS <fs_result> TYPE ty_result.

    INSERT LINES OF VALUE #( BASE gt_flight
      ( flight_id = 1 carrier_id = 10 connection_id = 100 price = 120 )
      ( flight_id = 2 carrier_id = 20 connection_id = 200 price = 340 )
      ( flight_id = 3 carrier_id = 99 connection_id = 300 price = 500 )
    ) INTO TABLE gt_flight.

    INSERT LINES OF VALUE #( BASE gt_carrier
     ( carrier_id = 10 name = 'AEROSTAR' )
     ( carrier_id = 20 name = 'FLIGHTHIGH' )
    ) INTO TABLE gt_carrier.

    INSERT LINES OF VALUE #( BASE gt_conn
      ( connection_id = 100 departure_city = 'QUITO' arrival_city = 'LIMA' )
      ( connection_id = 200 departure_city = 'GUAYAQUIL' arrival_city = 'BOGOTA' )
    ) INTO TABLE gt_conn.

    SELECT f~flight_id, f~carrier_id,c~name AS carrier_name, cn~departure_city, cn~arrival_city,f~price
     FROM @gt_flight AS f
     LEFT OUTER JOIN @gt_carrier AS c ON c~carrier_id = f~carrier_id
     LEFT OUTER JOIN @gt_conn AS cn on cn~connection_id = f~connection_id
    INTO TABLE @gt_result.

    out->write( |.::LEFT OUT JOIN::. \n| ).
    LOOP AT gt_result ASSIGNING <fs_result>.
      out->write( |flight_id: { <fs_result>-flight_id } |
        && | carrier_id: { COND string( WHEN <fs_result>-carrier_id IS INITIAL THEN 'NO-EXISTE' ELSE <fs_result>-carrier_id ) } |
        && | aerolinea: { COND string( WHEN <fs_result>-carrier_name IS INITIAL THEN 'NO-EXISTE' ELSE <fs_result>-carrier_name ) }|
        && | ciudad de partida: { COND string( WHEN <fs_result>-departure_city IS INITIAL THEN 'NO-EXISTE' ELSE <fs_result>-departure_city ) } |
        && | ciudad llegada:  { COND string( WHEN <fs_result>-arrival_city IS INITIAL THEN 'NO-EXISTE' ELSE <fs_result>-arrival_city ) } |
        && | precios: { COND string( WHEN <fs_result>-price IS INITIAL THEN 'NO-EXISTE' ELSE <fs_result>-price ) } | ).
    ENDLOOP.


     CLEAR gt_result.

  ENDMETHOD.
ENDCLASS.

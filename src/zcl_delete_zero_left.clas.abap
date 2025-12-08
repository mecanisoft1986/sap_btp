CLASS zcl_delete_zero_left DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
       BEGIN OF ty_flights,
         carrid TYPE c LENGTH 30 ,
         connid TYPE c LENGTH 30 ,
         country TYPE c LENGTH 30,
       END OF ty_flights.
   DATA:
       gt_flights TYPE STANDARD TABLE OF ty_flights,
       gs_flights TYPE ty_flights.

ENDCLASS.



CLASS zcl_delete_zero_left IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    gt_flights = VALUE #(
      ( carrid = 'LH' connid = '0000345' country = 'EC' )
      ( carrid = 'AA' connid = '0000234' country = 'CN' )
      ( carrid = 'AB' connid = '000046' country = 'DE' )
    ) .


    LOOP AT gt_flights INTO gs_flights.
      SHIFT gs_flights-connid LEFT DELETING LEADING '0'.
       out->write( |carrid { gs_flights-carrid } connid: { gs_flights-connid } country { gs_flights-country } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

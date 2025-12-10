CLASS zcl_subquery DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: ty_price_p TYPE p LENGTH 15 DECIMALS 2.
ENDCLASS.



CLASS zcl_subquery IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   out->write( |\n.::CORRELACIONADO::.\n| ).
   SELECT * FROM /dmo/flight
    WHERE price = ( SELECT MAX( price ) FROM /dmo/flight )
   INTO TABLE @DATA(lt_result).

   LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   out->write( |\n.::ANY::.\n| ).

   "el precio es mayor que al menos uno de los precio de la aerolinia AA
   SELECT * FROM /dmo/flight
     WHERE price > ANY ( SELECT price FROM /dmo/flight WHERE carrier_id = 'AA' )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   out->write( |\n.::ALL::.\n| ).

   "el valor es mayor que todo los precio de la aerolinea AA
   SELECT * FROM /dmo/flight
     WHERE price > ALL ( SELECT price FROM /dmo/flight WHERE carrier_id = 'AA' )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   out->write( |\n.::SOME::.\n| ).

   "some alias de any
   SELECT * FROM /dmo/flight
     WHERE price < SOME ( SELECT price FROM /dmo/flight WHERE carrier_id = 'AA' )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   out->write( | \n.::EXITS::.\n| ).

   " un inner join es mas facil de entender, trae todo los vuelos con coneccion
   SELECT * FROM /dmo/flight as f
     WHERE EXISTS ( SELECT * FROM /dmo/connection as c
                      WHERE c~carrier_id = f~carrier_id AND c~connection_id = f~connection_id
                  )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   out->write( | \n.::NOT EXITS::.\n| ).
    " un right join es mas facil de entender, trae todo los vuelos que no tienen coneccion
   SELECT * FROM /dmo/flight as f
     WHERE NOT EXISTS ( SELECT * FROM /dmo/connection as c
                      WHERE c~carrier_id = f~carrier_id AND c~connection_id = f~connection_id
                  )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.

   IF lt_result IS INITIAL.
     out->write( |no existe vuelos sin connection.| ).
   ENDIF.

   out->write( |\n.::CORRELACIONADO 2::.\n| ).
   "trae todas las fila donde el precio es el maximo en la misma compania
   SELECT * FROM /dmo/flight as f1
     WHERE f1~price = ( SELECT MAX( f2~price )
                          FROM /dmo/flight as f2
                          WHERE f1~carrier_id = f2~carrier_id
                      )
   INTO TABLE @lt_result.

   LOOP AT lt_result ASSIGNING <fs_result>.
     out->write( | carrier: { <fs_result>-carrier_id }  client: { <fs_result>-client } price: { <fs_result>-price } | ).
   ENDLOOP.


  ENDMETHOD.
ENDCLASS.

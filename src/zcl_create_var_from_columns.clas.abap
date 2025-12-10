CLASS zcl_create_var_from_columns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA:
      gt_conn TYPE STANDARD TABLE OF /dmo/connection,
      gw_conn LIKE LINE OF gt_conn.
ENDCLASS.



CLASS zcl_create_var_from_columns IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT * FROM /dmo/connection
    INTO TABLE @gt_conn.

    LOOP AT gt_conn INTO gw_conn.
      out->write( |carrier: { gw_conn-carrier_id } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

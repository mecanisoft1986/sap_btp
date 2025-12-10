CLASS zcl_for_all_entries2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES:
       BEGIN OF ty_carr,
         carrid TYPE /dmo/flight-carrier_id,
       END OF ty_carr.
   DATA:
       gt_carrid TYPE STANDARD TABLE OF ty_carr,
       gs_carrid TYPE ty_carr.
ENDCLASS.



CLASS zcl_for_all_entries2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    gs_carrid-carrid = 'AA'.
    APPEND gs_carrid TO gt_carrid.

    gs_carrid-carrid = 'LH'.
    APPEND gs_carrid TO gt_carrid.

    gs_carrid-carrid = 'SQ'.
    APPEND gs_carrid TO gt_carrid.

    IF gt_carrid IS INITIAL.
      out->write( |no hay datos inicial para esta consulta.| ).
      return.
    ENDIF.

    SELECT * FROM /dmo/flight
      FOR ALL ENTRIES IN @gt_carrid
      WHERE carrier_id = @gt_carrid-carrid
    INTO TABLE @Data(lt_result).

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).
      out->write( | carried: { <fs_result>-carrier_id } connection: { <fs_result>-connection_id } client: { <fs_result>-client } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

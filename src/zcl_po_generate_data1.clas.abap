CLASS zcl_po_generate_data1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PO_GENERATE_DATA1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   DATA:itab TYPE TABLE OF zpohead1,
         itab2 TYPE TABLE OF zpoitems1.

*   read current timestamp
    GET TIME STAMP FIELD DATA(ztime).

*   fill internal PO Header  internal table (itab)
    itab = VALUE #(
    ( po_order = '0000000001' comp_code = 'test' doc_type = 'ZMM1'  vendor = '0010000000' status = 'P' created_by = 'user1' created_at = ztime )
    ( po_order = '0000000002' comp_code = 'test' doc_type = 'ZMM2'  vendor = '0010000001' status = 'C' created_by = 'user2' created_at = ztime )
    ( po_order = '0000000003' comp_code = 'test' doc_type = 'ZMM3'  vendor = '0010000002' status = 'D' created_by = 'user2' created_at = ztime )
    ) .
*   fill internal PO Items internal table (itab2)
    itab2 = VALUE #(
    ( po_order = '0000000001' order_item = '10' unit = 'PC' quantity = '5' )
    ( po_order = '0000000002' order_item = '10' unit = 'KG' quantity = '30.1' )
    ( po_order = '0000000002' order_item = '20' unit = 'KG' quantity = '20.2' )

    ) .

*   insert the table entries
    INSERT zpohead1 FROM TABLE @itab.
    INSERT zpoitems1 FROM TABLE @itab2.

    out->write( 'PO data inserted successfully!' ).
  ENDMETHOD.
ENDCLASS.

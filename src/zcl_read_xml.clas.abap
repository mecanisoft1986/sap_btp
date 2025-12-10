CLASS zcl_read_xml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
     METHODS get_xml RETURNING VALUE(rv_xml) TYPE string.
ENDCLASS.



CLASS zcl_read_xml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   DATA(xml_text) = get_xml( ).
    out->write( |XML generado:| ).
    out->write( xml_text ).
  ENDMETHOD.

  METHOD get_xml.
    RETURN |<?xml version="1.0" encoding="utf-8"?>| &
           |<swh:myroot xmlns:swh="http://software-heroes/swh" key="R1" description="Top node">| &
           |  <swh:title>This is a title</swh:title>| &
           |  <swh:description length="200" space="some"><![CDATA[My description is a bit longer]]></swh:description>| &
           |  <table>| &
           |    <item height="182cm">Bryan Jonnson</item>| &
           |    <item height="179cm">Linda Schwetzinger</item>| &
           |    <item height="162cm">Iana Petrova</item>| &
           |  </table>| &
           |  <swh:tags>People, Names, Data</swh:tags>| &
           |</swh:myroot>|.
  ENDMETHOD.
ENDCLASS.

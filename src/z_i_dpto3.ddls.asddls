@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'dpto3'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_dpto3 as select from zjc_dptos2
{
    key id as Id,
    nombre as Nombre
}

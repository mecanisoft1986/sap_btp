@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'dpto4'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_dpto4 as select from zjc_dptos2
{
    key id as Id,
    nombre as Nombre
}

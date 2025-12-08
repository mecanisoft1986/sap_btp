@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'empleados VIEW 3'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_empleado3 as 
  select from ZJC_EMPLEADO2 as e
  association [0..1] to z_i_dpto3 as _dpto on  $projection.DeptoId = _dpto.id
{
    key e.id as Id,
    e.nombre as Nombre,
    e.depto_id as DeptoId,
    e.waers as Waers,
    @Semantics.amount.currencyCode: 'Waers'
    e.salario as Salario,
    _dpto
}

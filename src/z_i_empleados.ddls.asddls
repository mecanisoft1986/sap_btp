@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'empleados VIEW'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_I_EMPLEADOS as 
  select from zjc_empleado2 as e 
  left outer join zjc_dptos2 as d on d.id = e.depto_id 
{
    key e.id as Id,
    e.nombre as Nombre,
    e.depto_id as DeptoId,
    e.waers as Waers,
    @Semantics.amount.currencyCode: 'Waers'
    e.salario as Salario,
    d.nombre as departamento
}

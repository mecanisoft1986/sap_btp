@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'con where'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_i_empleado4_where as select from zjc_empleado2
association [0..1] to z_i_dpto4 as dpto on $projection.DeptoId = dpto.Id
{
    key id as Id,
    nombre as Nombre,
    depto_id as DeptoId,
    waers as Waers,
    @Semantics.amount.currencyCode: 'Waers'
    salario as Salario,
    dpto.Nombre as departamento
} where dpto.Nombre = 'TI'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'empleado con departamento'
@Metadata.ignorePropagatedAnnotations: true
define view entity z_c_EmpleadoConDepartamento as select from z_i_empleado3
{
    key Id,
    Nombre,
    DeptoId,
    Waers,
    @Semantics.amount.currencyCode: 'Waers'
    Salario,
    /* Associations */
    _dpto.Nombre as departamento
}

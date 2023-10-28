@AbapCatalog.sqlViewName: 'ZEY_02_V_TEST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '2. Ödev sekansı ilk ödev'
define view ZEY_02_TEST as select from vbrp
inner join vbrk
    on vbrk.vbeln = vbrp.vbeln
inner join mara
    on mara.matnr = vbrp.matnr
left outer join vbak
    on vbak.vbeln = vbrp.aubel
left outer join kna1
    on kna1.kunnr = vbak.kunnr
left outer join makt
    on makt.matnr = mara.matnr {
    key vbrp.vbeln,
    key vbrp.posnr,
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    concat_with_space(kna1.name1, kna1.name2, 1) as kunnrAd,
    currency_conversion(amount => vbrp.netwr, source_currency => vbrk.waerk, target_currency => cast( 'EUR' as abap.cuky ) , exchange_rate_date => vbrk.fkdat) as conversion_netwr,
    substring(kna1.kunnr, 1, 3) as left_kunnr,
    length(mara.matnr) as matnr_length,
    case
    when vbrk.fkart = 'FAS' then 'Peşinat Talebi İptali'
    when vbrk.fkart = 'FAZ' then 'Peşinat Talebi'
                            else 'Fatura'end as faturalama_turu,
    vbrk.fkdat,
    vbrk.inco2_l
}

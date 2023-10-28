@AbapCatalog.sqlViewName: 'ZEY_03_V_TEST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '2. Ödev sekansı ikinci ödev'
define view ZEY_03_TEST as select from ZEY_02_TEST as T
{
    T.vbeln,
    sum( conversion_netwr ) as toplam_net_deger,
    T.kunnrAd,
    count(distinct T.vbeln ) as toplam_fatura_adedi,
//    fltp_to_dec( sum( conversion_netwr ) as abap.dec( 10, 3 ) )   / count(distinct T.vbeln ) as ortalama_miktar,
    substring(T.fkdat, 1, 4) as faturalama_yili,
    substring(T.fkdat, 5, 2) as faturalama_ayi,
    substring(T.fkdat, 7, 2) as faturalama_gunu,
    substring(T.inco2_l, 1, 3) as inco_yeri
} group by vbeln ,kunnrAd,T.fkdat,T.inco2_l

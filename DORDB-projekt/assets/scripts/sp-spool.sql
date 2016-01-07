> select * from (select * from vypujceni order by vypujcka_id desc) where rownum < 11
       1000|23.02.13       |24.02.13     |        11|        43|              680
        999|13.01.13       |15.01.13     |        25|        61|              648
        998|03.01.13       |06.01.13     |        14|        56|              893
        997|01.03.13       |02.03.13     |         9|        49|              672
        996|20.03.13       |22.03.13     |         1|         9|              596
        995|10.04.13       |13.04.13     |        29|        56|             1680
        994|21.04.13       |23.04.13     |        31|        77|             1114
        993|19.01.13       |21.01.13     |        38|        99|             1302
        992|18.04.13       |19.04.13     |        33|        33|              463
        991|23.04.13       |25.04.13     |        26|        38|              389

 10 rows selected 

> /
> DECLARE
  OSOBNI_CISLO_IN VARCHAR2(50);
  SPZ_IN VARCHAR2(200);
  DATUM_IN DATE;
  cc number;
BEGIN
  OSOBNI_CISLO_IN := 'N67';
  SPZ_IN := '1Z1 5589';
  DATUM_IN := '29.5.2013';
  
  NOVA_VYPUJCKA(
    OSOBNI_CISLO_IN => OSOBNI_CISLO_IN,
    SPZ_IN => SPZ_IN,
    DATUM_IN => DATUM_IN
  );
END;

anonymous block completed
vypujceni bylo zalozeno

   Statistics
-----------------------------------------------------------
               5  user calls
               0  physical read total multi block requests
               0  physical read total bytes
               0  cell physical IO interconnect bytes
               0  commit cleanout failures: block lost
               0  IMU commits
               0  IMU Flushes
               0  IMU contention
               0  IMU bind flushes
               0  IMU mbu flush
			   
> select * from (select * from vypujceni order by vypujcka_id desc) where rownum < 11
       1001|29.05.13       |             |        37|        28|                0
	   1000|23.02.13       |24.02.13     |        11|        43|              680
        999|13.01.13       |15.01.13     |        25|        61|              648
        998|03.01.13       |06.01.13     |        14|        56|              893
        997|01.03.13       |02.03.13     |         9|        49|              672
        996|20.03.13       |22.03.13     |         1|         9|              596
        995|10.04.13       |13.04.13     |        29|        56|             1680
        994|21.04.13       |23.04.13     |        31|        77|             1114
        993|19.01.13       |21.01.13     |        38|        99|             1302
        992|18.04.13       |19.04.13     |        33|        33|              463

 10 rows selected 

> /
> select * from (select * from jizdy order by jizda_id desc) where rownum < 11
      2970|Kingston-on-Thames                                                                                  |Linz                                                                                                |24.02.13|       535|        1000
      2969|Kingston-on-Thames                                                                                  |Lens-Saint-Servais                                                                                  |23.02.13|       145|        1000
      2968|Ledbury                                                                                             |Dunedin                                                                                             |15.01.13|       291|         999
      2967|Herfelingen                                                                                         |Smetlede                                                                                            |14.01.13|       357|         999
      2966|Houtave                                                                                             |Linz                                                                                                |05.01.13|       150|         998
      2965|Istres                                                                                              |Chelsea                                                                                             |04.01.13|       512|         998
      2964|Windermere                                                                                          |Istres                                                                                              |04.01.13|       231|         998
      2963|Nimy                                                                                                |Bissegem                                                                                            |02.03.13|       236|         997
      2962|Hohen Neuendorf                                                                                     |Bridgnorth                                                                                          |01.03.13|       436|         997
      2961|Portsoy                                                                                             |Bossut-Gottechain                                                                                   |20.03.13|       596|         996

 10 rows selected 

> /
> DECLARE
  OSOBNI_CISLO_IN VARCHAR2(50);
  SPZ_IN VARCHAR2(200);
  DATUM_IN DATE;
  START_IN VARCHAR2(200);
  CIL_IN VARCHAR2(200);
  VZDALENOST_IN NUMBER;
  cc number;
BEGIN
  OSOBNI_CISLO_IN := 'N67';
  SPZ_IN := '1Z1 5589';
  DATUM_IN := '29.5.2013';
  START_IN := 'HK';
  CIL_IN := 'PCE';
  VZDALENOST_IN := 35;
  
  NOVA_JIZDA(
    OSOBNI_CISLO_IN => OSOBNI_CISLO_IN,
    SPZ_IN => SPZ_IN,
    DATUM_IN => DATUM_IN,
    START_IN => START_IN,
    CIL_IN => CIL_IN,
    VZDALENOST_IN => VZDALENOST_IN
  );
END;
anonymous block completed
jizda byla zalozena
vzdalenost_celkem aktualizovana

   Statistics
-----------------------------------------------------------
               5  user calls
               0  physical read total multi block requests
               0  physical read total bytes
               0  cell physical IO interconnect bytes
               0  commit cleanout failures: block lost
               0  IMU commits
               0  IMU Flushes
               0  IMU contention
               0  IMU bind flushes
               0  IMU mbu flush

> select * from (select * from jizdy order by jizda_id desc) where rownum < 11
      2971|HK                                                                                                  |PCE                                                                                                 |29.05.13|        35|        1001
      2970|Kingston-on-Thames                                                                                  |Linz                                                                                                |24.02.13|       535|        1000
      2969|Kingston-on-Thames                                                                                  |Lens-Saint-Servais                                                                                  |23.02.13|       145|        1000
      2968|Ledbury                                                                                             |Dunedin                                                                                             |15.01.13|       291|         999
      2967|Herfelingen                                                                                         |Smetlede                                                                                            |14.01.13|       357|         999
      2966|Houtave                                                                                             |Linz                                                                                                |05.01.13|       150|         998
      2965|Istres                                                                                              |Chelsea                                                                                             |04.01.13|       512|         998
      2964|Windermere                                                                                          |Istres                                                                                              |04.01.13|       231|         998
      2963|Nimy                                                                                                |Bissegem                                                                                            |02.03.13|       236|         997
      2962|Hohen Neuendorf                                                                                     |Bridgnorth                                                                                          |01.03.13|       436|         997

 10 rows selected 

> /

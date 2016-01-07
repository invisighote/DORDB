--1.Vypise vsechny ridice, kteri najezdili vice jak 35000km
SET AUTOTRACE ON;
select
  * 
from 
  obj_ridic r
where
  REF(r) in(
    select 
      ridic_id
    from 
      obj_vypujceni
    group by 
      ridic_id
    having 
      sum(vzdalenost_celkem) >= 35000);

--2.Vypise automobil a model (podle ujetych kilometru) a jejich model.
SET AUTOTRACE ON;
select
  m.znacka
  ,m.model
  ,v.spz
  ,t.celkem
from
  obj_vozidlo v
  join obj_model m on v.model_id = REF(m)
  join
  (
  select
    vozidlo_id
    ,sum(vzdalenost_celkem) celkem
  from
    obj_vypujceni
  group by
    vozidlo_id
  ) t on REF(v) = t.vozidlo_id
order by
  t.celkem desc;
--3.Vypise vsechny ridice, kteri za leden, unor a brezen roku 2013 udelali alespon 20 jizd
SET AUTOTRACE ON;
select
  r.*
from  ( select ridic_id from obj_vypujceni where 
      datum_vypujceni >= '1.1.2013' and datum_vypujceni <= '31.3.2013'
    group by
      ridic_id
    having
      count(*) >= 20
  ) t
  join obj_ridic r on t.ridic_id = REF(r)
;
--4.Vypse (vsechny) datum vypujceni, model, sqz a jmeno ridice, podle vzdalenosti, ktrou ujeli na jedno vypujceni.
SET AUTOTRACE ON;
select
  v.datum_vypujceni
  ,m.znacka || ' ' || m.model vozidlo_model
  ,vo.spz
  ,r.prijmeni || ' ' || r.jmeno jmeno
  ,v.vzdalenost_celkem
from
  obj_vypujceni v
  join obj_ridic r on v.ridic_id = REF(r)
  join obj_vozidlo vo on v.vozidlo_id = REF(vo)
  join obj_model m on REF(m) = vo.model_id
order by
  v.vzdalenost_celkem desc
;
--5.Vypse vsechny ridice, kteri ridili vozidlo, model MAN
SET AUTOTRACE ON;
select distinct
  r.*
from
  obj_vypujceni v
  join obj_ridic r on v.ridic_id = REF(r)
  join obj_vozidlo vo on REF(vo) = v.vozidlo_id
  join obj_model m on REF(m) = vo.model_id
where
  m.znacka = 'MAN'
;





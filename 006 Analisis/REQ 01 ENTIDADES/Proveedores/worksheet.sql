insert into t_provs (id,title)
select id,title from import_provs;

create OR REPLACE view provs as
select id,title,cuit

,status from t_provs prov;

select id,title,cuit
,(select title from t_dfiscales where cuit = prov.cuit) Rsocial 
from import_provs prov;


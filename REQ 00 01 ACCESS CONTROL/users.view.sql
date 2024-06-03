CREATE OR REPLACE VIEW users AS
    SELECT
        id
       ,username
       ,first_name
       ,last_name
       ,email
       ,case when is_active = 'Y' then 'Y' else 'N' end is_active  
       ,(select listagg(id,':') from t_user_roles where id in (select role_id from t_user_applys where user_id = u.id))  role_ids 
       ,(select listagg(title,', ') from t_user_roles where id in (select role_id from t_user_applys where user_id = u.id)) role_names

    FROM
        t_users u ;

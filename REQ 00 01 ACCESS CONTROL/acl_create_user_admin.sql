DECLARE 
    user_admin_id number;
    role_admin_id number;
    is_valid BOOLEAN := FALSE;
    
BEGIN

    insert into t_user_roles (id,title,is_active)  values (1,'Administrator','Y');  


    access_control_pkg.add_user('admin','admin');

        
    select id into user_admin_id from t_users where username = 'ADMIN';
    select id into role_admin_id from t_user_roles where title = 'Administrator';
    
    insert into t_user_applys(user_id,role_id)  values (user_admin_id,role_admin_id);
        
    
END;




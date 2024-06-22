DECLARE 
    user_admin_id number;
    role_admin_id number;
    is_valid BOOLEAN := FALSE;
    
BEGIN

    access_control_pkg.add_rol('Administrator');  
    access_control_pkg.add_rol('UsuarioBasico');

    access_control_pkg.add_user('admin','admin');
    access_control_pkg.add_user('user','user');
        
    select id into user_admin_id from t_users where username = 'ADMIN';
    select id into role_admin_id from t_user_roles where title = 'Administrator';
    
    insert into t_user_applys(user_id,role_id)  values (user_admin_id,role_admin_id);
        
    
END;


/

    insert into t_user_roles (id,title,is_active)  values (1,'Administrator','Y');  
/

select * from t_user_roles;
select * from users;
delete from t_user_roles where id > 1;

delete t_users where id = 38;
/

begin
    access_control_pkg.add_rol('Tester');
    access_control_pkg.assing_rol('Facu','Tester');
end;
DECLARE 
    user_admin_id number;
    role_admin_id number;
    is_valid BOOLEAN := FALSE;
    
BEGIN

    access_control_pkg.add_rol('Administrator');  
    access_control_pkg.add_rol('UsuarioBasico');
    access_control_pkg.add_rol('Tester');

    access_control_pkg.add_user('admin','admin');
    access_control_pkg.add_user('user','user');
    access_control_pkg.add_user('tester','tester');
        
    access_control_pkg.ASSING_ROL('admin','Administrator');
    access_control_pkg.ASSING_ROL('user','UsuarioBasico');
    access_control_pkg.ASSING_ROL('tester','Tester');
    
END;

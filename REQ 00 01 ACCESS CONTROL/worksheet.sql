SELECT * FROM T_USERS;

SELECT * FROM T_USER_APPLYS WHERE USER_ID = 40;

SELECT * FROM T_USER_ROLES;

/
begin
    if access_control_pkg.USER_IN_ROL(:SESSION_USERNAME,'Tester') then 
     return true ;
     end if;
     return false;
end;    

/
select id,username,access_control_pkg.USER_IN_ROL(username,'UsuarioBasico') from t_users;
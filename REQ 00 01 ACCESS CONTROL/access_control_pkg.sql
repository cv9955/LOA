CREATE OR REPLACE PACKAGE access_control_pkg AS
    PROCEDURE add_user(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2 DEFAULT NULL
    );

    PROCEDURE change_password(
        p_username     IN VARCHAR2
       ,p_old_password IN VARCHAR2
       ,p_new_password IN VARCHAR2
    );

    FUNCTION valid_user(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2
    )RETURN BOOLEAN;

    FUNCTION is_required_change_password RETURN BOOLEAN;

    FUNCTION get_password_hash(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2
    )RETURN VARCHAR2;

    PROCEDURE disable_user(
        user_id NUMBER
    );

    PROCEDURE enable_user(
        user_id NUMBER
    );

    PROCEDURE change_roles(
        p_user_id  NUMBER
       ,p_role_ids VARCHAR2
    );

    PROCEDURE change_roles(
        p_user_name VARCHAR2
       ,p_role_ids VARCHAR2
    );

END;
/

CREATE OR REPLACE PACKAGE BODY access_control_pkg AS

/* private functions*/


    FUNCTION get_password_hash(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2
    )RETURN VARCHAR2 AS
        l_salt VARCHAR2(30):= 'CARAMELO';
    BEGIN
        RETURN dbms_crypto.hash(utl_raw.cast_to_raw(upper(p_username)
                                                    || l_salt
                                                    || p_password),dbms_crypto.hash_sh1);
    END get_password_hash;

    PROCEDURE add_user(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2 DEFAULT NULL
    )AS
    BEGIN
        INSERT INTO t_users(
            username
            ,password
            ,is_active
            ,valid_password
        )VALUES(
            upper(p_username)
           ,get_password_hash(p_username ,nvl(p_password,'123'))
           ,'Y'
           ,nvl2(p_password,'Y','N')
        );

        COMMIT;
    END;

    PROCEDURE change_password(
        p_username     IN VARCHAR2
       ,p_old_password IN VARCHAR2
       ,p_new_password IN VARCHAR2
    )AS
        v_rowid ROWID;
    BEGIN
        SELECT
            ROWID
        INTO v_rowid
        FROM
            t_users
        WHERE
                username = upper(p_username)
            AND(password IS NULL
                OR password = get_password_hash(p_username,p_old_password))
        FOR UPDATE;

        UPDATE t_users
        SET
            password = get_password_hash(p_username,p_new_password)
        WHERE
            ROWID = v_rowid;

        COMMIT;
    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20000,'Invalid username/password.');
    END;

    PROCEDURE valid_user(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2
    )AS

        l_user_id        t_users.id%TYPE;
        l_username       t_users.username%TYPE;
        l_first_name     t_users.first_name%TYPE;
        l_last_name      t_users.last_name%TYPE;
        l_email          t_users.email%TYPE;
        l_valid_password CHAR(1);
    BEGIN
        SELECT
            id
           ,username
           ,first_name
           ,last_name
           ,email
           ,valid_password
        INTO
            l_user_id
        ,l_username
        ,l_first_name
        ,l_last_name
        ,l_email
        ,l_valid_password
        FROM
            t_users
        WHERE
                username = upper(p_username)
            AND password = get_password_hash(p_username,p_password)
            AND is_active = 'Y';

        apex_util.set_session_state(p_name => 'SESSION_USER_ID',p_value => l_user_id);
        apex_util.set_session_state(p_name => 'SESSION_USERNAME',p_value => l_username);
--      apex_util.set_session_state(p_name => 'SESSION_FIRST_NAME',p_value => l_first_name);
--      apex_util.set_session_state(p_name => 'SESSION_LAST_NAME',p_value => l_last_name);
--      apex_util.set_session_state(p_name => 'SESSION_EMAIL',p_value => l_email);
--      apex_util.set_session_state(p_name => 'VALID_PASSWORD',p_value => l_valid_password);
    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20000,'Invalid username/password.');
    END;

    FUNCTION valid_user(
        p_username IN VARCHAR2
       ,p_password IN VARCHAR2
    )RETURN BOOLEAN AS
    BEGIN
        valid_user(p_username,p_password);
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN FALSE;
    END;

    PROCEDURE disable_user(
        user_id NUMBER
    )AS
    BEGIN
        UPDATE t_users
        SET
            is_active = 'N'
        WHERE
            id = user_id;

    END disable_user;

    PROCEDURE enable_user(
        user_id NUMBER
    )AS
    BEGIN
        UPDATE t_users
        SET
            is_active = 'Y'
        WHERE
            id = user_id;

    END enable_user;

    FUNCTION is_required_change_password RETURN BOOLEAN AS
        flg_pass_required CHAR(1);
    BEGIN
        SELECT
            nvl2(password,'Y','N')pass_required
        INTO flg_pass_required
        FROM
            t_users
        WHERE
                username = apex_util.get_session_state(p_item => 'SESSION_USERNAME')
            AND is_active = 'Y';

        IF flg_pass_required = 'Y' THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20000,'Invalid username.');
    END is_required_change_password;

    PROCEDURE change_roles(
        p_user_id  NUMBER
       ,p_role_ids VARCHAR2
    )AS
        l_roles apex_application_global.vc_arr2;
    BEGIN
        DELETE FROM t_user_applys
        WHERE
            user_id = p_user_id;
        l_roles := apex_util.string_to_table(p_role_ids);
        FOR i IN 1..l_roles.count LOOP
            INSERT INTO t_user_applys(user_id,role_id)
            VALUES(p_user_id,l_roles(i));
        END LOOP;
    END change_roles;

    PROCEDURE change_roles(
        p_user_name  VARCHAR2
       ,p_role_ids VARCHAR2
    )AS
     p_user_id NUMBER;   
    begin    
        select id into p_user_id from t_users where username = p_user_name;
        change_roles(p_user_id,p_role_ids);
    end change_roles;


END;
/
USE my_django_db;
CREATE TABLE IF NOT EXISTS django_migrations (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    app VARCHAR(255) NOT NULL, 
    name VARCHAR(255) NOT NULL, 
    applied DATETIME NOT NULL
);
INSERT INTO django_migrations VALUES(1,'contenttypes','0001_initial','2024-09-05 21:28:11.719024');
-- (остальные INSERT-вставки остаются без изменений)

CREATE TABLE IF NOT EXISTS auth_group_permissions (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    group_id INT NOT NULL, 
    permission_id INT NOT NULL, 
    FOREIGN KEY (group_id) REFERENCES auth_group(id),
    FOREIGN KEY (permission_id) REFERENCES auth_permission(id)
);

CREATE TABLE IF NOT EXISTS auth_user_groups (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NOT NULL, 
    group_id INT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES auth_user(id), 
    FOREIGN KEY (group_id) REFERENCES auth_group(id)
);

CREATE TABLE IF NOT EXISTS auth_user_user_permissions (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NOT NULL, 
    permission_id INT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES auth_user(id), 
    FOREIGN KEY (permission_id) REFERENCES auth_permission(id)
);

CREATE TABLE IF NOT EXISTS django_admin_log (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    action_time DATETIME NOT NULL, 
    object_id TEXT NULL, 
    object_repr VARCHAR(200) NOT NULL, 
    change_message TEXT NOT NULL, 
    content_type_id INT NULL, 
    user_id INT NOT NULL, 
    action_flag SMALLINT UNSIGNED NOT NULL CHECK (action_flag >= 0), 
    FOREIGN KEY (content_type_id) REFERENCES django_content_type(id), 
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);

CREATE TABLE IF NOT EXISTS django_content_type (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    app_label VARCHAR(100) NOT NULL, 
    model VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS auth_permission (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    content_type_id INT NOT NULL, 
    codename VARCHAR(100) NOT NULL, 
    name VARCHAR(255) NOT NULL, 
    FOREIGN KEY (content_type_id) REFERENCES django_content_type(id)
);

CREATE TABLE IF NOT EXISTS auth_group (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS auth_user (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    password VARCHAR(128) NOT NULL, 
    last_login DATETIME NULL, 
    is_superuser BOOL NOT NULL, 
    username VARCHAR(150) NOT NULL UNIQUE, 
    last_name VARCHAR(150) NOT NULL, 
    email VARCHAR(254) NOT NULL, 
    is_staff BOOL NOT NULL, 
    is_active BOOL NOT NULL, 
    date_joined DATETIME NOT NULL, 
    first_name VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS django_session (
    session_key VARCHAR(40) NOT NULL PRIMARY KEY, 
    session_data TEXT NOT NULL, 
    expire_date DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS shop_course (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(255) NOT NULL, 
    price DECIMAL(10, 2) NOT NULL, 
    students_qty INT NOT NULL, 
    reviews_qty INT NOT NULL, 
    created_at DATETIME NOT NULL, 
    category_id BIGINT NOT NULL, 
    FOREIGN KEY (category_id) REFERENCES shop_category(id)
);

CREATE TABLE IF NOT EXISTS shop_category (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    created_at DATETIME NOT NULL, 
    title VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS tastypie_apikey (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    key VARCHAR(128) NOT NULL, 
    created DATETIME NOT NULL, 
    user_id INT NOT NULL UNIQUE, 
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);

CREATE TABLE IF NOT EXISTS tastypie_apiaccess (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    identifier VARCHAR(255) NOT NULL, 
    request_method VARCHAR(10) NOT NULL, 
    accessed INT UNSIGNED NOT NULL CHECK (accessed >= 0), 
    url TEXT NOT NULL
);

-- Удаление этой команды, она специфична для SQLite
-- DELETE FROM sqlite_sequence;

CREATE UNIQUE INDEX auth_group_permissions_group_id_permission_id_uniq ON auth_group_permissions (group_id, permission_id);
CREATE INDEX auth_group_permissions_group_id_idx ON auth_group_permissions (group_id);
CREATE INDEX auth_group_permissions_permission_id_idx ON auth_group_permissions (permission_id);

CREATE UNIQUE INDEX auth_user_groups_user_id_group_id_uniq ON auth_user_groups (user_id, group_id);
CREATE INDEX auth_user_groups_user_id_idx ON auth_user_groups (user_id);
CREATE INDEX auth_user_groups_group_id_idx ON auth_user_groups (group_id);

CREATE UNIQUE INDEX auth_user_user_permissions_user_id_permission_id_uniq ON auth_user_user_permissions (user_id, permission_id);
CREATE INDEX auth_user_user_permissions_user_id_idx ON auth_user_user_permissions (user_id);
CREATE INDEX auth_user_user_permissions_permission_id_idx ON auth_user_user_permissions (permission_id);

CREATE INDEX django_admin_log_content_type_id_idx ON django_admin_log (content_type_id);
CREATE INDEX django_admin_log_user_id_idx ON django_admin_log (user_id);

CREATE UNIQUE INDEX django_content_type_app_label_model_uniq ON django_content_type (app_label, model);

CREATE UNIQUE INDEX auth_permission_content_type_id_codename_uniq ON auth_permission (content_type_id, codename);
CREATE INDEX auth_permission_content_type_id_idx ON auth_permission (content_type_id);

CREATE INDEX django_session_expire_date_idx ON django_session (expire_date);

CREATE INDEX shop_course_category_id_idx ON shop_course (category_id);

CREATE INDEX tastypie_apikey_key_idx ON tastypie_apikey (key);

-- Заключительная команда для завершения транзакции
COMMIT;

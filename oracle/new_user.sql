create user siva IDENTIFIED by oracle;
grant connect, resource to siva;
grant create session to siva;
grant UNLIMITED tablespace to siva;
create DIRECTORY my_dir as '/home/oracle/files';
GRANT READ, WRITE ON DIRECTORY my_dir TO siva;
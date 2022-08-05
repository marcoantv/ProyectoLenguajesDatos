alter session set "_Oracle_Script" = true;

create user estudiante 
identified by estudiante
default tablespace users
quota 50m on users;

grant create session, resource to estudiante;
grant read, write on directory imagenesProyecto to estudiante;






create or replace package PAQUETE_DE_USUARIOS
as

    procedure registrarUsuario(nombreP in varchar2, correoP in varchar2,
    contraseniaP in varchar2);
    
    procedure iniciarSesion(correoP in varchar2, contraseniaP in varchar2, idUsuario out number, nombre out varchar2);
    
end;
/
create or replace package body PAQUETE_DE_USUARIOS
as

    procedure registrarUsuario(nombreP in varchar2, correoP in varchar2,
    contraseniaP in varchar2)
    as
    begin
    
        insert into Usuarios(nombreusuario,correoelectronico,contrasenia)
        values(nombreP,correoP,contraseniaP);
        
        commit;
    
    end;
    
    procedure iniciarSesion(correoP in varchar2, contraseniaP in varchar2, idUsuario out number, nombre out varchar2)
    as    
    begin
    
        select idUsuario,
        nombreusuario into idUsuario, nombre
        from usuarios
        where lower(correoelectronico) like(lower(correoP)) and
        contrasenia like(contraseniaP);
          
    exception 
    
        when no_data_found then
        
            nombre := null;
    
    end;
    
end;
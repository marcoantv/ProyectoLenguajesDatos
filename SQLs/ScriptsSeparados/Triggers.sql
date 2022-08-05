create or replace trigger TRIGGER_ASIGNAR_IDPK_A_CATEGORIA_DE_PRODUCTOS

    before insert 
    on CATEGORIA_DE_PRODUCTOS
    for each row
    
declare
begin

    select SECUENCIA_CATEGORIA_DE_PRODUCTOS.nextval
    into :new.idCategoria
    from dual;

end;

--------------------

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVO_PRODUCTO

    before insert 
    on PRODUCTOS
    for each row
    
declare
begin

    select SECUENCIA_PRODUCTOS.nextval
    into :new.idProducto
    from dual;

end;

-------------------

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVA_RESENIA_DE_PRODUCTO

    before insert 
    on RESENIA_DE_PRODUCTOS
    for each row
    
declare
begin

    select SECUENCIA_RESENIA_DE_PRODUCTOS.nextval
    into :new.idResenia
    from dual;

end;

------------------

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVA_TALLA_DE_PRODUCTO

    before insert 
    on TALLA_DE_PRODUCTOS
    for each row
    
declare
begin

    select SECUENCIA_TALLA_DE_PRODUCTOS.nextval
    into :new.idTalla
    from dual;

end;

-------------------

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVO_USUARIO

    before insert 
    on USUARIOS
    for each row
    
declare
begin

    select SECUENCIA_USUARIOS.nextval
    into :new.idUsuario
    from dual;

end;

----------------

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVO_EVENTO_DE_AUDITORIA

    before insert 
    on AUDITORIA
    for each row
    
declare
begin

    select SECUENCIA_AUDITORIA.nextval
    into :new.idEvento
    from dual;

end;

create or replace trigger TRIGGER_ASIGNAR_IDPK_A_NUEVA_VENTA

    before insert 
    on VENTAS
    for each row
    
declare
begin

    select SECUENCIA_VENTAS.nextval
    into :new.idVenta
    from dual;

end;


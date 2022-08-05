--Usuario y permisos--

alter session set "_Oracle_Script" = true;

create user estudiante 
identified by estudiante
default tablespace users
quota 50m on users;

grant create session, resource to estudiante;

--CarpetaImagenes

create directory imagenesProyecto as 'C:\ImagenesProyecto';

grant read, write on directory imagenesProyecto to estudiante;


--Tablas--

create table CATEGORIA_DE_PRODUCTOS(

    idCategoria number not null, --PK
    tipoCategoria varchar2(64) unique not null,
    
    constraint PK_IDCATEGORIA_CDP primary key (idCategoria)
    
);

create table TALLA_DE_PRODUCTOS(

    idTalla number not null, --PK
    tipoTalla varchar2(64) unique not null,

    constraint PK_IDTALLA_TDP primary key(idTalla)

);

create table USUARIOS(

    idUsuario number not null, --PK
    nombreUsuario varchar2(32) not null,
    correoElectronico varchar2(64) unique not null,
    contrasenia varchar2(50) not null,
    
    constraint PK_IDUSUARIO_U primary key(idUsuario)

);

create table PRODUCTOS(

    idProducto number not null, --PK 
    idCategoria number not null,--FK
    idTalla number not null, --FK
    nombreProducto varchar2(64) not null,
    descripcion varchar(500) not null,
    precioUnitario number(14,2) not null,
    fecharegistro date not null,
    imagen blob,

    constraint PK_IDPRODUCTO_P primary key(idProducto),
    constraint FK_IDCATEGORIA_P foreign key (idCategoria) references CATEGORIA_DE_PRODUCTOS(idCategoria),
    constraint FK_IDTALLA_P foreign key (idTalla) references TALLA_DE_PRODUCTOS(idTalla)

);

create table VENTAS(

    idVenta number not null, --PK
    idUsuario number not null, --FK
    nombreUsuario varchar2(32) not null,
    correoUsuario varchar2(64) not null,
    nombreTarjeta varchar2(64) not null,
    direccionDada varchar2(1024) not null,
    numeroTarjetaCredito varchar2(24) not null,
    ciudadDada varchar(64) not null,
    cantonDado varchar(64) not null,
    codigoPostal number(12) not null,
    fechaCompra date not null,
    montoTotal number(14,2),
    
    constraint PK_IDVENTA_V primary key (idVenta),
    constraint FK_IDUSUARIO_V foreign key (idUsuario) references USUARIOS(idUsuario)

);

create table DETALLES_DE_VENTAS(

	idDetalleVenta number not null, --PK
	idVenta number not null, -- FK
	idProducto number not null, --FK
	precioUnitario number(14,2) not null,
    
    constraint PK_IDDETALLEVENTA_DDV primary key (idDetalleVenta,idVenta),
    constraint FK_IDVENTA_DDV foreign key (idVenta) references VENTAS(idVenta),
    constraint FK_IDPRODUCTO_DDV foreign key (idProducto) references PRODUCTOS(idProducto)

);

-----------

create table RESENIA_DE_PRODUCTOS(

    idResenia number not null, --PK
	idUsuario number not null, --FK
	idProducto number not null, -- FK
	calificacion int not null,
	comentario varchar2(2024),

    constraint PK_IDRESENIA_RDP primary key (idResenia),
    constraint FK_IDUSUARIO_RDP foreign key (idUsuario) references USUARIOS(idUsuario),
    constraint FK_IDPRODUCTO_RDP foreign key (idProducto) references PRODUCTOS(idProducto)    

);

---------------

create table AUDITORIA(

    idEvento number not null, --PK
    evento varchar(1024) not null,
    usuario varchar2(64) not null,
    fechaSuceso date,

    constraint PK_IDEVENTO_AUDITORIA primary key (idEvento)

);

--Secuencias--

create sequence SECUENCIA_CATEGORIA_DE_PRODUCTOS

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
    
create sequence SECUENCIA_PRODUCTOS

    start with 1
    increment by 1
    minvalue 1
    nocycle;

----------
    
create sequence SECUENCIA_RESENIA_DE_PRODUCTOS

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
--------------
    
create sequence SECUENCIA_TALLA_DE_PRODUCTOS

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
create sequence SECUENCIA_USUARIOS

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
create sequence SECUENCIA_VENTAS

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
create sequence SECUENCIA_AUDITORIA

    start with 1
    increment by 1
    minvalue 1
    nocycle;
    
--Triggers--

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

--Paquete Usuarios--

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

--Paquete Usuarios--

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

--Paquete Productos--

create or replace package PAQUETE_DE_PRODUCTOS
as

    procedure obtenerProductosRecientes(productosP out sys_refcursor);
    
    procedure obtenerHoodiesRecientes(productosP out sys_refcursor);
    procedure obtenerCamisasRecientes(productosP out sys_refcursor);
    procedure obtenerPantSRecientes(productosP out sys_refcursor);
    procedure obtenerTenisRecientes(productosP out sys_refcursor);
    
    procedure obtenerTodosLosProductosPorPrecionDescendiente(productosP out sys_refcursor);
    
    procedure obtenerHoodiesPorPrecionDescendiente(productosP out sys_refcursor);
    procedure obtenerCamisasPorPrecionDescendiente(productosP out sys_refcursor);
    procedure obtenerPantSPorPrecionDescendiente(productosP out sys_refcursor);
    procedure obtenerTenisPorPrecionDescendiente(productosP out sys_refcursor);
    
    
    procedure buscarArticuloPorRegex(articuloABuscar in varchar2,articulosP out sys_refcursor);
    procedure obtenerInformacionBasicaProducto(idProductoP in number,
    nombreP out varchar2, descripcionP out varchar2, precioP out varchar2,
    imagen out BLOB);
    procedure obtenerInformacionDetalleProducto(idProductoP in number,
    nombreP out varchar2, descripcionP out varchar2, precioP out varchar2,
    tipoTallaP out varchar2, tipoCategoria out varchar2,
    imagen out BLOB);
    
end;
/
create or replace package body PAQUETE_DE_PRODUCTOS
as

    procedure obtenerProductosRecientes(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where  productos.fecharegistro > sysdate-31;

    end;
    

    procedure obtenerTodosLosProductosPorPrecionDescendiente(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            order by productos.preciounitario desc;

    end;
    
    procedure buscarArticuloPorRegex(articuloABuscar in varchar2,articulosP out sys_refcursor)
    as
    begin

        open articulosP for
            select productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where REGEXP_LIKE(lower(productos.nombreproducto),lower(articuloABuscar));
        
    end;
    
    procedure obtenerInformacionBasicaProducto(idProductoP in number,
    nombreP out varchar2, descripcionP out varchar2, precioP out varchar2,
    imagen out BLOB)
    as
    begin
    
        select productos.nombreproducto as "nombreProducto",
        productos.descripcion as "descripcionProducto",
        '?' || to_char(productos.preciounitario,'999G999G999D00') as "precioProducto",
        imagen as "imagenProducto" into nombreP, descripcionP, precioP, imagen
        from productos
        where productos.idproducto = idProductoP;
        
    end;
        
    procedure obtenerHoodiesRecientes(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where  productos.fecharegistro > sysdate-31
            and categoria_de_productos.IDCATEGORIA = 1;

    end;
    
    procedure obtenerCamisasRecientes(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where  productos.fecharegistro > sysdate-31
            and categoria_de_productos.IDCATEGORIA = 2;

    end;
    
    procedure obtenerPantSRecientes(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where  productos.fecharegistro > sysdate-31
            and categoria_de_productos.IDCATEGORIA = 3;

    end;
    
    procedure obtenerTenisRecientes(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where  productos.fecharegistro > sysdate-31
            and categoria_de_productos.IDCATEGORIA = 4 ;

    end;
            
    procedure obtenerTenisPorPrecionDescendiente(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where categoria_de_productos.IDCATEGORIA = 4
            order by productos.preciounitario desc;

    end;

    procedure obtenerPantSPorPrecionDescendiente(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where categoria_de_productos.IDCATEGORIA = 3
            order by productos.preciounitario desc;

    end;
        
    procedure obtenerCamisasPorPrecionDescendiente(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where categoria_de_productos.IDCATEGORIA = 2
            order by productos.preciounitario desc;

    end;

    procedure obtenerHoodiesPorPrecionDescendiente(productosP out sys_refcursor)
    as
    begin

        open productosP for 
            select  productos.idproducto as "idProducto",
            productos.nombreproducto as "Producto",
            '?' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
            productos.imagen as "Imagen"
            from productos
            inner join categoria_de_productos
            on categoria_de_productos.IDCATEGORIA = productos.idcategoria
            inner join talla_de_productos
            on talla_de_productos.idtalla = productos.idtalla
            where categoria_de_productos.IDCATEGORIA = 1
            order by productos.preciounitario desc;

    end;
    
    procedure obtenerInformacionDetalleProducto(idProductoP in number,
    nombreP out varchar2, descripcionP out varchar2, precioP out varchar2,
    tipoTallaP out varchar2, tipoCategoria out varchar2,
    imagen out BLOB)
    as
    begin
    
        select productos.nombreproducto as "nombreProducto",
        categoria_de_productos.tipocategoria as "tipoCategoria",
        productos.descripcion as "descripcionProducto",
        talla_de_productos.tipotalla as "tipoTalla",
        '?' || to_char(productos.preciounitario,'999G999G999D00') as "precioProducto",
        imagen as "imagenProducto" into nombreP, tipoCategoria,descripcionP,tipoTallaP, precioP, imagen
        from productos
        inner join categoria_de_productos
        on categoria_de_productos.idcategoria = productos.idcategoria
        inner join TALLA_DE_PRODUCTOS
        on TALLA_DE_PRODUCTOS.idTalla = productos.idtalla
        where productos.idproducto = idProductoP;
        
    end;
    
end;

--Paquete de Ventas--

create or replace package PAQUETE_DE_VENTAS
as

    procedure realizarVenta(idUsuarioP in number, nombreTarjeraP in varchar2, direccionDadaP in varchar2, numeroTarjetaP in varchar2,
    ciudadDadaP in varchar2,cantonDadoP in varchar2,codigoPostalP in number, montoTotalP in number);
    procedure agregarDetalleDeVenta(idDetalleVentaP in number, idUsuarioP in number,idProductoP in number);
    function devolverPrecioArticulo(idProductoP in number)
    return decimal;
    procedure devolverUltimaVenta(idUsuarioP in number, idUltimaVenta out number, 
    total out varchar2, fechaCompraP out varchar2);
    function devolverDetallesDeVenta(idUsuarioP in number)
    return sys_refcursor;
    function retornalTotalDeVenta(idUsuarioP in number)
    return varchar2;
    
end;
/
create or replace package body PAQUETE_DE_VENTAS
as

    procedure realizarVenta(idUsuarioP in number, nombreTarjeraP in varchar2, direccionDadaP in varchar2, numeroTarjetaP in varchar2,
    ciudadDadaP in varchar2,cantonDadoP in varchar2,codigoPostalP in number, montoTotalP in number)
    as
    
        fechaDeCompra date;
        nombreUsuario usuarios.nombreusuario%type;
        correoUsuario usuarios.correoelectronico%type;
    
    begin
    
        select sysdate into fechaDeCompra
        from dual;
        
        select NOMBREUSUARIO into nombreUsuario
        from usuarios
        where IDUSUARIO = idUsuarioP;
        
        select correoelectronico into correoUsuario
        from usuarios
        where IDUSUARIO = idUsuarioP; 
    
        insert into ventas(IDUSUARIO,NOMBREUSUARIO,CORREOUSUARIO,NOMBRETARJETA,DIRECCIONDADA,NUMEROTARJETACREDITO,CIUDADDADA
        ,CANTONDADO,CODIGOPOSTAL,FECHACOMPRA,MONTOTOTAL)
        values(idUsuarioP,nombreUsuario,correoUsuario,nombreTarjeraP,
        direccionDadaP,numeroTarjetaP,ciudadDadaP,cantonDadoP,codigoPostalP,fechaDeCompra,montoTotalP);
    
    end;
    
    procedure agregarDetalleDeVenta(idDetalleVentaP in number, idUsuarioP in number,idProductoP in number)
    as
    
        idVenta number;
        precioUnitarioProducto number;
    
    begin
    
        select idVenta into idVenta
        from ventas
        where idusuario = idUsuarioP
        order by idVenta desc
        fetch first 1 row only;
        
        select precioUnitario into precioUnitarioProducto
        from productos
        where idproducto = idProductoP;
        
        insert into detalles_de_ventas(IDDETALLEVENTA,IDVENTA,IDPRODUCTO,PRECIOUNITARIO)
        values(idDetalleVentaP,idVenta,idProductoP,precioUnitarioProducto);
    
    end;

    function devolverPrecioArticulo(idProductoP in number)
    return decimal
    is
    
        precio productos.preciounitario%type;
    
    begin
        
        select preciounitario into precio
        from productos
        where idproducto = idProductoP;
        
        return precio;
        
    exception
    
        when no_data_found then
        
            return 0;
            
    end;
    
    
    procedure devolverUltimaVenta(idUsuarioP in number, idUltimaVenta out number, 
    total out varchar2, fechaCompraP out varchar2)
    as
    begin
    
    select max(idventa) into idUltimaVenta
    from ventas;
        
    select '?' || to_char(montototal,'999G999G999D00') into total
    from ventas 
    where idventa =
    (select max(idventa)
    from ventas)
    and idusuario = idUsuarioP;
    
    select to_char(fechacompra,'Day dd Month yyyy','nls_date_language=Spanish') into fechaCompraP
    from ventas 
    where idventa =
    (select max(idventa)
    from ventas)
    and idusuario = idUsuarioP;
    
    
    end;

    function devolverDetallesDeVenta(idUsuarioP in number)
    return sys_refcursor
    is
        
        miVenta sys_refcursor;
    
    begin
    
        open miVenta for
            select productos.nombreproducto as "nombreProducto", 
            '?' || to_char(detalles_de_ventas.preciounitario,'999G999G999D00')
            as "precioProducto"
            from productos
            inner join detalles_de_ventas
            on detalles_de_ventas.idproducto = productos.idproducto
            inner join ventas
            on ventas.idventa = detalles_de_ventas.idventa
            where ventas.idusuario = idUsuarioP and 
            ventas.idventa = 
            (select max(idventa)
            from ventas)
            and idusuario = idUsuarioP;
            
        return miventa;
    
    end;
    
    function retornalTotalDeVenta(idUsuarioP in number)
    return varchar2
    is
    
        totalDeVenta varchar2(1024);
    
    begin
    
            select '?' || to_char(sum(detalles_de_ventas.preciounitario),'999G999G999D00')
            as "montoTotal"
            into totalDeVenta
            from productos
            inner join detalles_de_ventas
            on detalles_de_ventas.idproducto = productos.idproducto
            inner join ventas
            on ventas.idventa = detalles_de_ventas.idventa
            where ventas.idusuario = idUsuarioP and 
            ventas.idventa = 
            (select max(idventa)
            from ventas)
            and idusuario = idUsuarioP;
        
            return totalDeVenta;
    
    end;

end;


--INSERT TALLAS

insert into talla_de_productos(tipotalla) --1
values('XS');

insert into talla_de_productos(tipotalla) --2
values('Small');

insert into talla_de_productos(tipotalla) --3
values('Medium');

insert into talla_de_productos(tipotalla) --4
values('Large');

insert into talla_de_productos(tipotalla)--5
values('XL');

insert into talla_de_productos(tipotalla)--6
values('35');

insert into talla_de_productos(tipotalla) --7
values('36');

insert into talla_de_productos(tipotalla)--8
values('39');

insert into talla_de_productos(tipotalla)--9
values('40');

insert into talla_de_productos(tipotalla)--10
values('41');

insert into talla_de_productos(tipotalla)--11
values('42');

insert into talla_de_productos(tipotalla)--12
values('43');

-------INSERT CATEGORIAS----

insert into categoria_de_productos(tipoCategoria)
values('Hoodies');

insert into categoria_de_productos(tipoCategoria)
values('Camisas');

insert into categoria_de_productos(tipoCategoria)
values('Pantalones');

insert into categoria_de_productos(tipoCategoria)
values('Tenis');

--INSERT PRODUCTOS
insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,1,'Blusa Adidas','Blusa Adidas para hacer ejercicio.',20000,
bfilename('IMAGENESPROYECTO','camisa1.jpg'),
'14/07/2021');
---------------------------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,3,'Camisa Lacoste','Camisa para hombre Lacoste.',25000,
bfilename('IMAGENESPROYECTO','camisa2.jpg'),
'14/07/2021');

-------------------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,4,'Camisa Supreme','Camisa exclusiva Supreme de hombre .',60000,
bfilename('IMAGENESPROYECTO','camisa3.jpg'),
'14/08/2021');

----------------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,1,'Blusa Forever21','Blusa de tirantes.',12000,
bfilename('IMAGENESPROYECTO','camisa4.jpg'),
'23/07/2021');

-----------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,2,'Blusa Forever21','Blusa de mujer.',16000,
bfilename('IMAGENESPROYECTO','camisa5.jpg'),
'24/08/2021');

--------------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(2,5,'Camisa Nike','Camisa Nike para hacer deporte.',16000,
bfilename('IMAGENESPROYECTO','camisa6.jpg'),
'14/07/2021');

--------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,9,'Nike Jordan 1 Retro High University','Nike Jordan 1 Retro High University Blue Black.',120000,
bfilename('IMAGENESPROYECTO','jordan1.jpg'),
'14/05/2021');
--------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,11,'Nike Jordan 1 Retro High x J Balvin','Nike Jordan 1  Retro High x J Balvin.',220000,
bfilename('IMAGENESPROYECTO','jordan2.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,10,'Nike Air Jordan 1 Mid Chicago White','Nike Air Jordan 1 Mid Chicago White.',120000,
bfilename('IMAGENESPROYECTO','jordan3.jpg'),
'14/07/2021');
--------------------


insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,6,'Nike Air Jordan 1 Pink Quartz','Nike Air Jordan 1 Pink Quartz.',120000,
bfilename('IMAGENESPROYECTO','jordan4.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,7,'Nike Air Jordan 1 Gray Smoke','Nike Air Jordan 1 Gray Smoke.',120000,
bfilename('IMAGENESPROYECTO','jordan5.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,6,'New Balance','New Balance blancas.',76000,
bfilename('IMAGENESPROYECTO','nb1.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,8,'New Balance 624','New Balance 624.',87000,
bfilename('IMAGENESPROYECTO','nb2.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,9,'New Balance PC574SOS','New Balance PC574SOS.',70000,
bfilename('IMAGENESPROYECTO','nb3.jpg'),
'14/07/2021');

--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,6,'New Balance 997','New Balance 997 Sport.',80000,
bfilename('IMAGENESPROYECTO','nb4.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,7,'Nike Air Force 1','Nike Air Force 1 W.',80000,
bfilename('IMAGENESPROYECTO','nike3.jpg'),
'14/07/2021');

--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,7,'Nike Air Force 1','Nike Air Force 1 .',70000,
bfilename('IMAGENESPROYECTO','nike4.jpg'),
'14/07/2021');

--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,2,'Pantalon Forever21','Pantalon W Forever21 .',20000,
bfilename('IMAGENESPROYECTO','pantalon3.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,3,'Pantalon Forever21','Pantalon W Negro Forever21 .',20000,
bfilename('IMAGENESPROYECTO','pantalon5.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,3,'Pantalon Negro','Pantalon Negro.',18000,
bfilename('IMAGENESPROYECTO','pantalon6.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,3,'Jogger Negro','Jogger Negro Bershka.',20000,
bfilename('IMAGENESPROYECTO','pantalon7.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,1,'Short Verde Forever21','Short W Verde Forever21.',16000,
bfilename('IMAGENESPROYECTO','short1.jpg'),
'14/07/2021');

--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(3,3,'Short Beige Forever21','Short Beige Bershka.',16000,
bfilename('IMAGENESPROYECTO','short4.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(1,3,'Hoodie Nike','Hoodie Deportivo NIKE.',26000,
bfilename('IMAGENESPROYECTO','sudadera.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(1,3,'Hoodie Nike','Hoodie Deportivo roja NIKE.',26000,
bfilename('IMAGENESPROYECTO','sudadera1.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(1,2,'Hoodie Nike W','Hoodie NIKE W Rosado.',28000,
bfilename('IMAGENESPROYECTO','sudadera3.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(1,2,'Hoodie Nike W LAKERS','Hoodie NIKE W LAKERS.',58000,
bfilename('IMAGENESPROYECTO','sudadera4.jpg'),
'14/07/2021');

--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,8,'Yeezy 350 v2 "Israfil"','Yeezy 350 v2 "Israfil".',200000,
bfilename('IMAGENESPROYECTO','yeezy1.jpg'),
'14/07/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,9,'Yeezy 350 v2 Black','Yeezy 350 v2 Black.',280000,
bfilename('IMAGENESPROYECTO','yeezy2.jpg'),
'14/08/2021');
--------------------

insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,10,'Yeezy 700 Wave Runner','Yeezy 700 Wave Runner.',280000,
bfilename('IMAGENESPROYECTO','yeezy4.jpg'),
'14/08/2021');
------------------
insert into productos(IDCATEGORIA,IDTALLA,NOMBREPRODUCTO,DESCRIPCION,
PRECIOUNITARIO,IMAGEN,fecharegistro)
values(4,11,'Yeezy 350 v2 Natural','Yeezy 350 v2 Natural.',230000,
bfilename('IMAGENESPROYECTO','yeezy6.jpg'),
'14/07/2021');

---USUARIOS--

insert into usuarios(NOMBREUSUARIO,CORREOELECTRONICO,CONTRASENIA)
values('Manuel','wasd@hotmail.com','wasd');

commit;

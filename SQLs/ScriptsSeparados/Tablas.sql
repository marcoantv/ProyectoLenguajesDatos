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
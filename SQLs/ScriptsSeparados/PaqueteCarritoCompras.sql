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
        
    select '¢' || to_char(montototal,'999G999G999D00') into total
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
            '¢' || to_char(detalles_de_ventas.preciounitario,'999G999G999D00')
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
    
            select '¢' || to_char(sum(detalles_de_ventas.preciounitario),'999G999G999D00')
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
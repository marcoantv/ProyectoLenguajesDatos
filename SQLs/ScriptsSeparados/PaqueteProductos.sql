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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
        '¢' || to_char(productos.preciounitario,'999G999G999D00') as "precioProducto",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
            '¢' || to_char(productos.preciounitario,'999G999G999D00') as "Precio",
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
        '¢' || to_char(productos.preciounitario,'999G999G999D00') as "precioProducto",
        imagen as "imagenProducto" into nombreP, tipoCategoria,descripcionP,tipoTallaP, precioP, imagen
        from productos
        inner join categoria_de_productos
        on categoria_de_productos.idcategoria = productos.idcategoria
        inner join TALLA_DE_PRODUCTOS
        on TALLA_DE_PRODUCTOS.idTalla = productos.idtalla
        where productos.idproducto = idProductoP;
        
    end;
    
end;
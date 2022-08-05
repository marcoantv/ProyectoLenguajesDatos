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

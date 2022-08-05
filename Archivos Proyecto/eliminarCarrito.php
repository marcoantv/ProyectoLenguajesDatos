<?php

session_start();

$arreglo = $_SESSION['carrito'];

for ($iterador=0; $iterador < count($arreglo); $iterador++) { 

    if($arreglo[$iterador]["idProducto"]!=$_POST['id']){

        $arregloNuevo[] = array(

            "idProducto" => $arreglo[$iterador]["idProducto"],
            "nombreProducto" => $arreglo[$iterador]["nombreProducto"],
            "descripcionProducto" => $arreglo[$iterador]["descripcionProducto"],
            "precioProducto" => $arreglo[$iterador]["precioProducto"],
            "imagenProducto" => $arreglo[$iterador]["imagenProducto"]
    
        );

    };

}; //Fin del for. 
if(isset($arregloNuevo)){

    $_SESSION['carrito']=$arregloNuevo;

} else {

    unset($_SESSION['carrito']);

}

echo 'Eliminado.';

?>
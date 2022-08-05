<?php

session_start();

$nombreUsuario = null;
$correo = null;

if (isset($_SESSION['nombreUsuario']) && isset($_SESSION['correoElectronico'])) {

    $nombreUsuario = $_SESSION['nombreUsuario'];
    $correo = $_SESSION['correoElectronico'];

} 

if(isset($_POST['cerrarSesion'])){

    session_destroy();
    session_unset();

    header("Location: index.php");
    exit();

} 

function mostrarDatosUsuario(){

    global $nombreUsuario;
    global $correo;

    if ($nombreUsuario!=null && $correo!=null) {
        
        echo '<label>Nombre del Usuario: ' . $nombreUsuario . ' </label>';
        echo '<br>';
        echo '<label>Correo: ' . $correo . ' </label>';

    } //Fin del if. 

}


?>

<?php

if(isset($_POST['search-input'])){

    $articulo = $_POST['search-input'];

    header("Location: busqueda.php?articulo=".$articulo);
    exit();

}

?>
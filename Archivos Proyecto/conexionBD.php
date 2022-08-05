<?php 

	function abrirConexion(){

		$USERNAME = "estudiante";
		$PASSWORD = "estudiante";
		$DATABASE = "localhost/ORCL";

		return $conn = oci_connect($USERNAME,$PASSWORD,$DATABASE);		

	} //Abrir conexion.

	function cerrarConexion($conexion){

		oci_close($conexion);

	} //Cerrar Conexion.

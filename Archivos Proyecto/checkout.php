<?php

include 'conexionBD.php';

include 'manejoDeSesion.php';

include 'manejoDeBusqueda.php';

if (isset($_POST["realizarCompra"])) {

  $idUsuario = $_SESSION["idUsuario"];
  $nombreTarjeta = $_POST['cardname'];
  $direccionDada = $_POST['address'];
  $numeroTarjeta = $_POST['cardnumber'];
  $correoUsuario = $_SESSION['correoElectronico'];
  $ciudadDada = $_POST['city'];
  $cantonDado = $_POST['canton'];
  $codigoPostal = $_POST['zip'];
  $montoTotal = $_SESSION["total"];
  $carritoCompras = $_SESSION["carrito"];

  $conexion = abrirConexion();

  $consultaSQL = " begin PAQUETE_DE_VENTAS.realizarVenta(:idUsuario,:nombreTarjeraP, :direccionDadaP,
  :numeroTarjetaP, :ciudadDadaP, :cantonDadoP,:codigoPostalP,:montoTotalP); end;";
  $stid = oci_parse($conexion, $consultaSQL);

  oci_bind_by_name($stid, ":idUsuario", $idUsuario);
  oci_bind_by_name($stid, ":nombreTarjeraP", $nombreTarjeta);
  oci_bind_by_name($stid, ":direccionDadaP", $direccionDada);
  oci_bind_by_name($stid, ":numeroTarjetaP", $numeroTarjeta);
  oci_bind_by_name($stid, ":ciudadDadaP", $ciudadDada);
  oci_bind_by_name($stid, ":cantonDadoP", $cantonDado);
  oci_bind_by_name($stid, ":codigoPostalP", $codigoPostal);
  oci_bind_by_name($stid, ":montoTotalP", $montoTotal);

  oci_execute($stid);

  $idProductoVenta = 1;

  for ($iterador = 0; $iterador < count($carritoCompras); $iterador++) {

    $consultaSQL = " begin PAQUETE_DE_VENTAS.agregarDetalleDeVenta(:idDetalleVentaP,:idUsuarioP,:idProductoP); end;";
    $stid = oci_parse($conexion, $consultaSQL);

    oci_bind_by_name($stid, ":idDetalleVentaP", $idProductoVenta);
    oci_bind_by_name($stid, ":idUsuarioP", $idUsuario);
    oci_bind_by_name($stid, ":idProductoP", $carritoCompras[$iterador]["idProducto"]);

    oci_execute($stid);

    $idProductoVenta++;

  } //Fin del for. 

  header("Location: confirmation.php?idUsuario=".$idUsuario);

} 

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="assets/css/checkout.css">
  <link rel="stylesheet" href="assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="assets/css/flaticon.css">
  <link rel="stylesheet" href="assets/css/slicknav.css">
  <link rel="stylesheet" href="assets/css/animate.min.css">
  <link rel="stylesheet" href="assets/css/magnific-popup.css">
  <link rel="stylesheet" href="assets/css/themify-icons.css">
  <link rel="stylesheet" href="assets/css/slick.css">
  <link rel="stylesheet" href="assets/css/nice-select.css">
  <link rel="stylesheet" href="assets/css/style.css">

</head>

<body>
  <header>
    <!-- Header Start -->
    <div class="header-area">
      <div class="main-header header-sticky">
        <div class="container-fluid">
          <div class="menu-wrapper">
            <!-- Logo -->
            <div class="logo">
              <a href="index.php"><img src="assets/img/logo/logo.png" alt=""></a>
            </div>
            <!-- Main-menu -->
            <div class="main-menu d-none d-lg-block">
                            <nav>
                                <ul id="navigation">
                                    <li><a href="index.php">Home</a></li>
                                    <li><a href="shop.php">Tienda</a>
                                        <ul class="submenu">
                                            <li><a href="shop.php">Todo</a></li>
                                            <li><a href="hoodies.php">Hoodies</a></li>
                                            <li><a href="camisas.php">Camisas</a></li>
                                            <li><a href="pants.php">Pantalones y shorts</a></li>
                                            <li><a href="tennis.php">Tennis</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Compras</a>
                                        <ul class="submenu">
                                            <li><a href="cart.php">Carrito</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>
            <!-- Header Right -->
            <div class="header-right">
              <ul>
                <li>
                  <div class="nav-search search-switch">
                    <span class="flaticon-search"></span>
                  </div>
                </li>
                <li> <a href="login.php"><span class="flaticon-user"></span></a></li>
                <li><a href="cart.php"><span class="flaticon-shopping-cart"></span></a> </li>
                <form method='POST'>
                  <li><button type='submit' name='cerrarSesion' style='color:black; border: none; background-color:white;'>Cerrar Sesion</a></li>
                </form>
              </ul>
            </div>
          </div>

          <?php

          mostrarDatosUsuario();

          ?>

          <!-- Mobile Menu -->
          <div class="col-12">
            <div class="mobile_menu d-block d-lg-none"></div>
          </div>
        </div>
      </div>
    </div>
    <!-- Header End -->
  </header>
  <main>
    <div class="row">
      <div class="col-75">
        <div class="container">
          <form method="POST">

            <div class="row">
              <div class="col-50">
                <h3>Dirección de Envio</h3>
                <label for="fname"><i class="fa fa-user"></i> Nombre Completo</label>
                <input type="text" id="fname" name="firstname" value=<?php echo  $_SESSION["nombreUsuario"] ?> required>
                <label for="email"><i class="fa fa-envelope"></i> Email</label>
                <input type="text" id="email" name="email" value=<?php echo  $_SESSION["correoElectronico"] ?> required>
                <label for="adr"><i class="fa fa-address-card-o"></i> Dirección</label required>
                <input type="text" id="adr" name="address" placeholder="---">
                <label for="city"><i class="fa fa-institution"></i> Ciudad</label required>
                <input type="text" id="city" name="city" placeholder="---">

                <div class="row">
                  <div class="col-50">
                    <label for="state">Cantón</label>
                    <input type="text" id="state" name="canton" placeholder="---" required>
                  </div>
                  <div class="col-50">
                    <label for="zip">Código Postal</label>
                    <input type="text" id="zip" name="zip" placeholder="---" required>
                  </div>
                </div>
              </div>

              <div class="col-50">
                <h3>Pago</h3>
                <label for="fname">Tarjetas aceptadas</label>
                <div class="icon-container">
                  <i class="fa fa-cc-visa" style="color:navy;"></i>
                  <i class="fa fa-cc-amex" style="color:blue;"></i>
                  <i class="fa fa-cc-mastercard" style="color:red;"></i>
                  <i class="fa fa-cc-discover" style="color:orange;"></i>
                </div>
                <label for="cname">Nombre en la tarjeta</label>
                <input type="text" id="cname" name="cardname" placeholder="---" required>
                <label for="ccnum">Número de tarjeta de crédito</label>
                <input type="text" id="ccnum" name="cardnumber" placeholder="---" required>
                <label for="expmonth">Mes Exp</label>
                <input type="text" id="expmonth" name="expmonth" placeholder="---" required>

                <div class="row">
                  <div class="col-50">
                    <label for="expyear">Año Exp</label>
                    <input type="text" id="expyear" name="expyear" placeholder="---" required>
                  </div>
                  <div class="col-50">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" placeholder="---" required>
                  </div>
                </div>
              </div>

            </div>
            <input type="submit" value="Realizar compra" class="btn" name="realizarCompra">
          </form>
        </div>
      </div>

      <div class="col-25">
        <div class="container">
          <h4>Carro
            <span class="price" style="color:black">
              <i class="fa fa-shopping-cart"></i>
              <b>
                <?php

                echo count($_SESSION["carrito"]);

                ?>

              </b>
            </span>
          </h4>

          <?php

          $carrito = $_SESSION["carrito"];

          for ($iterador = 0; $iterador < count($carrito); $iterador++) {

          ?>

            <p>
              <a href="#" style="color:black"><?php echo $carrito[$iterador]["nombreProducto"] ?></a>
              <span class="price"><?php echo utf8_encode($carrito[$iterador]["precioProducto"]) ?>
              </span>
            </p>

          <?php

          }

          ?>

          <hr>

          <p>Total <span class="price" style="color:black">

              <b><?php echo  '¢' .  $_SESSION["total"] ?></b>

            </span></p>
        </div>
      </div>
    </div>
  </main>
  <footer>
    <!-- Footer Start-->
    <div class="footer-area footer-padding">
      <div class="container">
        <div class="row d-flex justify-content-between">
          <div class="col-xl-3 col-lg-3 col-md-5 col-sm-6">
            <div class="single-footer-caption mb-50">
              <div class="single-footer-caption mb-30">
                <!-- logo -->
                <div class="footer-logo">
                  <a href="index.php"><img src="assets/img/logo/logo2_footer.png" alt=""></a>
                </div>
                <div class="footer-tittle">
                  <div class="footer-pera">
                    <p>Asorem ipsum adipolor sdit amet, consectetur adipisicing elitcf sed do eiusmod tem.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-2 col-lg-3 col-md-3 col-sm-5">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>Quick Links</h4>
                <ul>
                  <li><a href="#">About</a></li>
                  <li><a href="#"> Offers & Discounts</a></li>
                  <li><a href="#"> Get Coupon</a></li>
                  <li><a href="#"> Contact Us</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-4 col-sm-7">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>New Products</h4>
                <ul>
                  <li><a href="#">Woman Cloth</a></li>
                  <li><a href="#">Fashion Accessories</a></li>
                  <li><a href="#"> Man Accessories</a></li>
                  <li><a href="#"> Rubber made Toys</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-5 col-sm-7">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>Support</h4>
                <ul>
                  <li><a href="#">Frequently Asked Questions</a></li>
                  <li><a href="#">Terms & Conditions</a></li>
                  <li><a href="#">Privacy Policy</a></li>
                  <li><a href="#">Report a Payment Issue</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <!-- Footer bottom -->

</body>

</html>
<?php

include 'conexionBD.php';

include 'manejoDeSesion.php';

include 'manejoDeBusqueda.php';

$idUsuario = $_SESSION["idUsuario"];

$conexion = abrirConexion();

//

$consultaSQL = " begin PAQUETE_DE_VENTAS.devolverUltimaVenta(:idUsuarioP,:idUltimaVenta,:total,:fechaCompraP); end;";
$stid = oci_parse($conexion, $consultaSQL);

$idVenta = null;
$total = null;
$fechaCompra = null;

oci_bind_by_name($stid, ":idUsuarioP", $idUsuario);
oci_bind_by_name($stid, ":idUltimaVenta", $idVenta,1024);
oci_bind_by_name($stid, ":total", $total,1024);
oci_bind_by_name($stid, ":fechaCompraP", $fechaCompra,1024);

oci_execute($stid);

//

$productoComprados = oci_new_cursor($conexion);

$consultaSQL = " begin :productos := PAQUETE_DE_VENTAS.devolverDetallesDeVenta(:idUsuarioP); end;";
$stid = oci_parse($conexion, $consultaSQL);

oci_bind_by_name($stid, ":idUsuarioP", $idUsuario);
oci_bind_by_name($stid, ":productos", $productoComprados, -1, OCI_B_CURSOR);
oci_execute($stid);
oci_execute($productoComprados);

//

?>

<!doctype html>
<html lang="zxx">

<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>HAKU</title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="manifest" href="site.webmanifest">
  <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

  <!-- CSS here -->
  <link rel="stylesheet" href="assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="assets/css/flaticon.css">
  <link rel="stylesheet" href="assets/css/slicknav.css">
  <link rel="stylesheet" href="assets/css/animate.min.css">
  <link rel="stylesheet" href="assets/css/magnific-popup.css">
  <link rel="stylesheet" href="assets/css/fontawesome-all.min.css">
  <link rel="stylesheet" href="assets/css/themify-icons.css">
  <link rel="stylesheet" href="assets/css/slick.css">
  <link rel="stylesheet" href="assets/css/nice-select.css">
  <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
  <!--? Preloader Start -->
  <div id="preloader-active">
    <div class="preloader d-flex align-items-center justify-content-center">
      <div class="preloader-inner position-relative">
        <div class="preloader-circle"></div>
        <div class="preloader-img pere-text">
          <img src="assets/img/logo/logo_load.png" alt="">
        </div>
      </div>
    </div>
  </div>
  <!-- Preloader Start -->
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
    <!-- Hero Area Start-->
    <div class="slider-area ">
      <div class="single-slider slider-height2 d-flex align-items-center">
        <div class="container">
          <div class="row">
            <div class="col-xl-12">
              <div class="hero-cap text-center">
                <h2>Confirmacion de Pago</h2>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--================ confirmation part start =================-->
    <section class="confirmation_part section_padding">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="confirmation_tittle">
              <span>Gracias por su compra.</span>
            </div>
          </div>
          <div class="col-lg-6 col-lx-4">
            <div class="single_confirmation_details">
              <h4>order info</h4>
              <ul>
                <li>
                  <p>order number</p><span>: <?php echo $idVenta ?></span>
                </li>
                <li>
                  <p>data</p><span>: <?php echo $fechaCompra ?></span>
                </li>
                <li>
                  <p>total</p><span>:<?php echo utf8_encode($total) ?></span>
                </li> 
              </ul>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-12">
            <div class="order_details_iner">
              <h3>Detalles de orden</h3>
              <table class="table table-borderless">
                <thead>
                  <tr>
                    <th scope="col" colspan="2">Producto</th>
                    <th scope="col"></th>
                    <th scope="col">Precio</th>
                  </tr>
                </thead>
                <tbody>
                  <?php

                    while ($fila = oci_fetch_array($productoComprados)) {

                    ?>

                  <tr>
                    <th colspan="2"><span><?php echo $fila["nombreProducto"]?></span></th>
                    <th></th>
                    <th> <span><?php echo utf8_encode($fila["precioProducto"])?></span></th>
                  </tr>

                    <?php

                    }

                    ?>
                
                </tbody>
                <tfoot>
                  <tr>
                    <th scope="col" colspan="3">Cantidad: <?php echo count($_SESSION["carrito"])?></th>
                    <th scope="col">Total: <?php echo utf8_encode($total)?></th>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!--================ confirmation part end =================-->
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
                    <p>Satisfacción garantizada. Compre los últimos productos Street Nueva York en el mercado de algunos consignadores de todo Estados Unidos. La mejor calidad, se uno mas de nuestros clientes de todo el mundo.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-2 col-lg-3 col-md-3 col-sm-5">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>Enlaces rápidos</h4>
                <ul>
                  <li><a href="#"> Acerca de</a></li>
                  <li><a href="#"> Ofertas y descuentos</a></li>
                  <li><a href="#"> Obtener cupón</a></li>
                  <li><a href="#"> Contacta con nosotros</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-4 col-sm-7">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>Nuevos Productos</h4>
                <ul>
                  <li><a href="#">Hoodies</a></li>
                  <li><a href="#">Tennis</a></li>
                  <li><a href="#">Camisetas</a></li>
                  <li><a href="#">Pantalonetas</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-5 col-sm-7">
            <div class="single-footer-caption mb-50">
              <div class="footer-tittle">
                <h4>Soporte</h4>
                <ul>
                  <li><a href="#">Preguntas mas frecuentes</a></li>
                  <li><a href="#">Terminos y condiciones</a></li>
                  <li><a href="#">Politicas de privacidad</a></li>
                  <li><a href="#">Informar un problema de pago</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <!-- Footer bottom -->
        <div class="row align-items-center">
          <div class="col-xl-7 col-lg-8 col-md-7">
            <div class="footer-copy-right">
              <p>
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                Copyright &copy;<script>
                  document.write(new Date().getFullYear());
                </script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
              </p>
            </div>
          </div>
          <div class="col-xl-5 col-lg-4 col-md-5">
            <div class="footer-copy-right f-right">
              <!-- social -->
              <div class="footer-social">
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="https://www.facebook.com/sai4ull"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-behance"></i></a>
                <a href="#"><i class="fas fa-globe"></i></a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Footer End-->
  </footer>
  <!--? Search model Begin -->
  <div class="search-model-box">
    <div class="h-100 d-flex align-items-center justify-content-center">
      <div class="search-close-btn">+</div>
      <form class="search-model-form">
        <input type="text" id="search-input" placeholder="Searching key.....">
      </form>
    </div>
  </div>
  <!-- Search model end -->

  <!-- JS here -->

  <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
  <!-- Jquery, Popper, Bootstrap -->
  <script src="./assets/js/vendor/jquery-1.12.4.min.js"></script>
  <script src="./assets/js/popper.min.js"></script>
  <script src="./assets/js/bootstrap.min.js"></script>
  <!-- Jquery Mobile Menu -->
  <script src="./assets/js/jquery.slicknav.min.js"></script>

  <!-- Jquery Slick , Owl-Carousel Plugins -->
  <script src="./assets/js/owl.carousel.min.js"></script>
  <script src="./assets/js/slick.min.js"></script>

  <!-- One Page, Animated-HeadLin -->
  <script src="./assets/js/wow.min.js"></script>
  <script src="./assets/js/animated.headline.js"></script>
  <script src="./assets/js/jquery.magnific-popup.js"></script>

  <!-- Scroll up, nice-select, sticky -->
  <script src="./assets/js/jquery.scrollUp.min.js"></script>
  <script src="./assets/js/jquery.nice-select.min.js"></script>
  <script src="./assets/js/jquery.sticky.js"></script>

  <!-- contact js -->
  <script src="./assets/js/contact.js"></script>
  <script src="./assets/js/jquery.form.js"></script>
  <script src="./assets/js/jquery.validate.min.js"></script>
  <script src="./assets/js/mail-script.js"></script>
  <script src="./assets/js/jquery.ajaxchimp.min.js"></script>

  <!-- Jquery Plugins, main Jquery -->
  <script src="./assets/js/plugins.js"></script>
  <script src="./assets/js/main.js"></script>

</body>

</html>
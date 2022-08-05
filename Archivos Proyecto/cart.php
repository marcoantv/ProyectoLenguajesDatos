<?php

include 'conexionBD.php';

include 'manejoDeSesion.php';

include 'manejoDeBusqueda.php';

if (isset($_SESSION['carrito'])) {

  if (isset($_GET['idProducto'])) {

    $arregloCarrito = $_SESSION['carrito'];
    $idProducto = $_GET['idProducto'];
    $esta = false;

    for ($iterador = 0; $iterador < count($arregloCarrito); $iterador++) {

      if ($idProducto == $arregloCarrito[$iterador]['idProducto']) {

        $esta = true;
        break;
      } //Fin del if.

    } //Fin del for. 

    if (!$esta) {

      $nombreProducto = null;
      $descripcionProducto = null;
      $precioProducto = null;

      $conexion = abrirConexion();

      $consultaSQL = " begin PAQUETE_DE_PRODUCTOS.obtenerInformacionBasicaProducto(:idProductoP,:nombreProducto,:descripcionProducto,:precioProducto,:imagen); end;";
      $stid = oci_parse($conexion, $consultaSQL);

      $imagenProducto = oci_new_descriptor($conexion, OCI_DTYPE_LOB);

      oci_bind_by_name($stid, ":idProductoP", $idProducto);

      oci_bind_by_name($stid, ":nombreProducto", $nombreProducto, 64);
      oci_bind_by_name($stid, ":descripcionProducto", $descripcionProducto, 64);
      oci_bind_by_name($stid, ":precioProducto", $precioProducto, 64);
      oci_bind_by_name($stid, ":imagen", $imagenProducto, -1, OCI_B_BLOB);

      oci_execute($stid);

      cerrarConexion($conexion);

      $arregloNuevo = array(

        "idProducto" => $idProducto,
        "nombreProducto" => $nombreProducto,
        "descripcionProducto" => $descripcionProducto,
        "precioProducto" => $precioProducto,
        "imagenProducto" => $imagenProducto

      );

      array_push($arregloCarrito, $arregloNuevo);

      $_SESSION['carrito'] = $arregloCarrito;

      header("Location: ./cart.php");
    }
  } //Fin del isset

} else {

  if (isset($_GET['idProducto'])) {

    $idProducto = $_GET['idProducto'];

    $nombreProducto = null;
    $descripcionProducto = null;
    $precioProducto = null;

    $conexion = abrirConexion();

    $consultaSQL = " begin PAQUETE_DE_PRODUCTOS.obtenerInformacionBasicaProducto(:idProductoP,:nombreProducto,:descripcionProducto,:precioProducto,:imagen); end;";
    $stid = oci_parse($conexion, $consultaSQL);

    $imagenProducto = oci_new_descriptor($conexion, OCI_DTYPE_LOB);

    oci_bind_by_name($stid, ":idProductoP", $idProducto);

    oci_bind_by_name($stid, ":nombreProducto", $nombreProducto, 64);
    oci_bind_by_name($stid, ":descripcionProducto", $descripcionProducto, 64);
    oci_bind_by_name($stid, ":precioProducto", $precioProducto, 64);
    oci_bind_by_name($stid, ":imagen", $imagenProducto, -1, OCI_B_BLOB);

    oci_execute($stid);

    cerrarConexion($conexion);

    $arreglo[] = array(

      "idProducto" => $idProducto,
      "nombreProducto" => $nombreProducto,
      "descripcionProducto" => $descripcionProducto,
      "precioProducto" => $precioProducto,
      "imagenProducto" => $imagenProducto

    );

    $_SESSION['carrito'] = $arreglo;

    header("Location: ./cart.php");
  }
}

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
  <link rel="shortcut icon" type="image/x-icon" href="assets/img/haku.ico">

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
          <img src="assets/img/logo/logo1.png" alt="">
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
                <h2>Carrito de compras</h2>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--================Cart Area =================-->
    <section class="cart_area section_padding">
      <div class="container">
        <div class="cart_inner">
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">Producto</th>
                  <th scope="col">Precio</th>
                </tr>
              </thead>
              <tbody>

                <?php

                if (isset($_SESSION['carrito'])) {

                  $carrito = $_SESSION['carrito'];

                  for ($iterador = 0; $iterador < count($carrito); $iterador++) {

                ?>

                    <tr>
                      <td>
                        <div class="media">
                          <div class="d-flex">
                          </div>
                          <div class="media-body">
                            <h1><?php echo $carrito[$iterador]["nombreProducto"] ?></h1>
                            <p><?php echo $carrito[$iterador]["descripcionProducto"] ?></p>
                          </div>
                        </div>
                      </td>
                      <td>
                        <h5><?php echo utf8_encode($carrito[$iterador]["precioProducto"]) ?></h5>
                      </td>
                      <td></td>
                      <td>
                        <a href="#" class="btn btn-primary btn-sm btnEliminar" data-id="<?php echo $carrito[$iterador]["idProducto"]; ?>">X</a>
                      </td>
                    </tr>

                <?php

                  } //Fin del for.

                } //Fin del if. 

                ?>

                <tr class="bottom_button">
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td>
                    <h5>Total</h5>
                  </td>
                  <td>

                    <?php

                    if (isset($_SESSION['carrito'])) {

                      $_SESSION['total'] = 0;

                      $arregloCarrito = $_SESSION['carrito'];
                      $precioProducto= 0;
                      $total = 0;

                      $conexion = abrirConexion();

                      for ($iterador = 0; $iterador < count($arregloCarrito); $iterador++) {

                        $consultaSQL = " begin :precioR := PAQUETE_DE_VENTAS.devolverprecioarticulo(:idProductoP); end;";
                        $stid = oci_parse($conexion, $consultaSQL);

                        oci_bind_by_name($stid, ":precioR", $precioProducto,OCI_NUM);
                        oci_bind_by_name($stid, ":idProductoP", $arregloCarrito[$iterador]["idProducto"]);

                        oci_execute($stid);

                        $total = $total + $precioProducto;

                      } //Fin del for. 

                      $_SESSION['total'] = $total;

                      cerrarConexion($conexion);

                      echo "<h1>". '¢' . $total."</h1>";

                    } else {

                      echo "<h1>¢0</h1>";

                    }

                    ?>

                  </td>
                </tr>
              </tbody>
            </table>
            <div class="checkout_btn_inner float-right">
              <a class="btn_1" href="shop.php">Contiunar comprando</a>
              <?php

                    if(isset($_SESSION['carrito'])){

                      if(isset($_SESSION['nombreUsuario'])){

                        echo '<a class="btn_1 checkout_btn_1" href="checkout.php">Proceder al pago</a>';

                      } else{

                        echo '<a class="btn_1 checkout_btn_1" href="login.php">Proceder al pago</a>';

                      }
              
                    } else {

                      echo '<a class="btn_1 checkout_btn_1" href="shop.php">Proceder al pago</a>';

                    }


              ?>
            
            </div>
          </div>
        </div>
    </section>
    <!--================End Cart Area =================-->
  </main>>
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
      <form class="search-model-form" method='POST'>
        <input type="text" id="search-input" placeholder="Searching key....." name='search-input'>
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

  <!-- Scrollup, nice-select, sticky -->
  <script src="./assets/js/jquery.scrollUp.min.js"></script>
  <script src="./assets/js/jquery.nice-select.min.js"></script>
  <script src="./assets/js/jquery.sticky.js"></script>
  <script src="./assets/js/jquery.magnific-popup.js"></script>

  <!-- contact js -->
  <script src="./assets/js/contact.js"></script>
  <script src="./assets/js/jquery.form.js"></script>
  <script src="./assets/js/jquery.validate.min.js"></script>
  <script src="./assets/js/mail-script.js"></script>
  <script src="./assets/js/jquery.ajaxchimp.min.js"></script>

  <!-- Jquery Plugins, main Jquery -->
  <script src="./assets/js/plugins.js"></script>
  <script src="./assets/js/main.js"></script>

  <script>
    $(document).ready(function() {

      $(".btnEliminar").click(function() {

        event.preventDefault();
        var id = $(this).data('id');
        var boton = $(this);

        $.ajax({

          method: 'POST',
          url: './eliminarCarrito.php',
          data: {

            id: id

          }
        }).done(function(respuesta) {

          boton.parent("td").parent("tr").remove();
          windows.location.replace("cart.php");

        });

      });

    });
  </script>

</body>

</html>
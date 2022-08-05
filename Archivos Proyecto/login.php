<?php

include "manejoDeSesion.php";

include 'conexionBD.php';

if (isset($_POST['botonIniciarSesion'])) {


    $correoElectronico = $_POST['correo'];
    $contrasenia = $_POST['contrasenia'];
    $idUsuario = null;
    $nombreUsuario = null;

    $conexion = abrirConexion();

    $consultaSQL = "begin paquete_de_usuarios.iniciarSesion(:correo, :contrasenia, :idUsuario, :nombre); end;";
    $stid = oci_parse($conexion, $consultaSQL);

    oci_bind_by_name($stid, ":correo", $correoElectronico);
    oci_bind_by_name($stid, ":contrasenia", $contrasenia);
    oci_bind_by_name($stid, ":idUsuario", $idUsuario, 64);
    oci_bind_by_name($stid, ":nombre", $nombreUsuario, 64);
    oci_execute($stid);

    cerrarConexion($conexion);

    if ($idUsuario!=null) {

        session_start();

        $_SESSION["idUsuario"] = $idUsuario;
        $_SESSION['nombreUsuario'] = $nombreUsuario;
        $_SESSION['correoElectronico'] = $correoElectronico;

        header("Location: index.php");
        exit();
        
    } else {

        echo '<script> alert("Correo o contraseña incorrecta.") </script>;';

    } //Fin del else. 

} //Fin de inicio de sesion. 

if(isset($_POST['btnRegistrar'])){

$nombreV = $_POST['name'];
$emailV = $_POST['email'];
$contraseniaV = $_POST['psw'];
$verificarContrasenia = $_POST['psw-repeat'];

if($contraseniaV==$verificarContrasenia){

    $conexion = abrirConexion();

    $consultaSQL = "begin paquete_de_usuarios.registrarUsuario(:nombreP, :correoP, :contraseniaP); end;";
    $stid = oci_parse($conexion, $consultaSQL);
    
    oci_bind_by_name($stid, ":nombreP", $nombreV);
    oci_bind_by_name($stid, ":correoP", $emailV);
    oci_bind_by_name($stid, ":contraseniaP", $contraseniaV);

    oci_execute($stid);
    
    cerrarConexion($conexion);

    header("Location: login.php");

    echo '<script> alert("Se ha registrado con éxito.") </script>;';

    exit();

} else {

    echo '<script> alert("Correo o contraseña incorrecta.") </script>;';

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
    <link rel="stylesheet" href="assets/css/login.css">
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
        <!-- Button to open the modal -->
        <!-- The Modal (contains the Sign Up form) -->
        <div id="id01" class="modal">
            <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal"></span>
            <form class="modal-content" method="POST">
                <div class="container">
                    <h1>Registro Usuario Nuevo</h1>
                    <p>Completa tus datos</p>
                    <hr>
                    <label for="name"><b>Nombre</b></label><br>
                    <input type="text" placeholder="Ingresar Nombre" name="name" required><br>
                    <label for="email"><b>Email</b></label><br>
                    <input type="email" placeholder="Ingresar Email" name="email" required><br>
                    <label for="psw"><b>Contraseña</b></label>
                    <input type="password" placeholder="Ingresar Contraseña" name="psw" required>

                    <label for="psw-repeat"><b>Repetir Contraseña</b></label>
                    <input type="password" placeholder="Repetir Contraseña" name="psw-repeat" required>

                    <p>By creating an account you agree to our <a href="#" style="color:dodgerblue">Terms & Privacy</a>.
                    </p>

                    <div class="clearfix">
                        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancelar</button>
                        <button type="submit" class="signupbtn" name="btnRegistrar">Registrarse</button>
                    </div>
                </div>
            </form>
        </div>
        <!-- Hero Area End-->
        <!--================Registro Area =================-->
        <section class="login_part section_padding ">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-md-6">
                        <div class="login_part_text text-center">
                            <div class="login_part_text_iner">
                                <h2>Primera vez en nuestra Tienda?</h2>
                                <p>Regístrate y aprovecha tanto nuestros productos de calidad
                                    como nuestros precios únicos.</p>
                                <button class="button" onclick="document.getElementById('id01').style.display='block'">Crea una
                                    cuenta</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="login_part_form">
                            <div class="login_part_form_iner">
                                <h3>Bienvenido de nuevo! <br>
                                    Inicia sesión</h3>
                                <form class="row contact_form" action="#" method="post" novalidate="novalidate">
                                    <div class="col-md-12 form-group p_star">
                                        <input type="text" class="form-control" id="correo" name="correo" value="" placeholder="Correo Electrónico">
                                    </div>
                                    <div class="col-md-12 form-group p_star">
                                        <input type="password" class="form-control" id="contrasenia" name="contrasenia" value="" placeholder="Contraseña">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <div class="creat_account d-flex align-items-center">
                                            <input type="checkbox" id="f-option" name="selector">
                                            <label for="f-option">Recuérdame</label>
                                        </div>
                                        <button type="submit" value="submit" class="btn_3" name="botonIniciarSesion">
                                            Iniciar sesión
                                        </button>
                                        <a class="lost_pass" href="#">
                                            ¿Has olvidado los datos de la cuenta?</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================login_part end =================-->
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
                                        <p>Asorem ipsum adipolor sdit amet, consectetur adipisicing elitcf sed do
                                            eiusmod tem.</p>
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
                                Copyright &copy;
                                <script>
                                    document.write(new Date().getFullYear());
                                </script> All rights reserved | This
                                template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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

    <!-- Scroll up, nice-select, sticky -->
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
    <script src="./assets/js/test.js"></script>


    <!-- Jquery Plugins, main Jquery -->
    <script src="./assets/js/plugins.js"></script>
    <script src="./assets/js/main.js"></script>
</body>

</html>
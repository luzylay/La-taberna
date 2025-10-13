<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <link rel="stylesheet" href="/css/servicios-css.css">
    <link rel="icon" type="image/png" href="https://static.vecteezy.com/system/resources/previews/036/331/638/original/bottle-of-wine-icon-png.png">
</head>
<body>
    <!-- header -->
    <jsp:include page="header.jsp" />
    <!-- header -->

    <!-- Texto principal -->
    <section class="main-texto">
        <div class="container text-center py-5 caja">
            <h1 class="titulo-dorado">Nuestros Servicios</h1>
            <p class="lead">
                En <strong>La Taberna de Roly</strong> ofrecemos más que solo productos.
                Brindamos experiencias únicas para los amantes del buen licor y la atención personalizada.
            </p>
        </div>
    </section>

    <!-- Servicios -->
    <section id="servicios" class="py-5">
        <div class="container">
            <div class="row g-4">

                <!-- Servicio 1 -->
                <div class="col-md-4">
                    <div class="card shadow border-0 rounded-4 text-center p-4 h-100">
                        <img src="https://cdn-icons-png.flaticon.com/512/1163/1163661.png" alt="Catas de vino" class="mx-auto mb-3" width="70">
                        <h4 class="fw-bold">Catas de Vino</h4>
                        <p>
                            Organizamos degustaciones guiadas por expertos donde podrás conocer y disfrutar distintos tipos de vino.
                        </p>
                    </div>
                </div>

                <!-- Servicio 2 -->
                <div class="col-md-4">
                    <div class="card shadow border-0 rounded-4 text-center p-4 h-100">
                        <img src="https://cdn-icons-png.flaticon.com/512/1029/1029183.png" alt="Delivery de licores" class="mx-auto mb-3" width="70">
                        <h4 class="fw-bold">Delivery de Licores</h4>
                        <p>
                            Disfruta de tus bebidas favoritas sin salir de casa. Llevamos tus pedidos directamente hasta tu puerta.
                        </p>
                    </div>
                </div>

                <!-- Servicio 3 -->
                <div class="col-md-4">
                    <div class="card shadow border-0 rounded-4 text-center p-4 h-100">
                        <img src="https://cdn-icons-png.flaticon.com/512/3565/3565787.png" alt="Asesoría para eventos" class="mx-auto mb-3" width="70">
                        <h4 class="fw-bold">Asesoría para Eventos</h4>
                        <p>
                            Te ayudamos a elegir los mejores licores y cantidades ideales para bodas, reuniones y celebraciones especiales.
                        </p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Llamado a la acción -->
    <section class="py-5 bg-light text-center">
        <div class="container">
            <h2 class="titulo-dorado mb-3">¿Quieres más información?</h2>
            <p class="lead">Contáctanos para personalizar tu experiencia con nuestros servicios.</p>
            <a href="${pageContext.request.contextPath}/contacto" class="btn btn-primary mt-2">Ir a Contacto</a>

        </div>
    </section>           

    <!-- footer -->
    <jsp:include page="footer.jsp" />
    <!-- footer -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



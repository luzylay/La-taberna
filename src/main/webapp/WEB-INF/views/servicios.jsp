<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios | La Taberna de Roly</title>
    <link rel="icon" type="image/png" href="https://static.vecteezy.com/system/resources/previews/036/331/638/original/bottle-of-wine-icon-png.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .hero-servicios {
          background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
            url('https://www.losvinos.com.ar/wp-content/uploads/2019/10/bartender.jpeg') center/cover no-repeat;
          color: #fff;
          padding: 8rem 1rem;
        }
        .titulo-dorado {
          color: #d4af37;
          font-weight: 700;
          letter-spacing: 1px;
        }
        .card-servicio img {
          width: 80px;
          height: 80px;
          object-fit: contain;
        }
        .card-servicio {
          transition: all 0.3s ease;
        }
        .card-servicio:hover {
          transform: translateY(-5px);
          box-shadow: 0 0.5rem 1.2rem rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp"/>
<!-- /Header -->

<section class="hero-servicios text-center d-flex align-items-center justify-content-center">
    <div class="container">
        <h1 class="titulo-dorado display-5 mb-3">Nuestros Servicios</h1>
        <p class="lead mx-auto w-75">
            En <strong>La Taberna de Roly</strong> ofrecemos más que productos: brindamos experiencias únicas para
            los amantes del buen licor y la atención personalizada.
        </p>
    </div>
</section>

<!-- Servicios -->
<section id="servicios" class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold display-6 text-uppercase">
                Experiencias y <span class="text-danger">Servicios</span>
            </h2>
            <p class="text-muted fs-5 mb-3">
                Te acompañamos en cada celebración con nuestra atención personalizada y pasión por el detalle.
            </p>
            <hr class="w-25 mx-auto border-danger border-2 opacity-75">
        </div>

        <div class="row g-4">
            <!-- Servicio 1 -->
            <div class="col-md-4">
                <div class="card card-servicio shadow border-0 rounded-4 text-center p-4 h-100">
                    <img src="https://cdn-icons-png.flaticon.com/512/1163/1163661.png" alt="Catas de vino"
                         class="mx-auto mb-3">
                    <h4 class="fw-bold text-danger">Catas de Vino</h4>
                    <p class="text-muted">
                        Degustaciones guiadas por expertos donde aprenderás a apreciar aromas, sabores y secretos de
                        cada vino.
                    </p>
                </div>
            </div>

            <!-- Servicio 2 -->
            <div class="col-md-4">
                <div class="card card-servicio shadow border-0 rounded-4 text-center p-4 h-100">
                    <img src="https://cdn-icons-png.flaticon.com/512/1029/1029183.png" alt="Delivery de licores"
                         class="mx-auto mb-3">
                    <h4 class="fw-bold text-danger">Delivery de Licores</h4>
                    <p class="text-muted">
                        Disfruta de tus bebidas favoritas sin salir de casa. Llevamos tus pedidos directamente hasta tu
                        puerta.
                    </p>
                </div>
            </div>

            <!-- Servicio 3 -->
            <div class="col-md-4">
                <div class="card card-servicio shadow border-0 rounded-4 text-center p-4 h-100">
                    <img src="https://cdn-icons-png.flaticon.com/512/3565/3565787.png" alt="Asesoría para eventos"
                         class="mx-auto mb-3">
                    <h4 class="fw-bold text-danger">Asesoría para Eventos</h4>
                    <p class="text-muted">
                        Te ayudamos a elegir los mejores licores y cantidades ideales para bodas, reuniones y
                        celebraciones especiales.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5 bg-light text-center">
    <div class="container">
        <h2 class="titulo-dorado mb-3">¿Quieres más información?</h2>
        <p class="lead">Contáctanos para personalizar tu experiencia con nuestros servicios.</p>
        <a href="${pageContext.request.contextPath}/contacto"
           class="btn btn-danger mt-2 px-4 py-2 rounded-pill fw-bold shadow-sm">
            <i class="bi bi-envelope-paper me-2"></i> Ir a Contacto
        </a>
    </div>
</section>

<!-- Footer -->
<jsp:include page="footer.jsp"/>
<!-- /Footer -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

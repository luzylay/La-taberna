<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Gestión</title>
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestion-css.css">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>

<div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="sidebarMenu">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Menú</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body p-0">
        <jsp:include page="gestion-panel-lateral.jsp" />
    </div>
</div>

<div class="d-none d-md-block sidebar-container">
    <jsp:include page="gestion-panel-lateral.jsp" />
</div>

<main class="px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="border-start border-4 border-primary ps-3 fw-bold m-0">
            <i class="bi me-2"></i>Dashboard
        </h1>
        <button class="btn btn-dark d-md-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
            <i class="bi bi-list"></i>
        </button>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card text-white bg-primary h-100 p-3">
                <h6 class="text-uppercase opacity-75">Venta Total</h6>
                <h2 class="fw-bold mb-0">S/ <span id="total_venta">0.00</span></h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-success h-100 p-3">
                <h6 class="text-uppercase opacity-75">Ticket Promedio</h6>
                <h2 class="fw-bold mb-0">S/ <span id="promedio">0.00</span></h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-secondary h-100 p-3"> <h6 class="text-uppercase opacity-75">Usuarios Activos</h6>
                <h2 class="fw-bold mb-0" id="cant_users">0</h2>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-6">
            <div class="chart-wrapper">
                <div id="chart3" class="chart-div"></div> </div>
        </div>
        <div class="col-lg-6">
            <div class="chart-wrapper">
                <div id="chart2" class="chart-div"></div> </div>
        </div>

        <div class="col-lg-6">
            <div class="chart-wrapper">
                <div id="chart1" class="chart-div"></div> </div>
        </div>
        <div class="col-lg-6">
            <div class="chart-wrapper">
                <div id="chart4" class="chart-div"></div> </div>
        </div>
    </div>

</main>

<footer>
    <div>© 2025 - Panel de Gestión | Todos los derechos reservados</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/gestion-info.js"></script>
</body>
</html>
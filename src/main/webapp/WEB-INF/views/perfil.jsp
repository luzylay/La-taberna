<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil del Usuario</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/login-css.css">
    <link rel="icon" type="image/png"
          href="https://static.vecteezy.com/system/resources/previews/036/331/638/original/bottle-of-wine-icon-png.png">
</head>

<body>
<!-- Header -->
<jsp:include page="header.jsp"/>

<main id="perfil" class="perfil-section p-5">
    <section>
        <div class="container">
            <div class="row justify-content-center gy-5">

                <!-- Perfil -->
                <div class="col-12 col-md-4 d-flex justify-content-center"
                     style="max-height: 520px; min-height: 520px;">
                    <div class="card shadow rounded-4 p-4 perfil-card w-100" style="max-width: 600px;">
                        <div class="card-body text-center">
                            <h2 class="mb-4">Mi Perfil</h2>

                            <!-- Imagen -->
                            <div class="mb-3">
                                <img
                                        src="https://www.kamenarstvovaterka.sk/img/uploads/15S9201702-54-20IMG-704.png"
                                        alt="Foto de ${sessionScope.user.nombre_user}"
                                        class="rounded-circle shadow"
                                        width="120" height="120">
                            </div>

                            <!-- Datos -->
                            <div class="text-start mb-3">
                                <p><strong class="text-dark">User ID:</strong>
                                    <span class="text-primary">${sessionScope.user.id_usuario}</span></p>
                                <p><strong class="text-dark">Nombre:</strong>
                                    <span class="text-primary">${sessionScope.user.nombre_user}</span></p>
                                <p><strong class="text-dark">Ap. Paterno:</strong>
                                    <span class="text-primary">${sessionScope.user.apaterno_user}</span></p>
                                <p><strong class="text-dark">Ap. Materno:</strong>
                                    <span class="text-primary">${sessionScope.user.amaterno_user}</span></p>
                                <p><strong class="text-dark">Correo:</strong>
                                    <span class="text-primary">${sessionScope.user.correo_user}</span></p>
                                <p><strong class="text-dark">Teléfono:</strong>
                                    <span class="text-primary">${sessionScope.user.telefono_user}</span></p>
                                <p><strong class="text-dark">Tipo:</strong>
                                    <span class="text-primary">${sessionScope.user.tipo_user.nombre_tipoUsuario}</span>
                                </p>
                            </div>

                            <!-- Botones -->
                            <div class="d-flex justify-content-center gap-3 mt-4">
                                <a href="#" class="btn btn-primary">
                                    <i class="bi bi-pencil-square me-1"></i>
                                    Editar Perfil
                                </a>
                                <a href="#" class="btn btn-warning">
                                    <i class="bi bi-lock-fill me-1"></i>
                                    Cambiar Contraseña
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Historial -->
                <div class="col-12 col-md-8 d-flex justify-content-center">
                    <div class="card shadow rounded-4 p-4 w-100" style="max-width: 900px;">
                        <div class="card-body">
                            <h3 class="text-center mb-4">
                                <i class="bi bi-cart-check-fill me-2 text-success"></i>
                                Historial de Compras
                            </h3>

                            <!-- Si no tiene compras -->
                            <c:if test="${empty compras}">
                                <div class="alert alert-secondary text-center">
                                    Aún no has realizado ninguna compra.
                                </div>
                            </c:if>

                            <!-- Si tiene compras -->
                            <c:if test="${not empty compras}">
                                <div class="historial-compras" style="max-height: 600px; overflow-y: auto;">
                                    <c:forEach var="venta" items="${compras}" varStatus="statusVenta">
                                        <div class="card shadow-sm mb-3">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    Compra #${statusVenta.index + 1} (ID: ${venta.id_venta})
                                                </h5>
                                                <p class="card-text"><strong>Fecha:</strong> ${venta.fechaFormateada}
                                                </p>
                                                <p class="card-text"><strong>Total:</strong> S/ ${venta.total_venta}</p>

                                                <!-- Contenedor botones -->
                                                <div class="d-flex gap-2 align-items-center">
                                                    <!-- Btn Mostrar/Ocultar productos -->
                                                    <a class="btn btn-primary btn-sm"
                                                       data-bs-toggle="collapse"
                                                       href="#collapseDetalles${statusVenta.index}"
                                                       role="button"
                                                       aria-expanded="false"
                                                       aria-controls="collapseDetalles${statusVenta.index}">
                                                        Ver productos
                                                    </a>

                                                    <!-- Btn Boleta PDF -->
                                                    <a href="/gestion/reportes/generarBoleta/${venta.id_venta}"
                                                       class="btn btn-success btn-sm rounded-pill shadow-sm"
                                                       target="_blank">
                                                        <i class="bi bi-file-earmark-pdf"></i>
                                                    </a>
                                                </div>

                                                <!-- Detalles -->
                                                <div class="collapse" id="collapseDetalles${statusVenta.index}">
                                                    <div class="card card-body"
                                                         style="max-height: 300px; overflow-y: auto;">
                                                        <c:forEach var="detalles" items="${venta.detalles_Venta}"
                                                                   varStatus="statusDetalle">
                                                            <div class="card mb-3 shadow-sm detalle-producto">
                                                                <div class="row g-0 align-items-center">
                                                                    <div class="col-md-8">
                                                                        <div class="card-body">
                                                                            <h5 class="card-title nombre">
                                                                                ${detalles.producto.nombre_pro}</h5>
                                                                            <p class="card-text mb-1">
                                                                                <strong>Cantidad:</strong> <span
                                                                                    class="cantidad">${detalles.cantidad_det}</span>
                                                                            </p>
                                                                            <p class="card-text mb-1">
                                                                                <strong>Precio unitario:</strong> <span
                                                                                    class="precio">S/${detalles.producto.precio_pro}</span>
                                                                            </p>
                                                                            <p class="card-text mb-0">
                                                                                <strong>Subtotal:</strong> <span
                                                                                    class="subtotal">S/${detalles.subtotal_det}</span>
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4 text-center">
                                                                        <img src="${detalles.producto.url_pro}"
                                                                             class="img-fluid rounded-start"
                                                                             alt="Producto"
                                                                             style="max-width: 80px; max-height: 80px; margin:10px">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>


            </div>
        </div>
    </section>
</main>
<!-- Footer -->
<jsp:include page="footer.jsp"/>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras</title>
    <link rel="stylesheet" href="/css/contact-css.css">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/891/891462.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<!-- Header -->
<jsp:include page="header.jsp"/>
<!-- /Header -->

<!-- Encabezado -->
<section class="page-header text-center text-white py-5 mb-5 position-relative">
    <div class="overlay"></div>
    <div class="container position-relative">
        <h1 class="display-4 fw-bold mb-3">Tu carrito de compras</h1>
        <p class="lead mb-0">Revisa tus productos antes de finalizar la compra</p>
    </div>
</section>

<!-- Carrito -->
<section id="carrito" class="py-5">
    <div class="container">
        <div class="card shadow border-0 rounded-4 overflow-hidden">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-dark text-center">
                        <tr>
                            <th>#</th>
                            <th>Img. Referencia</th>
                            <th>Producto</th>
                            <th>Precio Unitario</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                            <th>Acción</th>
                        </tr>
                        </thead>
                        <tbody class="text-center">
                        <!-- Bucle de productos en la venta -->
                        <c:forEach var="det" items="${venta.detalles_Venta}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>
                                    <img src="${det.producto.url_pro}"
                                         alt="(${det.producto.id_producto}) ${det.producto.nombre_pro}"
                                         style="width: 80px; height: 80px; object-fit: cover;">
                                </td>
                                <td>${det.producto.nombre_pro}</td>
                                <td>S/${det.producto.precio_pro}</td>
                                <td>${det.cantidad_det}</td>
                                <td>S/${det.subtotal_det}</td>
                                <td>
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Total -->
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <h4>Total: <span class="text-primary fw-bold">S/${venta.total_venta}</span></h4>
                    <form action="/carrito/finalizar" method="POST">
                        <button type="submit" class="btn btn-success btn-lg">
                            Compra
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="footer.jsp"/>
<!-- /Footer -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

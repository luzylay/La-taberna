<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <button class="btn btn-dark d-md-none mb-3" type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#sidebarMenu"
                aria-controls="sidebarMenu" style="border-radius: 0;">
            <i class="bi bi-list"></i> Menú
        </button>

        <div class="offcanvas offcanvas-start d-md-none bg-dark bg-opacity-90"
             tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarLabel">
            <div class="offcanvas-header">
                <button type="button" class="btn-close text-reset"
                        data-bs-dismiss="offcanvas" aria-label="Cerrar"></button>
            </div>
            <div class="offcanvas-body p-0">
                <jsp:include page="gestion-panel-lateral.jsp" />
            </div>
        </div>

        <div class="d-none d-md-block col-md-2 p-0 vh-100">
            <jsp:include page="gestion-panel-lateral.jsp" />
        </div>
        <main class="col-md-10 ms-sm-auto px-md-4 py-4">

            <h1 class="fw-bold text-center mb-4">
                <i class="bi bi-cart-plus me-2"></i> Nueva Venta
            </h1>

            <div class="card border-0 mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/gestion/ventas/guardarVenta" method="post">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Cliente</label>
                                <div class="input-group">
                                    <input class="col-md-3" type="number" id="id_usuario" name="id_usuario"
                                           class="form-control" placeholder="ID Cliente" min="1">
                                    <input type="text" id="nombre_user" class="form-control col-md-9"
                                           name="nombre_user" readonly placeholder="Nombre del Cliente">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">Fecha de Venta</label>
                                <input type="datetime-local" class="form-control" name="fecha_venta" required>
                            </div>
                        </div>

                        <div class="mt-4">
                            <h5 class="fw-bold">
                                <i class="bi bi-basket me-2"></i> Detalles de la Venta
                            </h5>
                            <div class="table-responsive">
                                <table class="table table-striped align-middle mt-2">
                                    <thead class="table-dark text-center">
                                    <tr>
                                        <th>Imagen</th>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Precio U. (S/)</th>
                                        <th>Subtotal (S/)</th>
                                        <th>Acciones</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tablaDetalles">
                                    </tbody>
                                </table>
                            </div>

                            <button type="button" class="btn btn-outline-primary mt-2" data-bs-toggle="modal"
                                    data-bs-target="#modalProductos">
                                <i class="bi bi-plus-circle"></i> Agregar Producto
                            </button>
                        </div>

                        <div class="mt-4 d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/gestion/ventas" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                            <button type="submit" class="btn btn-success px-4 shadow-sm">
                                <i class="bi bi-save"></i> Guardar Venta
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </main>
    </div>
</div>

<div class="modal fade" id="modalProductos" tabindex="-1" aria-labelledby="modalProductosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalProductosLabel">Seleccionar Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <table class="table table-hover" id="tablaModalProductos">
                    <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Precio (S/)</th>
                        <th>Acción</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-2 mt-4">
    © 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i> Derechos reservados
</footer>

<div class="modal fade" id="modalProductos" tabindex="-1" aria-labelledby="modalProductosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalProductosLabel">Seleccionar Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <table class="table table-hover" id="tablaModalProductos">
                    <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Precio (S/)</th>
                        <th>Acción</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/actualizar-ventas-js.js"></script>
<script src="${pageContext.request.contextPath}/js/agregar-ventas.js"></script>

</body>
</html>
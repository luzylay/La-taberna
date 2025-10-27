<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="icon" type="image/png"
          href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="d-none d-md-block col-md-2 p-0 vh-100 bg-dark text-white">
            <jsp:include page="gestion-panel-lateral.jsp"/>
        </div>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 min-vh-100 py-4">

            <!-- Encabezado -->
            <h1 class="fw-bold text-center mb-4 pb-2">
                <i class="bi bi-pencil-square me-2"></i>Editar Venta
            </h1>

            <!-- Info de la venta -->
            <div class="card shadow-lg border-0 rounded-4 mb-4">
                <div class="card-body">
                    <form action="/gestion/ventas/actualizarVenta" method="post">

                        <!-- ID -->
                        <input type="hidden" name="id_venta" value="${venta.id_venta}">

                        <div class="row g-3">

                            <!-- Usuario -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Usuario</label>
                                <input type="text" class="form-control" name="nombre_usuario"
                                       value="${venta.id_usuario.nombre_user} ${venta.id_usuario.apaterno_user} ${venta.id_usuario.amaterno_user}"
                                       readonly>
                            </div>

                            <!-- Fecha -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Fecha de Venta</label>
                                <input type="datetime-local" class="form-control" name="fecha_venta"
                                       value="${venta.fecha_venta}" required>
                            </div>

                        </div>


                        <!-- Detalles -->
                        <div class="mt-4">
                            <h5 class="fw-bold">
                                <i class="bi bi-basket me-2"></i>Detalles de la Venta
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
                                    <c:forEach var="d" items="${venta.detalles_Venta}">
                                        <tr>
                                            <!-- ID -->
                                            <td style="display: none;">
                                                <input
                                                    type="hidden"
                                                    class="id_producto"
                                                    name="id_producto[]"
                                                    value="${d.producto.id_producto}"
                                                    >
                                            </td>

                                            <!-- Imagen -->
                                            <td>
                                                <img src="${d.producto.url_pro}"
                                                     alt="${d.producto.nombre_pro}"
                                                     class="img-thumbnail"
                                                     style="width: 60px; height: 60px; object-fit: cover;">
                                            </td>

                                            <!-- Nombre -->
                                            <td class="fw-semibold">
                                                ${d.producto.nombre_pro}
                                                <input type="hidden" value="${d.producto.id_producto}">
                                            </td>

                                            <!-- Cantidad --->
                                            <td>
                                                <input type="number"
                                                       name="cantidades[]"
                                                       class="form-control text-center"
                                                       value="${d.cantidad_det}"
                                                       style="max-width:55px;"
                                                       min="1">
                                            </td>


                                            <!-- Precio unidad --->
                                            <td>
                                                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 0;">
                                                    <span style="font-weight: 500;">S/</span>
                                                    <input type="text"
                                                           value="${d.subtotal_det}"
                                                           readonly
                                                           style="background: transparent; border: none; text-align: right; width: 35px; padding: 0; margin: 0;">
                                                </div>
                                            </td>

                                            <!-- SubTotal -->
                                            <td>
                                                <div style="display: flex; align-items: center; justify-content: flex-end; gap: 0;">
                                                    <span style="font-weight: 500;">S/</span>
                                                    <input type="text"
                                                           value="${d.subtotal_det}"
                                                           readonly
                                                           style="background: transparent; border: none; text-align: right; width: 50px; padding: 0; margin: 0;">
                                                </div>
                                            </td>

                                            <!-- Acciones -->
                                            <td class="text-center">
                                                <button type="button" class="btn btn-danger btn-sm eliminarFila"
                                                    onclick="if(confirm('¿Estás seguro de eliminar este producto?')) eliminarFila(this)">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Botón para abrir modal -->
                            <button type="button" class="btn btn-outline-primary mt-2" data-bs-toggle="modal" data-bs-target="#modalProductos">
                                <i class="bi bi-plus-circle"></i> Agregar Producto
                            </button>
                        </div>

                        <!-- Btn finalizar -->
                        <div class="mt-4 d-flex justify-content-between">
                            <a href="/gestion/ventas" class="btn btn-secondary rounded-pill px-4">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                            <button type="submit" class="btn btn-success rounded-pill px-4 shadow-sm">
                                <i class="bi bi-save"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </main>
    </div>
</div>

<footer class="bg-dark text-white text-center py-2 mt-4">
    <div>© 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i> Derechos reservados</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/actualizar-ventas-js.js"></script>
<!-- Modal -->
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
                    <!-- Se llenará dinámicamente con JS -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>

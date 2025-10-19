<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión - Ventas</title>
    <link rel="stylesheet" href="css/gestion-css.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- BARRA LATERAL -->
        <button class="btn btn-dark d-md-none mb-3" type="button" data-bs-toggle="offcanvas"
                data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" style="border-radius: 0px;">
            <i class="bi bi-list"></i> Menú
        </button>
        <div class="offcanvas offcanvas-start d-md-none bg-dark bg-opacity-90" tabindex="-1"
             id="sidebarMenu" aria-labelledby="sidebarLabel">
            <div class="offcanvas-header">
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                        aria-label="Cerrar"></button>
            </div>
            <div class="offcanvas-body p-0">
                <jsp:include page="gestion-panel-lateral.jsp"/>
            </div>
        </div>
        <div class="d-none d-md-block col-md-2 p-0 vh-100">
            <jsp:include page="gestion-panel-lateral.jsp"/>
        </div>

        <!-- MAIN -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 min-vh-100">
            <div class="d-flex justify-content-between align-items-center mt-4 mb-3">
                <h1 class="text-center p-3 flex-grow-1">Gestión de Ventas</h1>
            </div>

            <div class="table-responsive shadow-sm rounded">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Correo</th>
                        <th>Telefóno</th>
                        <th>Fecha Venta</th>
                        <th>Detalles</th>
                        <th>Total</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="v" items="${ventas}">
                        <tr class="align-middle text-center">
                            <td>${v.id_venta}</td>
                            <td>
                                ${v.id_usuario.apaterno_user}
                                ${v.id_usuario.amaterno_user}
                                ${v.id_usuario.nombre_user}
                            </td>
                            <td>${v.id_usuario.correo_user}</td>
                            <td>${v.id_usuario.telefono_user}</td>
                            <td>${v.fechaFormateada}</td>
                            <td>
                                <table class="table table-sm table-bordered border-secondary-subtle mb-0 bg-light">
                                    <thead class="table-secondary text-center small">
                                    <tr>
                                        <th>Producto</th>
                                        <th>Precio U.</th>
                                        <th>Cantidad</th>
                                        <th>Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-center">
                                    <c:forEach var="d" items="${v.detalles_Venta}">
                                        <tr>
                                            <td class="text-start">${d.producto.nombre_pro}</td>
                                            <td>S/${d.producto.precio_pro}</td>
                                            <td>${d.cantidad_det}</td>
                                            <td>S/${d.subtotal_det}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </td>
                            <td>S/ ${v.total_venta}</td>
                            <td>
                                <!-- Btn Editar -->
                                <a href="/gestion/usuarios/editar/${u.id_usuario}"
                                   class="btn btn-warning btn-sm btn-editar mb-1">
                                    <i class="bi bi-pencil-square me-2"></i>Editar
                                </a>

                                <!-- Btn Eliminar -->
                                <form action="/gestion/usuarios/eliminarUsuario" method="post"
                                      onsubmit="return confirm('¿Estás seguro de eliminar este usuario?');"
                                      style="display:inline;">
                                    <input type="hidden" name="id_usuario" value="${u.id_usuario}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash me-1"></i>Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<c:if test="${not empty verificar}">
    <script type="text/javascript">
        <c:choose>
            <c:when test="${verificar == 1}">
                alert("Se agregó un usuario correctamente :D");
            </c:when>
            <c:when test="${verificar == 2}">
                alert("Se editó un usuario correctamente :D");
            </c:when>
            <c:when test="${verificar == 3}">
                alert("Se eliminó un usuario correctamente :D");
            </c:when>
            <c:otherwise>
                alert("La operación no se pudo realizar D:");
            </c:otherwise>
        </c:choose>
    </script>
</c:if>

<!--Footer-->
<footer class="bg-dark text-white text-center py-2">
    <div>© 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i> Derechos reservados</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
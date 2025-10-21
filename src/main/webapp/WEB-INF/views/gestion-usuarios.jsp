<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión - Usuarios</title>
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
                <h1 class="text-center p-3 flex-grow-1 fw-bold">
                    <i class="bi bi-people-fill me-2"></i> Gestión de Usuarios
                </h1>

                <!-- Btn Agregar -->
                <a href="/gestion/usuarios/NuevoUsuario"
                   class="btn btn-success btn-lg shadow-sm"
                   style="border-radius: 50px; transition: all 0.3s;">
                    <i class="bi bi-plus-circle me-2"></i> Agregar Usuario
                </a>
            </div>

            <!-- LISTA DE USUARIOS EN FORMATO DE TARJETAS -->
            <div class="row g-4">
                <c:forEach var="u" items="${usuarios}">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card border-0 shadow rounded-4 h-100">

                            <!-- Encabezado -->
                            <div class="card-header bg-dark bg-opacity-75 text-white rounded-top-4">
                                <h5 class="mb-1 fw-bold">
                                    <span class="badge bg-dark bg-opacity-75 mb-3 d-block">ID: ${u.id_usuario}</span>
                                    <i class="bi bi-person-circle me-2"></i>
                                    ${u.nombre_user} ${u.apaterno_user} ${u.amaterno_user}
                                </h5>
                            </div>

                            <!-- Cuerpo -->
                            <div class="card-body">
                                <p class="mb-2">
                                    <i class="bi bi-envelope me-2"></i>
                                    <strong>Correo:</strong> ${u.correo_user}
                                </p>
                                <p class="mb-2">
                                    <i class="bi bi-telephone me-2"></i>
                                    <strong>Teléfono:</strong> ${u.telefono_user}
                                </p>
                                <p class="mb-2">
                                    <i class="bi bi-person-badge me-2"></i>
                                    <strong>Tipo de usuario:</strong> ${u.tipo_user.nombre_tipoUsuario}
                                </p>
                                <p class="mb-0">
                                    <i class="bi bi-toggle-on me-2"></i>
                                    <strong>Estado:</strong>
                                    <c:choose>
                                        <c:when test="${u.estado_user}">
                                            <span class="badge bg-success bg-opacity-75">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger bg-opacity-75">Desactivado</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <!-- Pie -->
                            <div class="card-footer bg-light d-flex justify-content-between align-items-center rounded-bottom-4">
                                <!-- Btn Editar -->
                                <a href="/gestion/usuarios/editar/${u.id_usuario}"
                                   class="btn btn-warning btn-sm rounded-pill shadow-sm">
                                    <i class="bi bi-pencil-square"></i> Editar
                                </a>

                                <!-- Btn Eliminar -->
                                <form action="/gestion/usuarios/eliminarUsuario" method="post"
                                      onsubmit="return confirm('¿Estás seguro de eliminar este usuario?');" class="m-0">
                                    <input type="hidden" name="id_usuario" value="${u.id_usuario}">
                                    <button type="submit" class="btn btn-danger btn-sm rounded-pill shadow-sm">
                                        <i class="bi bi-trash"></i> Eliminar
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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

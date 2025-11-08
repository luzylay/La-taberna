<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión - Categorías</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- BARRA LATERAL -->
        <button class="btn btn-dark d-md-none mb-3" type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#sidebarMenu"
                aria-controls="sidebarMenu">
            <i class="bi bi-list"></i> Menú
        </button>
        <div class="offcanvas offcanvas-start d-md-none bg-dark" tabindex="-1" id="sidebarMenu">
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

        <!-- CONTENIDO -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
                <div class="text-center flex-grow-1 mb-3">
                    <h1 class="fw-bold mb-1"><i class="bi bi-tags-fill me-2"></i>Gestión de Categorías</h1>
                    <hr class="w-25 mx-auto border-2 border-primary">
                </div>
                <a href="/gestion/categoria/NuevaCategoria"
                   class="btn btn-success btn-lg rounded-pill shadow-sm mb-3">
                    <i class="bi bi-plus-circle me-2"></i> Agregar Categoría
                </a>
            </div>

            <!-- Tarjetas -->
            <div class="row g-4">
                <c:forEach var="c" items="${categorias}">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                        <div class="card shadow-lg border-0 rounded-4 h-100 d-flex flex-column p-3">

                            <!-- Cabecera -->
                            <div class="d-flex justify-content-between mb-3 row p-1 g-1">
                                <span class="badge bg-secondary">ID: ${c.id_categoria}</span>
                                <span class="badge ${c.activo_cate ? 'bg-success' : 'bg-danger'}">
                        ${c.activo_cate ? 'Activo' : 'Inactivo'}
                    </span>
                            </div>

                            <!-- Contenido -->
                            <div class="d-flex align-items-start mb-3 p-2 rounded-4" style="background-color: #e0d8c5;">
                                <!-- Icono -->
                                <div class="me-3 d-flex align-items-center justify-content-center"
                                     style="font-size: 3rem; width: 50px; height: 50px;">
                                    <i class="bi bi-folder-fill"></i>
                                </div>
                                <!-- Texto -->
                                <div class="flex-grow-1">
                                    <h5 class="fw-bold mb-1 text-truncate">${c.nombre_cate}</h5>
                                    <p class="text-muted mb-0" style="font-size: 0.9rem; line-height: 1.2;">
                                        ${c.descrip_cate}
                                    </p>
                                </div>
                            </div>

                            <!-- Btns -->
                            <div class="d-flex justify-content-between mt-auto">
                                <a href="/gestion/categoria/editar/${c.id_categoria}"
                                   class="btn btn-warning btn-sm rounded-pill shadow-sm px-3">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
                                </a>

                                <form action="/gestion/categoria/eliminarCategoria" method="post"
                                      onsubmit="return confirm('¿Estás seguro de eliminar esta categoría?');">
                                    <input type="hidden" name="id_categoria" value="${c.id_categoria}">
                                    <button type="submit" class="btn btn-danger btn-sm rounded-pill shadow-sm px-3">
                                        <i class="bi bi-trash me-1"></i> Eliminar
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
                alert("Se agregó una categoría correctamente :D");
            </c:when>
            <c:when test="${verificar == 2}">
                alert("Se editó una categoría correctamente :D");
            </c:when>
            <c:when test="${verificar == 3}">
                alert("Se eliminó una categoría correctamente :D");
            </c:when>
            <c:otherwise>
                alert("La operación no se pudo realizar D:");
            </c:otherwise>
        </c:choose>
    </script>
</c:if>

<footer class="bg-dark text-white text-center py-3 mt-4">
    <div>© 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i> Derechos reservados</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

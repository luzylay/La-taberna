<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión - Categorias</title>
        <link rel="stylesheet" href="css/gestion-css.css">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <script type="text/javascript"
            src="https://www.gstatic.com/charts/loader.js"></script>

        <link rel="icon" type="image/png"
            href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">
    </head>
    <body>

        <div class="container-fluid">
            <div class="row">

                <!-- BARRITA LATERAL :D ----------------------------------------------------------->
                <!-- Botón para móviles -->
                <button class="btn btn-dark d-md-none mb-3" type="button"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#sidebarMenu"
                    aria-controls="sidebarMenu" style="border-radius: 0px;">
                    <i class="bi bi-list"></i> Menú
                </button>
                <div
                    class="offcanvas offcanvas-start d-md-none bg-dark bg-opacity-90"
                    tabindex="-1"
                    id="sidebarMenu" aria-labelledby="sidebarLabel">
                    <div class="offcanvas-header">
                        <button type="button" class="btn-close text-reset"
                            data-bs-dismiss="offcanvas"
                            aria-label="Cerrar"></button>
                    </div>
                    <div class="offcanvas-body p-0">
                        <jsp:include page="gestion-panel-lateral.jsp" />
                    </div>
                </div>
                <!-- SOLO APARECE SI ES PANTALLA GRANDE -->
                <div class="d-none d-md-block col-md-2 p-0 vh-100">
                    <jsp:include page="gestion-panel-lateral.jsp" />
                </div>
                <!-- FIN BARRITA LATAREAL :D ----------------------------------------------------------->

                <!-- CRUD DE CATEGORIAS -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 min-vh-100">
                    <!-- Encabezado -->
                    <div class="d-flex justify-content-between align-items-center mt-4 mb-3">
                        <div class="titulo-panel text-center flex-grow-1 mb-5 mt-3">
                            <h1 class="fw-bold mb-0">
                                <i class="bi bi-tags-fill me-2"></i> Gestión de Categorías
                            </h1>
                        </div>

                        <!-- Btn Agregar -->
                        <a href="/gestion/categoria/NuevaCategoria"
                           class="btn btn-success btn-lg shadow-sm"
                           style="border-radius: 50px; transition: all 0.3s;">
                            <i class="bi bi-plus-circle me-2"></i> Agregar Categoría
                        </a>
                    </div>

                    <!-- Tarjetas -->
                    <div class="row g-4">
                        <c:forEach var="c" items="${categorias}">
                            <div class="col-sm-6 col-md-4 col-lg-3">
                                <div class="card shadow border-0 rounded-4 h-100 p-3 "
                                     style="transition: all 0.3s ease;">
                                    <!-- Encabezado de la tarjeta-->
                                    <!-- ID -->
                                    <span class="badge bg-dark bg-opacity-75 mb-1 d-block">ID: ${c.id_categoria}</span>
                                    <div class="d-flex align-items-center badge bg-primary bg-opacity-75 mb-1">
                                        <div class="d-flex justify-content-center align-items-center"
                                             style="width: 50px; height: 50px;">
                                            <i class="bi bi-folder-fill fs-4"></i>
                                        </div>
                                        <h5 class="mb-0 fw-bold text-truncate">${c.nombre_cate}</h5>
                                    </div>

                                    <!-- Descrip -->
                                    <p class="text-muted small mb-4 mt-3">
                                        ${c.descrip_cate}
                                    </p>

                                    <!-- Acciones -->
                                    <div class="mt-auto d-flex justify-content-between">
                                        <!-- Btn Editar -->
                                        <a href="/gestion/categoria/editar/${c.id_categoria}"
                                           class="btn btn-warning btn-sm rounded-pill shadow-sm px-3">
                                            <i class="bi bi-pencil-square me-1"></i> Editar
                                        </a>

                                        <!-- Btn Eliminar -->
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

        <!--Fotter-->
        <footer class="bg-dark text-white text-center py-2">
            <div>© 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i>
                Derechos reservados</div>
        </footer>

        <script type="text/javascript" src="js/gestion-graficos.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
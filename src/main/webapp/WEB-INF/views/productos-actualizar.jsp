<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión</title>
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

                <!-- TODO EL MAIN ES EL APARTADO DE ACTUALIZACION -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 min-vh-100">
                    <h1 class="mt-4 mb-4 text-center p-3">Actualizar
                        Productos</h1>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <!-- <thead> se usa para el encabezado de columnas, sin ella no lo reconoce el bootstrap-->
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Imagen</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Categoría</th>
                                    <th>Año</th>
                                    <th>Precio</th>
                                    <th>Stock</th>

                                    <th>Editar</th>
                                </tr>
                            </thead>
                            <tbody>

                                <c:forEach var="p" items="${productos}">
                                    <tr>
                                        <!--ID-->
                                        <td>${p.id_producto}</td>
                                        <!-- IMAGEN-->
                                        <td>
                                            <img src="${p.url_pro}"
                                                alt="ID: ${p.id_producto} - P: ${p.nombre_pro}"
                                                width="50" height="50"
                                                class="rounded">
                                        </td>
                                        <!-- NOMBRE PRODUCTO-->
                                        <td>${p.nombre_pro}</td>
                                        <!-- DESCRIPCIÓN-->
                                        <td>${p.descrip_pro}</td>
                                        <!-- CATEGORÍA -->
                                        <td>${p.categoria_pro.nombre_cate}</td>
                                        <!-- AÑO -->
                                        <td>${p.anio_pro}</td>
                                        <!-- PRECIO -->
                                        <td>${precio_pro}</td>
                                        <!-- STOCK -->
                                        <td>${p.stock_pro}</td>
                                        <td>
                                           <a href="/gestion/productos/editar/${p.id_producto}" class="btn btn-warning btn-sm btn-editar">
                                               <i class="bi bi-pencil-square me-2"></i>Editar
                                           </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
        <script>
            <c:if test="${not empty verifarEdit}">
                alert("Producto Actualizado Correctamente! :D")
            </c:if>
        </script>

        <footer class="bg-dark text-white text-center py-2">
            <div>© 2025 - Panel de Gestión | <i
                    class="bi bi-shield-lock"></i>
                Derechos reservados</div>
        </footer>

        <script type="text/javascript"
            src="js/gestion-graficos.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

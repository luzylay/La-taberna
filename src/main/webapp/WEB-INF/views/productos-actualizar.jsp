<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/5186/5186031.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- 🔹 Barra lateral -->
        <div class="d-none d-md-block col-md-2 p-0 vh-100 bg-dark text-white">
            <jsp:include page="gestion-panel-lateral.jsp" />
        </div>

        <!-- 🔹 Contenido principal -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 min-vh-100">
            <h1 class="mt-3 mb-4 text-center fw-bold border-bottom border-dark pb-2">
                <i class="bi bi-box-seam me-2"></i>Gestión de Productos
            </h1>

            <!-- 🔍 Filtro o búsqueda -->
            <div class="input-group mb-4 shadow-sm">
                <span class="input-group-text bg-dark text-white"><i class="bi bi-search"></i></span>
                <input type="text" id="buscarProducto" class="form-control" placeholder="Buscar producto...">
            </div>

            <!-- 🧱 Listado de productos -->
            <div class="row g-4" id="contenedorProductos">
                <c:forEach var="p" items="${productos}">
                    <div class="col-sm-6 col-md-4 col-lg-3 producto-card">
                        <div class="card shadow border-0 rounded-4 h-100 overflow-hidden" style="transition: all 0.3s ease;">

                            <!-- Imagen -->
                            <div class="position-relative">
                                <img src="${p.url_pro}" class="card-img-top" alt="${p.nombre_pro}" style="height: 180px; object-fit: cover;">
                                <span class="badge position-absolute top-0 start-0 bg-dark bg-opacity-75 rounded-end px-3 py-1">
                                    ID: ${p.id_producto}
                                </span>
                            </div>

                            <!-- Contenido -->
                            <div class="card-body d-flex flex-column">
                                <h5 class="fw-bold text-truncate mb-2">${p.nombre_pro}</h5>
                                <p class="text-muted small flex-grow-1">${p.descrip_pro}</p>

                                <ul class="list-unstyled small mb-3">
                                    <li><i class="bi bi-tags me-2 text-secondary"></i><strong>Categoría:</strong> ${p.categoria_pro.nombre_cate}</li>
                                    <li><i class="bi bi-calendar3 me-2 text-secondary"></i><strong>Año:</strong> ${p.anio_pro}</li>
                                    <li><i class="bi bi-cash-coin me-2 text-success"></i><strong>Precio:</strong> S/${p.precio_pro}</li>
                                    <li><i class="bi bi-box2 me-2 text-primary"></i><strong>Stock:</strong> ${p.stock_pro}</li>
                                </ul>

                                <!-- Botones de acción -->
                                <div class="d-flex justify-content-between mt-auto">
                                    <!-- Editar -->
                                    <a href="/gestion/productos/editar/${p.id_producto}"
                                       class="btn btn-warning btn-sm rounded-pill shadow-sm px-3">
                                        <i class="bi bi-pencil-square me-1"></i>Editar
                                    </a>

                                    <!-- Eliminar -->
                                    <form action="/gestion/productos/eliminarProducto" method="post"
                                          onsubmit="return confirm('¿Seguro que deseas eliminar este producto?');">
                                        <input type="hidden" name="id_producto" value="${p.id_producto}">
                                        <button type="submit"
                                                class="btn btn-danger btn-sm rounded-pill shadow-sm px-3">
                                            <i class="bi bi-trash me-1"></i>Eliminar
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</div>

<footer class="bg-dark text-white text-center py-2 mt-4">
    <div>© 2025 - Panel de Gestión | <i class="bi bi-shield-lock"></i> Derechos reservados</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 🔍 Pequeño script para filtrar productos -->
<script>
    const inputBuscar = document.getElementById("buscarProducto");
    const cards = document.querySelectorAll(".producto-card");

    inputBuscar.addEventListener("input", () => {
        const texto = inputBuscar.value.toLowerCase();
        cards.forEach(card => {
            const nombre = card.querySelector("h5").textContent.toLowerCase();
            card.style.display = nombre.includes(texto) ? "" : "none";
        });
    });
</script>

</body>
</html>

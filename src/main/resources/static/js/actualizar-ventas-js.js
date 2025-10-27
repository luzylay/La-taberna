document.addEventListener('DOMContentLoaded', () => {
    const modalProductos = document.getElementById('modalProductos');
    const tablaProductos = document.querySelector('#tablaModalProductos tbody');
    const tablaPrincipal = document.querySelector('#tablaDetalles');

    // Cargar productos desde el backend
    function cargarProductos() {
        fetch('/api/productos/todos-productos')
            .then(res => res.json())
            .then(data => {
                tablaProductos.innerHTML = '';
                data.forEach(producto => {
                    const fila = document.createElement('tr');
                    fila.innerHTML = `
                        <td><img src="${producto.url_pro || 'https://via.placeholder.com/60'}" style="width:60px;height:60px;object-fit:cover;"></td>
                        <td class="fw-semibold">${producto.nombre_pro || 'Sin nombre'}</td>
                        <td>
                            <div style="display:flex; justify-content:flex-end; gap:0;">
                                <span style="font-weight:500;">S/</span>
                                <span style="text-align:right; width:50px; padding:0; margin:0;">${(producto.precio_pro ?? 0).toFixed(2)}</span>
                            </div>
                        </td>
                        <td class="text-center">
                            <button type="button" class="btn btn-primary btn-sm agregarProductoBtn"><i class="bi bi-plus-lg"></i></button>
                        </td>
                    `;
                    fila.querySelector('.agregarProductoBtn').addEventListener('click', () => {
                        agregarProductoTablaPrincipal(producto);
                        bootstrap.Modal.getInstance(modalProductos).hide();
                    });
                    tablaProductos.appendChild(fila);
                });
            });
    }

    // Agregar producto a la tabla
    function agregarProductoTablaPrincipal(producto) {
        const fila = document.createElement('tr');
        fila.innerHTML = `
            <td><img src="${producto.url_pro || ''}" style="width:60px;height:60px;object-fit:cover;"></td>
            <td><input type="number" name="cantidades[]" value="1" min="1" class="form-control text-center" style="max-width:55px;"></td>
            <td>
                <div style="display:flex; justify-content:flex-end; gap:0;">
                    <span style="font-weight:500;">S/</span>
                    <input type="text"value="${(producto.precio_pro ?? 0).toFixed(2)}" readonly style="background:transparent; border:none; text-align:right; width:35px; padding:0; margin:0;">
                </div>
            </td>
            <td>
                <div style="display:flex; justify-content:flex-end; gap:0;">
                    <span style="font-weight:500;">S/</span>
                    <input type="text" value="${(producto.precio_pro ?? 0).toFixed(2)}" readonly style="background:transparent; border:none; text-align:right; width:50px; padding:0; margin:0;">
                </div>
            </td>
            <td style="display: none;">
                <input type="hidden" class="id_producto" name="id_producto[]" value="${producto.id_producto}">
            </td>
            <td class="text-center"><button type="button" class="btn btn-danger btn-sm eliminarFila"><i class="bi bi-trash"></i></button></td>
        `;
        tablaPrincipal.appendChild(fila);
        actualizarSubtotal(fila);
    }


    function actualizarSubtotal(fila) {
        const cantidad = parseFloat(fila.querySelector('input[name="cantidades[]"]').value) || 0;
        const precio = parseFloat(fila.querySelector('input[name="precios[]"]').value) || 0;
        fila.querySelector('input[name="subtotales[]"]').value = (cantidad * precio).toFixed(2);
    }

    tablaPrincipal.addEventListener('input', e => {
        if (e.target.name === 'cantidades[]') {
            actualizarSubtotal(e.target.closest('tr'));
        }
    });

    tablaPrincipal.addEventListener('click', e => {
        if (e.target.closest('.eliminarFila')) {
            e.target.closest('tr').remove();
        }
    });

    // Cargar productos al abrir el modal
    modalProductos.addEventListener('show.bs.modal', cargarProductos);
});

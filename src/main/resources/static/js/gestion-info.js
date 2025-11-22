document.addEventListener("DOMContentLoaded", () => {
    // 1. Cargamos Google Charts
    google.charts.load("current", {
        packages: ["corechart"]
    });

    // 2. Cuando cargue, renderizamos
    google.charts.setOnLoadCallback(renderizarGraficos);

    // 3. Cargamos los números de arriba
    cargarKPIs();
});

// --- CARGAR TARJETAS SUPERIORES ---
function cargarKPIs() {
    const llenar = (id, url, esDinero) => {
        fetch(url)
            .then(r => r.json())
            .then(data => {
                const num = data ? parseFloat(data) : 0;
                document.getElementById(id).innerText = num.toLocaleString("es-PE", {
                    minimumFractionDigits: esDinero ? 2 : 0,
                    maximumFractionDigits: esDinero ? 2 : 0
                });
            })
            .catch(e => console.error("Error KPI:", e));
    };

    llenar("total_venta", "/api/ventas/total-ventas", true);
    llenar("promedio", "/api/ventas/promedio-por-ticket", true);
    llenar("cant_users", "/api/usuarios/total-usuarios", false);
}

// --- DIBUJAR GRÁFICOS ---
function renderizarGraficos() {
    // Opciones comunes para que todos se vean iguales (Estilo)
    const opcionesBase = {
        legend: {
            position: 'none'
        }, // Sin leyenda para ahorrar espacio
        chartArea: {
            width: '85%',
            height: '70%', // Menos altura del dibujo para dar espacio al texto abajo
            top: 30
        },
        hAxis: {
            textStyle: {
                fontSize: 11,
                color: '#666'
            },
            slantedText: false, // INTENTA NO INCLINAR (Horizontal)
            maxAlternation: 1, // Si no caben, oculta uno sí y uno no (mejor que inclinar)
            showTextEvery: 1 // Intenta mostrar todos
        },
        vAxis: {
            textStyle: {
                color: '#999'
            },
            gridlines: {
                color: '#f0f0f0'
            },
            minValue: 0
        },
        animation: {
            startup: true,
            duration: 1000,
            easing: 'out'
        }
    };

    // Función reutilizable para dibujar
    const crearGrafico = (idDiv, tipoGrafico, urlApi, color, titulo, ejeX, ejeY) => {
        fetch(urlApi).then(r => r.json()).then(data => {
            // 1. Preparar datos
            const tabla = [
                [ejeX, ejeY]
            ];

            if (Array.isArray(data)) {
                data.forEach(item => tabla.push([item.mes, item.valor]));
            } else {
                for (let key in data) tabla.push([key, data[key]]);
            }

            // 2. Configurar opciones específicas
            const opciones = {
                ...opcionesBase,
                title: titulo,
                colors: [color]
            };

            // Detalles bonitos para líneas y áreas
            if (tipoGrafico === 'LineChart' || tipoGrafico === 'AreaChart') {
                opciones.pointSize = 7; // Puntos visibles
                opciones.lineWidth = 3; // Línea gordita
                if (tipoGrafico === 'AreaChart') opciones.areaOpacity = 0.1;
            }

            // 3. Dibujar
            const chart = new google.visualization[tipoGrafico](document.getElementById(idDiv));
            const dataTable = google.visualization.arrayToDataTable(tabla);
            chart.draw(dataTable, opciones);

            // 4. Hacemos que se redibuje si cambias el tamaño de la ventana
            window.addEventListener('resize', () => {
                chart.draw(dataTable, opciones);
            });
        });
    };

    // --- LLAMADAS A LOS GRÁFICOS (Orden 2x2) ---

    // Fila 1, Izquierda: Ventas (Área - Azul)
    crearGrafico("chart3", "AreaChart", "/api/ventas/venta-por-mes", "#0d6efd", "Evolución de Ventas (S/.)", "Mes", "Venta");

    // Fila 1, Derecha: Ticket Promedio (Àrea - Verde)
    crearGrafico("chart2", "AreaChart", "/api/ventas/promedio-ticket-mensual", "#198754", "Ticket Promedio", "Mes", "Promedio");

    // Fila 2, Izquierda: Cantidad Productos (Barra - Azul Claro)
    crearGrafico("chart1", "ColumnChart", "/api/ventas/cantidad-productos-por-mes", "#6610f2", "Volumen de Productos", "Mes", "Cant");

    // Fila 2, Derecha: Transacciones (Barra - Gris)
    crearGrafico("chart4", "ColumnChart", "/api/ventas/cant-ventas-por-mes", "#6c757d", "Total Transacciones", "Mes", "Ops");
}
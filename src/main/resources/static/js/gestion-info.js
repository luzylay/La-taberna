// =======================
// PANELES
// =======================
function generarPanelitos() {
    crearPanelito("/api/productos/promedio-por-ticket", "promedio");
    crearPanelito("/api/productos/total-usuarios", "cant_users");
    crearPanelito("/api/productos/total-ventas", "total_venta");
}

function crearPanelito(dataURL, div_contenedor) {
    fetch(dataURL)
        .then(rpta => rpta.json())
        .then(data => {
            const numero = parseFloat(data);

            const formateado = numero.toLocaleString("es-PE", {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });

            document.getElementById(div_contenedor).textContent = formateado;

            console.log("Panelito generado :D");
        })
        .catch(error => {
            console.log("Error capturado al crear panelito");
            console.error("Error generado", error);
        });
}

// =======================
// GRAFICOS
// =======================
function crearGraficos() {

    function dibujarGrafico(tipoGrafico, detallesGrafico, dataURL, Valor1, Valor2, div_contenedor) {
        fetch(dataURL)
            .then(rpta => rpta.json())
            .then(data => {
                let dataGrafico = [[Valor1, Valor2]]; // encabezados
                for (const key in data) {
                    dataGrafico.push([key, data[key]]);
                }

                let dataTransformada = google.visualization.arrayToDataTable(dataGrafico);

                if (!google.visualization[tipoGrafico]) {
                    throw new Error("Tipo de gráfico no válido D:");
                }

                let graficoGenerado = new google.visualization[tipoGrafico](
                    document.getElementById(div_contenedor)
                );

                graficoGenerado.draw(dataTransformada, detallesGrafico);

                window.addEventListener('resize', () => {
                    graficoGenerado.draw(dataTransformada, detallesGrafico);
                });

                console.log(`Gráfico "${div_contenedor}" generado :D`);
            })
            .catch(error => {
                console.log("Error capturado al crear gráfico");
                console.error("Error generado", error);
            });
    }

    // Grafico #1: Top 10 productos más vendidos
    dibujarGrafico(
        "ColumnChart",
        {
            title: "Top 10 Productos Más Vendidos",
            legend: { position: "none" },
            chartArea: { width: "75%", left: 100, height: "80%" },
            annotations: { alwaysOutside: true, textStyle: { fontSize: 12 } }
        },
        "/api/productos/top-10-vendidos",
        "Producto",
        "Cantidad Vendida",
        "chart1"
    );

    // Grafico #2: Top 10 productos con mayor stock
    dibujarGrafico(
        "ColumnChart",
        {
            title: "Top 10 Productos con Mayor Stock",
            legend: { position: "none" },
            chartArea: { width: "75%", left: 100, height: "80%" },
            annotations: { alwaysOutside: true, textStyle: { fontSize: 12 } }
        },
        "/api/productos/top-10-stock-alto",
        "Producto",
        "Stock",
        "chart2"
    );

    // Grafico #3: Ventas mensuales
    dibujarGrafico(
        "ComboChart",
        {
            title: "Ventas Mensuales",
            legend: { position: "bottom" },
            chartArea: { width: "75%", left: 100, height: "80%" },
            annotations: { alwaysOutside: true, textStyle: { fontSize: 12 } }
        },
        "/api/productos/por-mes",
        "Mes",
        "Se vendió: S/",
        "chart3"
    );

    // Grafico #4: Ventas por categoría
    dibujarGrafico(
        "BarChart",
        {
            title: "Ventas por Categoría (S/)",
            legend: { position: "none" },
            chartArea: { width: "75%", left: 100, height: "80%" },
            vAxis: { textStyle: { fontSize: 12 } },
            hAxis: { title: "Monto Total (S/.)" }
        },
        "/api/productos/por-categoria",
        "Categoría",
        "Monto (S/.)",
        "chart4"
    );
}

// =======================
// EJECUTAR
// =======================
document.addEventListener("DOMContentLoaded", () => {
    generarPanelitos();

    google.charts.load("current", {
        packages: ["corechart", "bar", "line", "table"]
    });
    google.charts.setOnLoadCallback(crearGraficos);
});

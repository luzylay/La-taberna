//Esto sirve para cargar los graficos, de momento estaticos D:
google.charts.load("current", {
    packages: ["corechart", "bar", "line", "table"],
});
google.charts.setOnLoadCallback(drawCharts);

//Este metodo se encarga de darle valor y graficar los graficos
function drawCharts() {
  // Chart1
    var data1 = google.visualization.arrayToDataTable([
        ["Mes", "Ventas"],
        ["Enero", 1000],
        ["Febrero", 1170],
        ["Marzo", 660],
        ["Abril", 1030],
    ]);

    var chart1 = new google.visualization.LineChart(
        document.getElementById("chart1")
    );

    chart1.draw(data1, {
        title: "Ventas Mensuales",
        legend: { position: "bottom" },
        colors: ["#007bff"],
    });

  // Chart2
    var data2 = google.visualization.arrayToDataTable([
        ["Mes", "Usuarios"],
        ["Enero", 50],
        ["Febrero", 60],
        ["Marzo", 45],
        ["Abril", 70],
    ]);

    var chart2 = new google.visualization.ColumnChart(
        document.getElementById("chart2")
    );

    chart2.draw(data2, { title: "Usuarios por Mes", colors: ["#28a745"] });

    // Chart3
    var data3 = google.visualization.arrayToDataTable([
        ["Producto", "Cantidad"],
        ["Vino Tinto", 10],
        ["Vino Blanco", 8],
        ["Rosado", 7],
    ]);
    var chart3 = new google.visualization.PieChart(
        document.getElementById("chart3")
    );
    chart3.draw(data3, {
        title: "Distribución de Productos",
        colors: ["#ffc107", "#17a2b8", "#fd7e14"],
    });

    // Chart4
    var data4 = google.visualization.arrayToDataTable([
        ["Mes", "Ingresos"],
        ["Enero", 5000],
        ["Febrero", 7000],
        ["Marzo", 4500],
        ["Abril", 8000],
    ]);

    var chart4 = new google.visualization.AreaChart(
        document.getElementById("chart4")
    );

    chart4.draw(data4, { title: "Ingresos Mensuales", colors: ["#6f42c1"] });

    // Chart5
    var data5 = google.visualization.arrayToDataTable([
        ["Región", "Ventas"],
        ["Lima", 30],
        ["Arequipa", 20],
        ["Cusco", 15],
        ["Trujillo", 10],
    ]);

    var chart5 = new google.visualization.BarChart(
        document.getElementById("chart5")
    );

    chart5.draw(data5, { title: "Ventas por Región", colors: ["#dc3545"] });
}

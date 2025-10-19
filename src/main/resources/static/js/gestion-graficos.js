// Carga de paquetes
google.charts.load("current", {
    packages: ["corechart", "bar", "line", "table"],
});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {
    drawChart1();
    drawChart2();
    drawChart3();
    drawChart4();
    drawChart5();
}

// Chart 1: Ventas Mensuales
function drawChart1(){
    fetch("/api/productos/por-mes")
        .then(rpta => rpta.json())
        .then(data => {
            var data1 = [["Mes", "Ventas"]];
            for (const mes in data) {
                data1.push([mes, data[mes]]);
            }

            var dataCheck1 = google.visualization.arrayToDataTable(data1);

            var chart1 = new google.visualization.LineChart(
                document.getElementById("chart1")
            );

            var options1 = {
                title: "Ventas Mensuales",
                legend: { position: "bottom" },
                colors: ["#007bff"],
                chartArea: { width: "90%", height: "70%" },
            };

            chart1.draw(dataCheck1, options1);

            window.addEventListener("resize", function () {
                chart1.draw(dataCheck1, options1);
            });
        })
        .catch(error => console.error("Error al cargar datos:", error));
}


// Chart 2: Usuarios por Mes
function drawChart2() {
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

    var options2 = {
        title: "Usuarios por Mes",
        colors: ["#28a745"],
        chartArea: { width: "90%", height: "70%" },
    };

    chart2.draw(data2, options2);

    window.addEventListener("resize", function () {
        chart2.draw(data2, options2);
    });
}

// Chart 3: Por Categoría
function drawChart3() {
    fetch("/api/productos/por-categoria")
        .then(rpta => rpta.json())
        .then(data => {
            var data3 = [["Categoría", "Ventas"]];
            for (const categoria in data) {
                data3.push([categoria, data[categoria]]);
            }

            var dataCheck3 = google.visualization.arrayToDataTable(data3);

            var chart3 = new google.visualization.PieChart(
                document.getElementById("chart3")
            );

            var options3 = {
                title: "Ventas Por Categoría",
                legend: { position: "bottom" },
                colors: ["#007bff", "#28a745", "#ffc107", "#dc3545", "#6f42c1"],
                chartArea: { width: "90%", height: "70%" },
            };

            chart3.draw(dataCheck3, options3);

            window.addEventListener("resize", function () {
                chart3.draw(dataCheck3, options3);
            });
        })
        .catch(error => console.error("Error al cargar datos:", error));
}

// Chart 4: Ingresos Mensuales
function drawChart4() {
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

    var options4 = {
        title: "Ingresos Mensuales",
        colors: ["#6f42c1"],
        chartArea: { width: "90%", height: "70%" },
    };

    chart4.draw(data4, options4);

    window.addEventListener("resize", function () {
        chart4.draw(data4, options4);
    });
}

// Chart 5: Ventas por Región
function drawChart5() {
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

    var options5 = {
        title: "Ventas por Región",
        colors: ["#dc3545"],
        chartArea: { width: "90%", height: "70%" },
    };

    chart5.draw(data5, options5);

    window.addEventListener("resize", function () {
        chart5.draw(data5, options5);
    });
}
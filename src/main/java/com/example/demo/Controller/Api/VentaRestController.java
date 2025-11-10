package com.example.demo.Controller.Api;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Venta;
import com.example.demo.Service.CategoriaService;
import com.example.demo.Service.DetalleVentaService;
import com.example.demo.Service.VentaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/ventas")
public class VentaRestController {
    private VentaService ventaService;
    private DetalleVentaService detalleVentaService;
    private CategoriaService categoriaService;

    public VentaRestController(VentaService ventaService,
                               DetalleVentaService detalleVentaService,
                               CategoriaService categoriaService) {
        this.ventaService = ventaService;
        this.detalleVentaService = detalleVentaService;
        this.categoriaService = categoriaService;
    }

    @GetMapping("/total-ventas")
    public double totalVentas() {
        List<Venta> ventas = ventaService.obtenerVentasActivas();
        if (ventas.isEmpty()) return 0;

        return ventas.stream()
                .mapToDouble(Venta::getTotal_venta)
                .sum();
    }

    @GetMapping("/promedio-por-ticket")
    public double promedioPorTicket() {
        List<Venta> ventas = ventaService.obtenerVentasActivas();
        if (ventas.isEmpty()) {
            return 0.0;
        }
        double total = ventas.stream()
                .mapToDouble(Venta::getTotal_venta)
                .sum();
        return total / ventas.size();
    }

    @GetMapping("/top-10-vendidos")
    public Map<String, Integer> top10MasVendidos() {

        Map<String, Integer> filtro1 = new LinkedHashMap<>();
        filtro1 = detalleVentaService.obtenerDetalles()
                .stream()
                .collect(Collectors.groupingBy(
                        d -> d.getProducto().getNombre_pro(),
                        Collectors.summingInt(DetalleVenta::getCantidad_det)
                ));

        Map<String, Integer> datos = new LinkedHashMap<>();

        datos = filtro1
                .entrySet()
                .stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(10)
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (a, b) -> a,
                        LinkedHashMap::new
                ));
        return datos;
    }

    @GetMapping("/venta-por-categoria")
    public Map<String, Double> pasterDash() {
        Map<String, Double> grafico = new LinkedHashMap<>();

        categoriaService.obtenerCategorias()
                .forEach(c -> {
                    grafico.put(
                            c.getNombre_cate(),
                            ventaService.ventasPorCategoria(c.getId_categoria())
                                    .stream()
                                    .mapToDouble(DetalleVenta::getSubtotal_det)
                                    .sum()
                    );
                });
        return grafico;
    }

    @GetMapping("/venta-por-mes")
    public Map<String, Double> lineDash() {

        Map<String, Double> graficoDeLineas = new LinkedHashMap<>();

        String[] meses = {
                "Enero", "Febrero", "Marzo", "Abril",
                "Mayo", "Junio", "Julio", "Agosto",
                "Septiembre", "Octubre", "Noviembre", "Diciembre"
        };

        int nroMes = LocalDate.now().getMonthValue();

        for (int i = 0; i < nroMes; i++) {
            double monto = Optional.ofNullable(ventaService.montoTotalDeMes(i + 1)).orElse(0.0);
            graficoDeLineas.put(meses[i], monto);
        }

        return graficoDeLineas;
    }
}

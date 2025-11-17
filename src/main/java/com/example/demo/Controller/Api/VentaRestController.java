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
import java.time.YearMonth;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/ventas")
public class VentaRestController {

    private final VentaService ventaService;
    private final DetalleVentaService detalleVentaService;
    private final CategoriaService categoriaService;

    private final String[] meses = {
            "Enero", "Febrero", "Marzo", "Abril",
            "Mayo", "Junio", "Julio", "Agosto",
            "Septiembre", "Octubre", "Noviembre", "Diciembre"
    };

    private final int nroMes = LocalDate.now().getMonthValue();

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
        if (ventas.isEmpty()) return 0.0;

        double total = ventas.stream()
                .mapToDouble(Venta::getTotal_venta)
                .sum();

        return total / ventas.size();
    }

    @GetMapping("/cantidad-productos-por-mes")
    public Map<String, Integer> cantidadVendidaPorMes() {

        Map<String, Integer> resultado = new LinkedHashMap<>();

        for (int i = 0; i < nroMes; i++) {

            int cantidad = ventaService.obtenerVentasPorMes(i + 1)
                    .stream()
                    .flatMap(venta -> venta.getDetalles_Venta().stream())
                    .mapToInt(DetalleVenta::getCantidad_det)
                    .sum();

            resultado.put(meses[i], cantidad);
        }

        return resultado;
    }

    @GetMapping("/promedio-ticket-mensual")
    public Map<String, Double> promedioTicketMensaul() {

        Map<String, Double> resultado = new LinkedHashMap<>();

        for (int i = 0; i < nroMes; i++) {

            List<Venta> ventasDelMes = ventaService.obtenerVentasPorMes(i + 1);

            double promedioMensual =
                    ventasDelMes.stream()
                            .mapToDouble(Venta::getTotal_venta)
                            .average()
                            .orElse(0.0);

            promedioMensual = Math.round(promedioMensual * 100.0) / 100.0;


            resultado.put(meses[i], promedioMensual);
        }

        return resultado;
    }



    @GetMapping("/cant-ventas-por-mes")
    public Map<String, Integer> pasterDash() {

        Map<String, Integer> grafico = new LinkedHashMap<>();

        for (int i = 0; i < nroMes; i++) {
            grafico.put(
                    meses[i],
                    ventaService.obtenerVentasPorMes(i + 1).size()
            );
        }

        return grafico;
    }

    @GetMapping("/venta-por-mes")
    public Map<String, Double> lineDash() {

        Map<String, Double> graficoDeLineas = new LinkedHashMap<>();

        for (int i = 0; i < nroMes; i++) {
            double monto = Optional.ofNullable(
                    ventaService.montoTotalDeMes(i + 1)
            ).orElse(0.0);

            graficoDeLineas.put(meses[i], monto);
        }

        return graficoDeLineas;
    }
}
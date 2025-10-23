package com.example.demo.Controller.Api;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Producto;
import com.example.demo.Model.Usuario;
import com.example.demo.Model.Venta;
import com.example.demo.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/productos")
public class ProductosRestController {

    private VentaService ventaService;
    private ProductoService productoService;
    private CategoriaService categoriaService;
    private DetalleVentaService detalleVentaService;
    private UsuarioService usuarioService;

    @Autowired
    public ProductosRestController(
            VentaService ventaService,
            ProductoService productoService,
            CategoriaService categoriaService,
            DetalleVentaService detalleVentaService,
            UsuarioService usuarioService
    ){
        this.ventaService = ventaService;
        this.productoService = productoService;
        this.categoriaService = categoriaService;
        this.detalleVentaService = detalleVentaService;
        this.usuarioService = usuarioService;
    }


    @GetMapping("/por-mes")
    public Map<String,Double> LineDash(){

        Map<String, Double> graficoDeLineas =  new LinkedHashMap<>();

        graficoDeLineas.put("Enero", ventaService.montoTotalDeMes(1));
        graficoDeLineas.put("Febrero", ventaService.montoTotalDeMes(2));
        graficoDeLineas.put("Marzo", ventaService.montoTotalDeMes(3));
        graficoDeLineas.put("Abril", ventaService.montoTotalDeMes(4));
        graficoDeLineas.put("Mayo", ventaService.montoTotalDeMes(5));
        graficoDeLineas.put("Junio", ventaService.montoTotalDeMes(6));
        graficoDeLineas.put("Julio", ventaService.montoTotalDeMes(7));
        graficoDeLineas.put("Agosto", ventaService.montoTotalDeMes(8));
        graficoDeLineas.put("Septiembre", ventaService.montoTotalDeMes(9));
        graficoDeLineas.put("Octubre", ventaService.montoTotalDeMes(10));
        graficoDeLineas.put("Noviembre", ventaService.montoTotalDeMes(11));
        graficoDeLineas.put("Diciembre", ventaService.montoTotalDeMes(12));

        return graficoDeLineas;
    }

    @GetMapping("/por-categoria")
    public Map<String,Double> pasterDash() {
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
    };

    @GetMapping("/top-10-vendidos")
    public Map<String,Integer> top10MasVendidos(){

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

    @GetMapping("/top-10-stock-alto")
    public Map<String,Integer> top10StockAlto(){

        Map<String, Integer> filtro1 = new LinkedHashMap<>();
        filtro1 = productoService.getTodosLosProductos()
                .stream()
                .collect(Collectors.groupingBy(
                        p -> p.getNombre_pro(),
                        Collectors.summingInt(Producto::getStock_pro)
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

    @GetMapping("/promedio-por-ticket")
    public double promedioPorTicket() {
        List<Venta> ventas = ventaService.obtenerVentas();
        if (ventas.isEmpty()) {
            return 0.0;
        }
        double total = ventas.stream()
                .mapToDouble(Venta::getTotal_venta)
                .sum();
        return total / ventas.size();
    }


    @GetMapping("/total-usuarios")
    public int totalUsuarios() {
        List<Usuario> usuarios = usuarioService.obtenerUsuarios();
        if (usuarios.isEmpty()) return 0;
        return usuarios.size();
    }

    @GetMapping("/total-ventas")
    public double totalVentas() {
        List<Venta> ventas = ventaService.obtenerVentas();
        if (ventas.isEmpty()) return 0;

        return ventas.stream()
                .mapToDouble(Venta::getTotal_venta)
                .sum();
    }
}

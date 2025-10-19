package com.example.demo.Controller.Api;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Service.CategoriaService;
import com.example.demo.Service.ProductoService;
import com.example.demo.Service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/productos")
public class ProductosRestController {

    private VentaService ventaService;
    private ProductoService productoService;
    private CategoriaService categoriaService;

    @Autowired
    public ProductosRestController(
            VentaService ventaService,
            ProductoService productoService,
            CategoriaService categoriaService
    ){
        this.ventaService = ventaService;
        this.productoService = productoService;
        this.categoriaService = categoriaService;
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
        Map<String, Double> graficoDePastel = new LinkedHashMap<>();

        categoriaService.obtenerCategorias()
                .forEach(c -> {
                    graficoDePastel.put(
                            c.getNombre_cate(),
                            ventaService.ventasPorCategoria(c.getId_categoria())
                                    .stream()
                                    .mapToDouble(DetalleVenta::getSubtotal_det)
                                    .sum()
                    );
                });
        return graficoDePastel;
    };

}

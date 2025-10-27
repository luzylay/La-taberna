package com.example.demo.Controller.Web;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Venta;
import com.example.demo.Service.VentaService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.Service.DetalleVentaService;
import com.example.demo.Service.ProductoService;

@Controller
@RequestMapping("/gestion/ventas")
public class VentaController {

    private VentaService ventaService;
    private ProductoService productoService;
    private DetalleVentaService detalleVentaService;

    @Autowired
    public VentaController(
            VentaService ventaService,
            ProductoService productoService,
            DetalleVentaService detalleVentaService) {
        this.ventaService = ventaService;
        this.productoService = productoService;
        this.detalleVentaService = detalleVentaService;
    }

    @GetMapping
    public String showSellPage(
            Model model) {
        List<Venta> ventas = ventaService.obtenerVentas();
        model.addAttribute("ventas", ventas);

        return "gestion-ventas";
    }

    @GetMapping("/editar/{id}")
    public String showAddSellPage(@PathVariable Integer id, Model model) {

        Venta venta = ventaService.obtenerVentaPorId(id);

        model.addAttribute("venta", venta);
        model.addAttribute("productoEditado", new Venta());

        return "ventas-actualizar";
    }

    @PostMapping("/actualizarVenta")
    public String actualizarVenta(
            @RequestParam("id_venta") Integer id_venta,
            @RequestParam("id_producto") List<Integer> productos,
            @RequestParam("cantidades") List<Integer> cantidades) {

        detalleVentaService.eliminarDetallesVenta(id_venta);

        Venta venta = ventaService.obtenerVentaPorId(id_venta);

        List<DetalleVenta> detalles = new ArrayList<>();

        for (int i = 0; i < productos.size(); i++) {
            DetalleVenta d = new DetalleVenta();
            d.setVenta(venta);
            d.setProducto(productoService.getProductoPorId(productos.get(i)));
            d.setCantidad_det(cantidades.get(i));

            detalles.add(d);
        }

        venta.setDetalles_Venta(detalles);
        ventaService.actualizarVenta(venta);


        return "redirect:/gestion/ventas";
    }
}
package com.example.demo.Controller.Web;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Producto;
import com.example.demo.Model.Venta;
import com.example.demo.Service.DetalleVentaService;
import com.example.demo.Service.ProductoService;
import com.example.demo.Service.VentaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
@RequestMapping("/carrito")
public class CarritoController {

    private ProductoService productoService;
    private VentaService ventaService;
    private DetalleVentaService detalleVentaService;

    @Autowired
    public CarritoController(
            ProductoService productoService,
            VentaService ventaService,
            DetalleVentaService detalleVentaService,
            HttpSession session){
        this.ventaService = ventaService;
        this.productoService = productoService;
        this.detalleVentaService = detalleVentaService;
    }

    @GetMapping
    public String showBuyPage(
            Model model,
            HttpSession session
            ) {
        Venta ventaActiva = (Venta) session.getAttribute("ventaActiva");
        ventaActiva.establecerTotal_venta();
        model.addAttribute("venta",ventaActiva);
        return "/carrito";
    }

    @PostMapping("/agregarProducto")
    public String agregarAlCarrito(
            @RequestParam(required = true) Integer id_producto,
            @RequestParam(required = true) Integer cantidad,
            HttpSession session
    ){
        Producto producto = productoService.getProductoPorId(id_producto);
        DetalleVenta detalle = new DetalleVenta();
        detalle.setProducto(producto);
        detalle.setCantidad_det(cantidad);
        detalle.establecerSubtotal_det();
        Venta ventaActiva = (Venta) session.getAttribute("ventaActiva");

        if (ventaActiva == null){
            return "redirect:/";
        }
        ventaActiva.getDetalles_Venta().add(detalle);
        return "redirect:/carrito";
    }

    @PostMapping("/finalizar")
    public String finalizarCompra(HttpSession session) {
        Venta ventaActiva = (Venta) session.getAttribute("ventaActiva");

        if (ventaActiva == null || ventaActiva.getDetalles_Venta().isEmpty()) {
            return "redirect:/carrito";
        }

        int id_venta = ventaService.guardarVenta(ventaActiva);
        ventaActiva.setId_venta(id_venta);
        ventaActiva.getDetalles_Venta()
                .forEach(d->{
                    d.setVenta(ventaActiva);
                    detalleVentaService.agregarDetalleVenta(d);
                });

        Venta nuevaVenta = new Venta();
        nuevaVenta.setId_usuario(ventaActiva.getId_usuario());
        nuevaVenta.setDetalles_Venta(new ArrayList<>());

        session.setAttribute("ventaActiva", nuevaVenta);

        return "redirect:/carrito";
    }
}

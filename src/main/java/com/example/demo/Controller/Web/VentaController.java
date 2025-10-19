package com.example.demo.Controller.Web;

import com.example.demo.Model.Venta;
import com.example.demo.Service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/gestion/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @GetMapping
    public String showSellPage(Model model) {
        List<Venta> ventas = ventaService.obtenerVentas();
        model.addAttribute("ventas",ventas);

        return "gestion-ventas";
    }
}

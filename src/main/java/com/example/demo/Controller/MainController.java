package com.example.demo.Controller;

import com.example.demo.Model.Producto;
import com.example.demo.Service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MainController {

    @Autowired
    private ProductoService productoService;

    @GetMapping("/")
    public String redirectToMain(Model model) {
        List<Producto> productos = productoService.getTodosLosProductos();
        model.addAttribute("listaProductos", productos);
        return "main";
    }
//
//    @GetMapping("/productos")
//    public String showProductCatalog() {
//        return "/productos";
//    }

    @GetMapping("/publicidad")
    public String showPublicityPage() {
        return "/publicidad";
    }

    @GetMapping("/perfil")
    public String showPerfil() {
        return "/perfil";
    }

    @GetMapping("/contacto")
    public String showContactPage() {
        return "/contacto";
    }

    @GetMapping("/gestion")
    public String showManagementPage() {
        return "/gestion";
    }

    @GetMapping("/nosotros")
    public String showAboutUsPage() {
        return "/nosotros";
    }
}

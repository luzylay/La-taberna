package com.example.demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LicoreriaWebController {

    // Usa "forward:" para servir archivos estáticos desde static/
    @GetMapping("/")
    public String redirectToMain() {
        return "forward:/main.html"; // ✅ Con "forward:"
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "forward:/login.html"; // ✅ Con "forward:"
    }

    @GetMapping("/main")
    public String showMainPage() {
        return "forward:/main.html";
    }

    @GetMapping("/productos")
    public String showProductsList() {
        return "forward:/lista_productos.html";
    }

    @GetMapping("/catalogo")
    public String showProductCatalog() {
        return "forward:/catalogo_productos.html";
    }

    @GetMapping("/publicidad")
    public String showPublicityPage() {
        return "forward:/publicidad.html";
    }

    @GetMapping("/crear-producto")
    public String showCreateProductPage() {
        return "forward:/crear_producto.html";
    }

    @GetMapping("/contacto")
    public String showContactPage() {
        return "forward:/contacto.html";
    }

    @GetMapping("/gestion")
    public String showManagementPage() {
        return "forward:/gestion.html";
    }

    // Métricas
    @GetMapping("/reportes/ventas")
    public String showSalesReports() {
        return "forward:/reporte_ventas.html";
    }

    @GetMapping("/reportes/stock")
    public String showStockReports() {
        return "forward:/reporte_stock.html";
    }

    @GetMapping("/reportes/clientes")
    public String showClientReports() {
        return "forward:/reporte_clientes.html";
    }

    // Páginas adicionales
    @GetMapping("/nosotros")
    public String showAboutUsPage() {
        return "forward:/nosotros.html";
    }

    @GetMapping("/historia")
    public String showHistoryPage() {
        return "forward:/historia.html";
    }

    @GetMapping("/eventos")
    public String showEventsPage() {
        return "forward:/eventos.html";
    }
}
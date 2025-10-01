package com.example.demo.Controller;

import com.example.demo.Model.Producto;
import com.example.demo.Service.CategoriaService;
import com.example.demo.Service.Impl.ProductoServiceImpl;
import com.example.demo.Service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/productos")
public class ProductoController {

    private final ProductoService productoService;
    private final CategoriaService categoriaService;

    @Autowired
    public ProductoController(ProductoServiceImpl productoServiceImpl, CategoriaService categoriaService) {
        this.productoService = productoServiceImpl;
        this.categoriaService = categoriaService;
    }

    @GetMapping
    public String listarProductos(@RequestParam(name = "page", defaultValue = "1") int paginaActual,
                                  @RequestParam(name = "nombre", required = false) String nombreFiltro,
                                  @RequestParam(name = "categoria", required = false) String categoriaFiltro,
                                  Model model) {

        int productosPorPagina = 16;

        List<Producto> productos = productoService.getProductosFiltrados(paginaActual, productosPorPagina, nombreFiltro, categoriaFiltro);
        int totalProductos = productoService.getProductCountFiltered(nombreFiltro, categoriaFiltro);
        int totalDePaginas = (int) Math.ceil((double) totalProductos / productosPorPagina);

        model.addAttribute("listaProductos", productos);
        model.addAttribute("paginaActual", paginaActual);
        model.addAttribute("totalDePaginas", totalDePaginas);
        model.addAttribute("nombreFiltro", nombreFiltro != null ? nombreFiltro : "");
        model.addAttribute("categoriaFiltro", categoriaFiltro != null ? categoriaFiltro : "");

        return "productos";
    }

}
package com.example.demo.Controller;

import com.example.demo.Model.Categoria;
import com.example.demo.Model.Producto;
import com.example.demo.Service.CategoriaService;
import com.example.demo.Service.DetalleVentaService;
import com.example.demo.Service.Impl.ProductoServiceImpl;
import com.example.demo.Service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/gestion/productos")
public class GestionController {

    private final ProductoService productoService;
    private final CategoriaService categoriaService;
    private final DetalleVentaService detalleVentaService;


    @Autowired
    public GestionController(ProductoServiceImpl productoServiceImpl, CategoriaService categoriaService, DetalleVentaService detalleVentaService){
        this.productoService = productoServiceImpl;
        this.categoriaService = categoriaService;
        this.detalleVentaService = detalleVentaService;
    }

    @GetMapping("/NuevoProducto")
    public String showCreateProductPage(Model model) {
        List<Categoria> categorias = categoriaService.obtenerCategorias();
        model.addAttribute("categorias", categorias);
        model.addAttribute("nuevoProducto", new Producto());
        return "productos-agregar"; // JSP
    }

    // EDITAR
    @GetMapping("/editar/{id}")
    public String obtenerProducto(@PathVariable Integer id, Model model) {
        Producto producto = productoService.getProductoPorId(id);
        List<Categoria> categorias = categoriaService.obtenerCategorias();

        model.addAttribute("producto", producto);
        model.addAttribute("categorias", categorias);
        model.addAttribute("productoEditado",new Producto());

        return "molde-editar";
    }

    @GetMapping("/actualizar")
    public String showUpdateProducts(Model model) {
        List<Producto> productos = productoService.getTodosLosProductos();
        model.addAttribute("productos", productos);
        return "productos-actualizar";
    }

    @GetMapping("/eliminar")
    public String showDeleteProductPage(Model model) {
        List<Producto> productos = productoService.getTodosLosProductos();
        model.addAttribute("productos", productos);
        return "productos-eliminar";
    }


    // GUARDAR - GUARDAR NUEVO
    @PostMapping("/guardar")
    public String guardarProducto(@ModelAttribute Producto producto,
                                  RedirectAttributes redirigir) {
        Categoria c = categoriaService.obtenerCategoriaPorId(producto.getCategoria_pro().getId_categoria());
        producto.setCategoria_pro(c);
        productoService.agregarProducto(producto);

        redirigir.addFlashAttribute("verificar", true);
        return "redirect:/gestion/productos/NuevoProducto";
    }

    // EDITAR - GUARDAR CAMBIOS
    @PostMapping("/aplicarEdicion")
    public String editarProducto(@ModelAttribute Producto producto,
                                 RedirectAttributes redirigir) {
        Categoria c = categoriaService.obtenerCategoriaPorId(producto.getCategoria_pro().getId_categoria());
        producto.setCategoria_pro(c);
        productoService.actualizarProducto(producto);

        redirigir.addFlashAttribute("verificarEdit", true);
        return "redirect:/gestion/productos/actualizar";
    }

    // ELIMINAR - ELIMINAR PRODCUTO
    @PostMapping("/eliminarProducto")
    public String eliminarProducto(@RequestParam Integer id_producto,RedirectAttributes redirigir){
        detalleVentaService.eliminarDetallePorProducto(id_producto);
        productoService.eliminarProducto(id_producto);
        redirigir.addFlashAttribute("verificarDelete", true);
        return "redirect:/gestion/productos/eliminar";
    }
}
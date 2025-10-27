package com.example.demo.Controller.Web;

import com.example.demo.Model.Usuario;
import com.example.demo.Model.Venta;
import com.example.demo.Service.UsuarioService;
import com.example.demo.Service.VentaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/gestion/usuarios")
public class UsuarioController {

    private UsuarioService usuarioService;
    private VentaService ventaService;
    @Autowired
    public UsuarioController(
            UsuarioService usuarioService,
            VentaService ventaService){
        this.usuarioService = usuarioService;
        this.ventaService = ventaService;
    }

    @GetMapping
    public String showViewUsers(Model model){
        List<Usuario> listaUsuarios = usuarioService.obtenerUsuarios();
        model.addAttribute("usuarios",listaUsuarios);
        return "gestion-usuarios";
    }

}

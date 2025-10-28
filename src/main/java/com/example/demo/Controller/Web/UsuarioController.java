package com.example.demo.Controller.Web;

import com.example.demo.Model.*;
import com.example.demo.Service.TipoUsuarioService;
import com.example.demo.Service.UsuarioService;
import com.example.demo.Service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/gestion/usuarios")
public class UsuarioController {

    private UsuarioService usuarioService;
    private VentaService ventaService;
    private TipoUsuarioService tipoUsuarioService;
    @Autowired
    public UsuarioController(
            UsuarioService usuarioService,
            VentaService ventaService,
            TipoUsuarioService tipoUsuarioService){
        this.usuarioService = usuarioService;
        this.ventaService = ventaService;
        this.tipoUsuarioService = tipoUsuarioService;
    }

    @GetMapping
    public String showViewUsers(Model model){
        List<Usuario> listaUsuarios = usuarioService.obtenerUsuarios();
        System.out.println(listaUsuarios);
        model.addAttribute("usuarios",listaUsuarios);
        return "gestion-usuarios";
    }

    @GetMapping("/editar/{id}")
    public String editarUsuario(@PathVariable Integer id, Model model) {
        Usuario user = usuarioService.obtenerUsuarioPorId(id);
        List<TipoUsuario> tipoUsuarios = tipoUsuarioService.obtenerTiposUsuario();

        model.addAttribute("usuario", user);
        model.addAttribute("tipos", tipoUsuarios);
        model.addAttribute("usuarioEditado", new Usuario());

        return "usuarios-actualizar";
    }

}

package com.example.demo.Controller.Web;

import com.example.demo.Model.Venta;
import com.example.demo.Service.VentaService;
import com.example.demo.Tools.ReportesVentaPDF;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/gestion/reportes")
@RestController
public class ReportesController {

    @Autowired
    private VentaService ventaService;

    @GetMapping("/generarBoleta/{id_venta}")
    public void generarBoleta(
            @PathVariable Integer id_venta,
            HttpServletResponse response) {
        try {
            // Respuesta
            response.setContentType(MediaType.APPLICATION_PDF_VALUE);
            response.setHeader(HttpHeaders.CONTENT_DISPOSITION,
                    "attachment; filename=boleta_" + id_venta + ".pdf");

            // Obtener datos
            Venta venta = ventaService.obtenerVentaPorId(id_venta);

            // Generar PDF
            ReportesVentaPDF.generarBoleta(venta, response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar PDF");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}

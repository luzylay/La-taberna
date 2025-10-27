package com.example.demo.Model;

import java.time.LocalDateTime;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Builder
@AllArgsConstructor
@Data
@NoArgsConstructor
public class Venta {

    @Id
    private int id_venta;
    private LocalDateTime fecha_venta;
    private Usuario id_usuario;
    private double total_venta;
    private List<DetalleVenta> detalles_Venta;

    @Override
    public String toString() {
        return "Venta{" +
                "id_venta=" + id_venta +
                ", fecha_venta='" + fecha_venta + '\'' +
                ", id_usuario=" + id_usuario +
                ", total_venta=" + total_venta +
                ", detalles_Venta=" + detalles_Venta +
                '}';
    }

    public String getFechaFormateada() {
        if (fecha_venta == null) {
            return "";
        }
        DateTimeFormatter f = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return fecha_venta.format(f);
    }

    public void establecerTotal_venta() {
        this.total_venta = detalles_Venta.stream()
                .mapToDouble(DetalleVenta::getSubtotal_det)
                .sum();
    }
}

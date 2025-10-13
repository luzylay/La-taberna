package com.example.demo.Service.Impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.Venta;
import com.example.demo.Repository.DAO.VentaDAO;
import com.example.demo.Service.VentaService;

@Service
public class VentaServiceImpl implements VentaService {

    private final VentaDAO ventaDAO;

    @Autowired
    public VentaServiceImpl(VentaDAO ventaDAO) {
        this.ventaDAO = ventaDAO;
    }

    @Override
    public List<Venta> obtenerVentas() {
        return ventaDAO.obtenerVentas();
    }

    @Override
    public Venta obtenerVentaPorId(int id) {
        return ventaDAO.obtenerVentaPorId(id);
    }

    @Override
    public void guardarVenta(Venta venta) {
        // Aquí podrías añadir lógica de negocio antes de guardar
        ventaDAO.guardarVenta(venta);
    }

    @Override
    public void actualizarVenta(Venta venta) {
        if (ventaDAO.existeVenta(venta.getId_venta())) {
            ventaDAO.actualizarVenta(venta);
        } else {
            throw new RuntimeException("No se puede actualizar. La venta con ID " + venta.getId_venta() + " no existe.");
        }
    }

    @Override
    public void eliminarVenta(int id) {
        if (ventaDAO.existeVenta(id)) {
            ventaDAO.eliminarVenta(id);
        } else {
            throw new RuntimeException("No se puede eliminar. La venta con ID " + id + " no existe.");
        }
    }

    @Override
    public boolean existeVenta(int id) {
        return ventaDAO.existeVenta(id);
    }

    @Override
    public List<Venta> obtenerVentasPorUsuario(int idUsuario) {
        return ventaDAO.obtenerVentasPorUsuario(idUsuario);
    }

    @Override
    public List<Venta> obtenerVentasPorFecha(LocalDateTime inicio, LocalDateTime fin) {
        return ventaDAO.obtenerVentasPorFecha(inicio, fin);
    }
}

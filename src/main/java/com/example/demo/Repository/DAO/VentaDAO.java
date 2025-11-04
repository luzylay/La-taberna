package com.example.demo.Repository.DAO;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.List;

import com.example.demo.Repository.VentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.Venta;

@Repository
public class VentaDAO implements VentaRepository {
    
    private JdbcTemplate jdbcTemplate;
    private UsuarioDAO usuarioDAO;
    private DetalleVentaDAO detalleVentaDAO;

    @Autowired
    public VentaDAO(JdbcTemplate jdbcTemplate, UsuarioDAO usuarioDAO, DetalleVentaDAO detalleVentaDAO) {
        this.jdbcTemplate = jdbcTemplate;
        this.usuarioDAO = usuarioDAO;
        this.detalleVentaDAO = detalleVentaDAO;
    }

    public List<Venta> obtenerVentas() {
        String sql = "SELECT * FROM Venta";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Venta venta = new Venta();
            venta.setId_venta(rs.getInt("id_venta"));
            venta.setFecha_venta(rs.getTimestamp("fecha_venta").toLocalDateTime());
            venta.setId_usuario(usuarioDAO.obtenerUsuarioPorId(rs.getInt("id_usuario")));
            venta.setTotal_venta(rs.getDouble("total_venta"));
            venta.setDetalles_Venta(detalleVentaDAO.obtenerDetallesPorVenta(venta.getId_venta()));
            return venta;
        });
    }

    public Venta obtenerVentaPorId(int id) {
        String sql = "SELECT * FROM Venta WHERE id_venta = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, rowNum) -> {
            Venta venta = new Venta();
            venta.setId_venta(rs.getInt("id_venta"));
            venta.setFecha_venta(rs.getTimestamp("fecha_venta").toLocalDateTime());
            venta.setId_usuario(usuarioDAO.obtenerUsuarioPorId(rs.getInt("id_usuario")));
            venta.setTotal_venta(rs.getDouble("total_venta"));
            venta.setDetalles_Venta(detalleVentaDAO.obtenerDetallesPorVenta(venta.getId_venta()));
            return venta;
        });
    }

    public int guardarVenta(Venta venta) {
        String sql = "INSERT INTO Venta (id_usuario, total_venta) VALUES (?, ?)";

        //Este objeto se encaraga de capturar el id generado por la venta ingresada
        KeyHolder keyHolder = new GeneratedKeyHolder();

        //Al ejecutar el script sql si le pasamos el Keyholder se le asigna el valor
        //El Statment.Return_generated_keys indica que debe hacerlo
        jdbcTemplate.update(c -> {
            PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, venta.getId_usuario().getId_usuario());
            ps.setDouble(2, venta.getTotal_venta());
            return ps;
        }, keyHolder);

        //KeyHolder almacena el numerico como un Number, por eso se parsea
        Number idGenerado = (Number) keyHolder.getKeys().get("id_venta");

        //Se parsea al tipo de dato necesario mientras sea numerico
        venta.setId_venta(idGenerado.intValue());
        return venta.getId_venta();
    }

    public void actualizarVenta(Venta venta) {
        String sql = "UPDATE Venta SET fecha_venta = ?, id_usuario = ?, total_venta = ? WHERE id_venta = ?";

        if (venta.getDetalles_Venta() != null) {
            venta.getDetalles_Venta().forEach(d -> {
                d.establecerSubtotal_det();
                detalleVentaDAO.agregarDetalleVenta(d);
            });
        }
        venta.establecerTotal_venta();
        jdbcTemplate.update(sql, venta.getFecha_venta(),venta.getId_usuario().getId_usuario(), venta.getTotal_venta(), venta.getId_venta());
    }


    public void eliminarVenta(int id) {
        String sql = "DELETE FROM Venta WHERE id_venta = ?";
        jdbcTemplate.update(sql, id);
    }

    public boolean existeVenta(int id) {
        String sql = "SELECT COUNT(*) FROM Venta WHERE id_venta = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{id}, Integer.class);
        return count != null && count > 0;
    }

    public List<Venta> obtenerVentasPorUsuario(int idUsuario) {
        String sql = "SELECT * FROM Venta WHERE id_usuario = ?";
        return jdbcTemplate.query(sql,new Object[]{idUsuario}, (rs, rowNum) -> {
            Venta venta = new Venta();
            venta.setId_venta(rs.getInt("id_venta"));
            venta.setFecha_venta(rs.getTimestamp("fecha_venta").toLocalDateTime());
            venta.setId_usuario(usuarioDAO.obtenerUsuarioPorId(rs.getInt("id_usuario")));
            venta.setTotal_venta(rs.getDouble("total_venta"));
            venta.setDetalles_Venta(detalleVentaDAO.obtenerDetallesPorVenta(venta.getId_venta()));
            return venta;
        });
    }

    public List<Venta> obtenerVentasPorFecha(LocalDateTime inicio, LocalDateTime fin) {
        String sql = "SELECT * FROM Venta WHERE fecha_venta BETWEEN ? AND ?";
        return jdbcTemplate.query(sql, new Object[]{inicio, fin}, (rs, rowNum) -> {
            Venta venta = new Venta();
            venta.setId_venta(rs.getInt("id_venta"));
            venta.setFecha_venta(rs.getTimestamp("fecha_venta").toLocalDateTime());
            venta.setId_usuario(usuarioDAO.obtenerUsuarioPorId(rs.getInt("id_usuario")));
            venta.setTotal_venta(rs.getDouble("total_venta"));
            venta.setDetalles_Venta(detalleVentaDAO.obtenerDetallesPorVenta(venta.getId_venta()));
            return venta;
        });
    }
}
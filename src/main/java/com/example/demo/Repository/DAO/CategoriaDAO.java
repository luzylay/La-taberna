package com.example.demo.Repository.DAO;

import java.util.List;

import com.example.demo.Model.Categoria;
import com.example.demo.Repository.CategoriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CategoriaDAO implements CategoriaRepository {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public CategoriaDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Categoria> obtenerCategorias() {
        String sql = "SELECT * FROM Categoria WHERE estado_cate = TRUE";

        return jdbcTemplate.query(sql, (rs, i) -> {
            Categoria c = new Categoria();
            c.setId_categoria(rs.getInt("id_categoria"));
            c.setNombre_cate(rs.getString("nombre_cate"));
            c.setDescrip_cate(rs.getString("descrip_cate"));
            c.setActivo_cate(rs.getBoolean("estado_cate"));
            return c;
        });
    }

    @Override
    public Categoria obtenerCategoriaPorId(int id) {
        String sql = "SELECT * FROM Categoria WHERE id_categoria = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, i) -> {
            Categoria c = new Categoria();
            c.setId_categoria(rs.getInt("id_categoria"));
            c.setNombre_cate(rs.getString("nombre_cate"));
            c.setDescrip_cate(rs.getString("descrip_cate"));
            c.setActivo_cate(rs.getBoolean("estado_cate"));
            return c;
        });
    }

    @Override
    public int agregarCategoria(Categoria categoria) {
        String sql = "INSERT INTO Categoria (nombre_cate, descrip_cate, estado_cate) VALUES (?, ?, TRUE)";
        return jdbcTemplate.update(sql, categoria.getNombre_cate(), categoria.getDescrip_cate());
    }

    @Override
    public int actualizarCategoria(Categoria categoria) {
        String sql = "UPDATE Categoria SET nombre_cate = ?, descrip_cate = ?, estado_cate = ? WHERE id_categoria = ?";
        return jdbcTemplate.update(sql,
                categoria.getNombre_cate(),
                categoria.getDescrip_cate(),
                true,
                categoria.getId_categoria());
    }

    @Override
    public int eliminarCategoria(int id) {
        String sql = "UPDATE Categoria SET estado_cate = FALSE WHERE id_categoria = ?";
        return jdbcTemplate.update(sql, id);
    }

    public int activarCategoria(int id) {
        String sql = "UPDATE Categoria SET estado_cate = TRUE WHERE id_categoria = ?";
        return jdbcTemplate.update(sql, id);
    }

    @Override
    public boolean existeId(int id) {
        String sql = "SELECT COUNT(*) FROM Categoria WHERE id_categoria = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{id}, Integer.class);
        return count != null && count > 0;
    }
}

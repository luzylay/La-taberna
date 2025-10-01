package com.example.demo.Repository;

import java.util.List;
import com.example.demo.Model.Categoria;

public interface CategoriaRepository {

    List<Categoria> obtenerCategorias();

    Categoria obtenerCategoriaPorId(int id);

    int agregarCategoria(Categoria categoria);

    int actualizarCategoria(Categoria categoria);

    int eliminarCategoria(int id);

    boolean existeId(int id);
}
package com.example.demo.TestServices;

import com.example.demo.Service.VentaService;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class TestVentaService {

    @Autowired
    private VentaService ventaService;

    @Test

    public void devolverUltimoID(){
    }
}

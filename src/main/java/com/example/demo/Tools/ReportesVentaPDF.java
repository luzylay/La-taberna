package com.example.demo.Tools;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Venta;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.OutputStream;

public class ReportesVentaPDF {

    public static void generarBoleta(Venta venta, OutputStream puntoSalida) throws Exception {
        //Creando documento
        Document pdf = new Document(PageSize.A4, 36, 36, 54, 36);
        PdfWriter.getInstance(pdf, puntoSalida);
        pdf.open();

        // Fuentes
        Font fuenteTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
        Font fuenteEncabezado = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font fuenteContenido = new Font(Font.FontFamily.HELVETICA, 12);

        //Titulo
        Paragraph titulo = new Paragraph("BOLETA DE VENTA", fuenteTitulo);
        titulo.setAlignment(Element.ALIGN_CENTER);
        titulo.setSpacingAfter(20);
        pdf.add(titulo);

        //Tabla
        PdfPTable tablaDetalles = new PdfPTable(6);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(new float[]{0.7f, 2.5f, 4f, 1.5f, 1f, 2f});
        tablaDetalles.setSpacingBefore(10f);

        //Encabezados
        String[] encabezados = {"ID", "Nombre", "Descripción", "Precio U.", "Cantidad", "Subtotal"};
        for (String cabeza : encabezados) {
            tablaDetalles.addCell(crearCelda(cabeza, fuenteEncabezado, Element.ALIGN_CENTER));
        }

        //Contenido de la tabla
        for (DetalleVenta detalle : venta.getDetalles_Venta()) {
            tablaDetalles.addCell(crearCelda(String.valueOf(detalle.getProducto().getId_producto()), fuenteContenido, Element.ALIGN_CENTER));
            tablaDetalles.addCell(crearCelda(detalle.getProducto().getNombre_pro(), fuenteContenido, Element.ALIGN_LEFT));
            tablaDetalles.addCell(crearCelda(detalle.getProducto().getDescrip_pro(), fuenteContenido, Element.ALIGN_LEFT));
            tablaDetalles.addCell(crearCelda(formatearMoneda(detalle.getProducto().getPrecio_pro()), fuenteContenido, Element.ALIGN_RIGHT));
            tablaDetalles.addCell(crearCelda(String.valueOf(detalle.getCantidad_det()), fuenteContenido, Element.ALIGN_CENTER));
            tablaDetalles.addCell(crearCelda(formatearMoneda(detalle.getSubtotal_det()), fuenteContenido, Element.ALIGN_RIGHT));
        }

        pdf.add(tablaDetalles);
        pdf.close();
    }

    private static PdfPCell crearCelda(String texto, Font fuente, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setPadding(4f);
        return celda;
    }

    private static String formatearMoneda(double valor) {
        return String.format("S/. %.2f", valor);
    }
}

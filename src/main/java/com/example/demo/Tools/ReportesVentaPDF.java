package com.example.demo.Tools;

import com.example.demo.Model.DetalleVenta;
import com.example.demo.Model.Usuario;
import com.example.demo.Model.Venta;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.OutputStream;

public class ReportesVentaPDF {

    public static void generarBoleta(Venta venta, OutputStream puntoSalida) throws Exception {
        venta.establecerTotal_venta();

        // Creando documento
        Document pdf = new Document(PageSize.A4, 36, 36, 54, 36);
        PdfWriter.getInstance(pdf, puntoSalida);
        pdf.open();

        Font fuenteTitulo = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Font fuenteEncabezado = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);
        Font fuenteContenido = new Font(Font.FontFamily.HELVETICA, 10);

        //ENCABEZADO
        PdfPTable tablaEncabezado = new PdfPTable(2); // 2 columnas: logo y datos
        tablaEncabezado.setWidthPercentage(100);
        tablaEncabezado.setWidths(new float[]{2f, 5f});

        //Logo
        Image logo = Image.getInstance("https://static.vecteezy.com/system/resources/previews/036/331/638/original/bottle-of-wine-icon-png.png");
        logo.scaleAbsolute(60, 60);
        PdfPCell celdaLogo = new PdfPCell(logo, false);
        celdaLogo.setBorder(PdfPCell.NO_BORDER);
        celdaLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celdaLogo.setPaddingRight(10f);
        tablaEncabezado.addCell(celdaLogo);

        //Info
        PdfPTable tablaDatosEncabezado = new PdfPTable(1);
        tablaDatosEncabezado.setWidthPercentage(100);

        PdfPCell celdaRUC = new PdfPCell(new Phrase("RUC: 10777944890", fuenteEncabezado));
        celdaRUC.setBorder(PdfPCell.NO_BORDER);
        celdaRUC.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tablaDatosEncabezado.addCell(celdaRUC);

        PdfPCell celdaBoleta = new PdfPCell(new Phrase("BOLETA DE VENTA", new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD)));
        celdaBoleta.setBorder(PdfPCell.NO_BORDER);
        celdaBoleta.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tablaDatosEncabezado.addCell(celdaBoleta);

        String correlativo = String.format("N°%08d", venta.getId_venta());
        PdfPCell celdaCorrelativo = new PdfPCell(new Phrase(correlativo, fuenteContenido));
        celdaCorrelativo.setBorder(PdfPCell.NO_BORDER);
        celdaCorrelativo.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tablaDatosEncabezado.addCell(celdaCorrelativo);

        PdfPCell celdaDatosEncabezado = new PdfPCell(tablaDatosEncabezado);
        celdaDatosEncabezado.setBorder(PdfPCell.NO_BORDER);
        tablaEncabezado.addCell(celdaDatosEncabezado);

        pdf.add(tablaEncabezado);
        pdf.add(Chunk.NEWLINE);

        //TABLA PRINCIPAL
        PdfPTable tablaPrincipal = new PdfPTable(1);
        tablaPrincipal.setWidthPercentage(100);

        //Tabla de detalles
        PdfPTable tablaDetalles = new PdfPTable(6);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(new float[]{0.7f, 2.5f, 4f, 1.5f, 1f, 2f});

        //Encabezados detalles
        String[] encabezadosDetalle = {"ID", "Nombre", "Descripción", "Precio U.", "Cant.", "Subtotal"};
        for (String cabeza : encabezadosDetalle) {
            PdfPCell celdaEnc = crearCeldaBordesSupInf(cabeza, fuenteEncabezado, Element.ALIGN_CENTER);
            celdaEnc.setBackgroundColor(BaseColor.LIGHT_GRAY);
            tablaDetalles.addCell(celdaEnc);
        }

        //Tabla datos generales
        PdfPTable tablaDatosGenerales = new PdfPTable(2);
        tablaDatosGenerales.setWidthPercentage(70);
        tablaDatosGenerales.setWidths(new float[]{3f, 7f});

        tablaDatosGenerales.addCell(crearCeldaSinBordes("Fecha de Emisión: ", fuenteEncabezado, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes(venta.getFechaFormateada(), fuenteContenido, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes("ID Cliente: ", fuenteEncabezado, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes(String.valueOf(venta.getId_usuario().getId_usuario()), fuenteContenido, Element.ALIGN_LEFT));

        Usuario user = venta.getId_usuario();
        String nombreCompleto = user.getApaterno_user() + " " + user.getAmaterno_user() + " " + user.getNombre_user();
        tablaDatosGenerales.addCell(crearCeldaSinBordes("Cliente: ", fuenteEncabezado, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes(nombreCompleto, fuenteContenido, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes("Teléfono: ", fuenteEncabezado, Element.ALIGN_LEFT));
        tablaDatosGenerales.addCell(crearCeldaSinBordes(venta.getId_usuario().getTelefono_user(), fuenteContenido, Element.ALIGN_LEFT));

        PdfPCell cellContenedorDatoGenerales = new PdfPCell(tablaDatosGenerales);
        cellContenedorDatoGenerales.setBorderWidthBottom(1);
        cellContenedorDatoGenerales.setPaddingTop(6f);
        cellContenedorDatoGenerales.setPaddingBottom(6f);
        cellContenedorDatoGenerales.setPaddingLeft(4f);
        cellContenedorDatoGenerales.setPaddingRight(4f);

        // DETALLES DE COMPRA
        for (DetalleVenta detalle : venta.getDetalles_Venta()) {
            tablaDetalles.addCell(crearCeldaBordesLaterales(String.valueOf(detalle.getProducto().getId_producto()), fuenteContenido, Element.ALIGN_CENTER));
            tablaDetalles.addCell(crearCeldaSinBordes(detalle.getProducto().getNombre_pro(), fuenteContenido, Element.ALIGN_LEFT));
            tablaDetalles.addCell(crearCeldaSinBordes(detalle.getProducto().getDescrip_pro(), fuenteContenido, Element.ALIGN_LEFT));
            tablaDetalles.addCell(crearCeldaSinBordes(formatearMoneda(detalle.getProducto().getPrecio_pro()), fuenteContenido, Element.ALIGN_RIGHT));
            tablaDetalles.addCell(crearCeldaSinBordes(String.valueOf(detalle.getCantidad_det()), fuenteContenido, Element.ALIGN_CENTER));
            tablaDetalles.addCell(crearCeldaBordesLaterales(formatearMoneda(detalle.getSubtotal_det()), fuenteContenido, Element.ALIGN_CENTER));
        }

        PdfPCell cellContenedorDetalles = new PdfPCell(tablaDetalles);
        cellContenedorDetalles.setBorderWidthBottom(1);
        cellContenedorDetalles.setPadding(0f);

        // Espacio entre tablas
        PdfPCell celdaEspacio = new PdfPCell(new Paragraph(" "));
        celdaEspacio.setBorder(PdfPCell.NO_BORDER);
        celdaEspacio.setFixedHeight(8f);

        // TABLA RESUMEN
        PdfPTable tablaResumen = new PdfPTable(2);
        tablaResumen.setWidthPercentage(40f);
        tablaResumen.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tablaResumen.setSpacingBefore(8f);
        tablaResumen.setWidths(new float[]{2f, 1f});

        double costoBruto = venta.getTotal_venta() - venta.getTotal_venta()*0.18;
        double igv = venta.getTotal_venta()*0.18;
        double total = venta.getTotal_venta();

        tablaResumen.addCell(crearCeldaSinBordes("Costo Bruto:", fuenteContenido, Element.ALIGN_LEFT));
        tablaResumen.addCell(crearCeldaSinBordes(formatearMoneda(costoBruto), fuenteContenido, Element.ALIGN_RIGHT));
        tablaResumen.addCell(crearCeldaSinBordes("IGV (18%):", fuenteContenido, Element.ALIGN_LEFT));
        tablaResumen.addCell(crearCeldaSinBordes(formatearMoneda(igv), fuenteContenido, Element.ALIGN_RIGHT));
        tablaResumen.addCell(crearCeldaSinBordes("Importe Total:", fuenteEncabezado, Element.ALIGN_LEFT));
        tablaResumen.addCell(crearCeldaSinBordes(formatearMoneda(total), fuenteEncabezado, Element.ALIGN_RIGHT));

        // Agregar todo a la tabla principal
        tablaPrincipal.addCell(cellContenedorDatoGenerales);
        tablaPrincipal.addCell(celdaEspacio);
        tablaPrincipal.addCell(cellContenedorDetalles);
        tablaPrincipal.addCell(tablaResumen);

        pdf.add(tablaPrincipal);
        pdf.close();
    }



    private static PdfPCell crearCeldaBordesLaterales(String texto, Font fuente, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setBorderWidthLeft(1);
        celda.setBorderWidthRight(1);
        celda.setBorderWidthBottom(0);
        celda.setBorderWidthTop(0);
        celda.setPadding(4f);
        return celda;
    }

    private static PdfPCell crearCeldaBordesSupInf(String texto, Font fuente, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setBorderWidthLeft(0);
        celda.setBorderWidthRight(0);
        celda.setBorderWidthBottom(1);
        celda.setBorderWidthTop(1);
        celda.setPadding(4f);
        return celda;
    }

    private static PdfPCell crearCelda(String texto, Font fuente, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setPadding(4f);
        return celda;
    }

    private static PdfPCell crearCeldaSinBordes(String texto, Font fuente, int alineacion) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setHorizontalAlignment(alineacion);
        celda.setBorder(PdfPCell.NO_BORDER);
        celda.setPadding(4f);
        return celda;
    }

    private static String formatearMoneda(double valor) {
        return String.format("S/. %.2f", valor);
    }
}

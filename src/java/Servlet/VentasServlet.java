package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Operaciones.AgregarVenta;

@WebServlet(name = "VentasServlet", urlPatterns = {"/VentasServlet"})
public class VentasServlet extends HttpServlet {  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Obtener arrays de productos, cantidades y totales
            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            List<Integer> idProductos = new ArrayList<>();
            List<Integer> cantidades = new ArrayList<>();

            // Crear listas para idProductos, cantidades, y totales
            for (int i = 0; i < productIds.length; i++) {
                idProductos.add(Integer.valueOf(productIds[i]));
                boolean add = cantidades.add(Integer.parseInt(quantities[i]));
            }

            // Crear la venta usando RegistrarVenta
            AgregarVenta venta = new AgregarVenta(idProductos, cantidades);
            int ventaId = AgregarVenta.createVenta(venta);

            // Redireccionar al historial
            response.sendRedirect("JSP/historial-ventas-compras.jsp");

        } catch (SQLException e) {
            throw new ServletException("Error al procesar la venta", e);
        }
    }
}

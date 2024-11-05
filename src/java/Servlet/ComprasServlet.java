package Servlet;

import Operaciones.AgregarCompra;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ComprasServlet", urlPatterns = {"/ComprasServlet"})
public class ComprasServlet extends HttpServlet {  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nitProveedor = request.getParameter("nit_proveedor");
            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] unitPrices = request.getParameterValues("unit_price[]");
            
            List<Integer> idProductos = new ArrayList<>();
            List<Integer> cantidades = new ArrayList<>();
            List<Double> preciosUnitarios = new ArrayList<>();

            for (int i = 0; i < productIds.length; i++) {
                idProductos.add(Integer.valueOf(productIds[i]));
                boolean add = cantidades.add(Integer.valueOf(quantities[i]));
                preciosUnitarios.add(Double.valueOf(unitPrices[i]));
            }

            AgregarCompra compra = new AgregarCompra(nitProveedor, idProductos, cantidades, preciosUnitarios);
            AgregarCompra.createCompra(compra);

            // Redireccionar al historial
            response.sendRedirect("JSP/historial-ventas-compras.jsp");

        } catch (SQLException e) {
            throw new ServletException("Error al procesar la venta", e);
        }
    }
}

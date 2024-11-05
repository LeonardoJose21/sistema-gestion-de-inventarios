package Operaciones;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HistorialVentasComprasServlet")
public class HistorialVentasComprasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Vector<ListarCompras> comprasList = ListarCompras.listarCompras();
            Vector<ListarVentas> ventasList = ListarVentas.listarVentas();
            request.setAttribute("ventasList", ventasList);
            request.setAttribute("comprasList", comprasList);

            request.getRequestDispatcher("/historial-ventas-compras.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al obtener el historial de ventas y compras.", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

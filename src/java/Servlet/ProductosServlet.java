package Servlet;

import Operaciones.ListarProductos;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "ProductosServlet", urlPatterns = {"/ProductosServlet"})
public class ProductosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Obtener la lista de productos
            Vector productos = ListarProductos.listarProductos();
            // Establecer los productos en el atributo de la solicitud para enviarlos a la vista
            request.setAttribute("productos", productos);

            // Redirigir a la página JSP para mostrar los productos
            RequestDispatcher dispatcher = request.getRequestDispatcher("JSP/productos.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener los productos.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

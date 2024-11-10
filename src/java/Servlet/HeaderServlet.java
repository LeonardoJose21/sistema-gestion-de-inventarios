package Servlet;

import Operaciones.ListarCompras;
import Operaciones.ListarProductos;
import Operaciones.ListarVentas;
import Operaciones.ObtenerComprasMesActual;
import Operaciones.ObtenerTopCategorias;
import Operaciones.ObtenerTopMarcas;
import Operaciones.ObtenerTopProductos;
import Operaciones.ObtenerTotalCompras;
import Operaciones.ObtenerTotalVentas;
import Operaciones.ObtenerVentasComprasMensuales;
import Operaciones.ObtenerVentasMesActual;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HeaderServlet", urlPatterns = {"/HeaderServlet"})
public class HeaderServlet extends HttpServlet {  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String listarProductos = request.getParameter("listar_productos");
            String listarComprasVentas = request.getParameter("historial_ventas_compras");
            String panelControl = request.getParameter("panel_control");

            if (listarProductos != null) {
                Vector<ListarProductos> productos = ListarProductos.listarProductos();
                
                request.setAttribute("productos", productos);

                RequestDispatcher dispatcher = request.getRequestDispatcher("JSP/productos.jsp");
                dispatcher.forward(request, response);
            } else if (listarComprasVentas != null) {
                Vector<ListarCompras> compras = ListarCompras.listarCompras();
                Vector<ListarVentas> ventas = ListarVentas.listarVentas();
                
                request.setAttribute("compras", compras);
                request.setAttribute("ventas", ventas);

                RequestDispatcher dispatcher = request.getRequestDispatcher("JSP/historial-ventas-compras.jsp");
                dispatcher.forward(request, response);
            } else if (panelControl != null) {
                // Obtener datos de KPI
                double totalVentas = ObtenerTotalVentas.obtenerTotal();
                double totalCompras = ObtenerTotalCompras.obtenerTotal();
                double ventasMesActual = ObtenerVentasMesActual.obtenerTotal();
                double comprasMesActual = ObtenerComprasMesActual.obtenerTotal();

                // Obtener tops
                ObtenerTopMarcas topMarcas = ObtenerTopMarcas.obtenerTop(5);
                ObtenerTopCategorias topCategorias = ObtenerTopCategorias.obtenerTop(5);
                ObtenerTopProductos topProductos = ObtenerTopProductos.obtenerTop(5);
                
                List<String> brandLabels = topMarcas.getTopMarcas();
                List<Double> brandData = topMarcas.getTopTotal();
                
                List<String> categoryLabels = topCategorias.getTopCategorias();
                List<Double> categoryData = topCategorias.getTopTotal();
                
                List<String> productLabels = topProductos.getTopProductos();
                List<Double> productData = topProductos.getTopTotal();
                
                //  Obtener compras vs ventas
                ObtenerVentasComprasMensuales ventasCompras = ObtenerVentasComprasMensuales.obtenerDatosMensuales();
                List<String> comprasVentasMeses = ventasCompras.getMeses();
                List<Double> comprasVentasTotalVentas = ventasCompras.getTotalVentas();
                List<Double> comprasVentasTotalCompras = ventasCompras.getTotalCompras();
                


                // Pasar datos al JSP
                request.setAttribute("totalVentas", totalVentas);
                request.setAttribute("totalCompras", totalCompras);
                request.setAttribute("ventasMesActual", ventasMesActual);
                request.setAttribute("comprasMesActual", comprasMesActual);
                request.setAttribute("brandLabels", brandLabels);
                request.setAttribute("brandData", brandData);
                request.setAttribute("categoryLabels", categoryLabels);
                request.setAttribute("categoryData", categoryData);
                request.setAttribute("productLabels", productLabels);
                request.setAttribute("productData", productData);
                request.setAttribute("comprasVentasMeses", comprasVentasMeses);
                request.setAttribute("comprasVentasTotalVentas", comprasVentasTotalVentas);
                request.setAttribute("comprasVentasTotalCompras", comprasVentasTotalCompras);
 
                RequestDispatcher dispatcher = request.getRequestDispatcher("JSP/panel-control.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Error al procesar la venta", e);
        }
    }
}

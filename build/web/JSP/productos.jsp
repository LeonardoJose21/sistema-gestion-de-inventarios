<%-- 
    Document   : productos
    Created on : Oct 25, 2024, 7:30:52 PM
    Author     : leopa
--%>

<%@page import="Operaciones.ListarProductos"%>
<%@ page import="java.util.Vector" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Vector<ListarProductos> productos = (Vector<ListarProductos>) request.getAttribute("productos");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <link href="${pageContext.request.contextPath}/CSS/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="productos.jsp" />
        </jsp:include>
        <main class="main-content">
            <table style="max-width: 90%; margin: 1rem auto">
                <thead>
                    <tr>
                        <th>ID Producto</th>
                        <th>Nombre</th>
                        <th>Marca</th>
                        <th>Categoría</th>                            
                        <th>Stock</th>
                        <th>Precio Unitario</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Iterar sobre el vector de clientes
                        for (ListarProductos producto : productos) {
                    %>
                    <tr>
                        <td><%= producto.getIdProducto()%></td>
                        <td><%= producto.getNombre()%></td>
                        <td><%= producto.getMarca()%></td>
                        <td><%= producto.getCategoria()%></td>
                        <td><%= producto.getUnidades()%></td>
                        <td><%= producto.getPrecioUnitario()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </main>
    </body>
</html>

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
            <div style="display:flex; gap:4rem;margin: 1rem auto; max-width: 50rem">
                <form method="post" action="busqueda-individual" style="display: flex; gap:4px; align-items: center">
                    <label for="id_product">ID del producto</label>
                    <input type="number" name="id_producto" style="padding: 8px; min-width: 10rem">
                    <button type="submit" style="width: 2.1rem; padding: 2px"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg></button>
                </form>
                <form method="post" action="filtro" style="display: flex; gap:4px; align-items: center;">
                    <label for="id_product">Stock Mínimo</label>
                    <select name="stock-minimo" style="padding: 5px">
                        <option value="0">
                            0
                        </option>
                        <option value="5">
                            5
                        </option>
                        <option value="10">
                            10
                        </option>
                        <option value="20">
                            20
                        </option>

                    </select>
                    <!--<input type="se" name="id_producto" style="padding: 8px; min-width: 10rem">-->
                    <button type="submit" style="display: flex; gap: 4px; justify-content: center; align-items: center; width: 9rem; padding: 2px">Aplicar Filtro <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-filter"><polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/></svg></button>
                </form>
            </div>
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

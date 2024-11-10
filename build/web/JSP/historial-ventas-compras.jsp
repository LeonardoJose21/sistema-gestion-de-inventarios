<%@page import="Operaciones.ListarCompras"%>
<%@page import="Operaciones.ListarVentas"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Vector<ListarCompras> compras = (Vector<ListarCompras>) request.getAttribute("compras");
    Vector<ListarVentas> ventas = (Vector<ListarVentas>) request.getAttribute("ventas");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia ventas y compras</title>
        <link href="${pageContext.request.contextPath}/CSS/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="historial-ventas-compras.jsp" />
        </jsp:include>
        <main class="main-content">
            <div class="toggle-container">
                <button class="toggle-btn active" onclick="toggleTable('ventas')">Historial de ventas</button>
                <button class="toggle-btn" onclick="toggleTable('compras')">Historial de compras</button>
            </div>

            <div id="ventasTable" class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID Venta</th>
                            <th>Nombre del Producto</th>
                            <th>Cantidad</th>
                            <th>Total</th>
                            <th>Fecha/Hora</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ListarVentas venta : ventas) {
                        %>
                        <tr>
                            <td><%= venta.getIdVenta() %></td>
                            <td><%= venta.getNombreProducto() %></td>
                            <td><%= venta.getCantidad() %></td>
                            <td><%= venta.getTotal() %></td>
                            <td><%= venta.getFechaHora() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div id="comprasTable" class="table-container hidden">
                <table>
                    <thead>
                        <tr>
                            <th>ID Surtido</th>
                            <th>Nombre del Producto</th>
                            <th>Cantidad</th>
                            <th>Total</th>
                            <th>NIT Proveedor</th>
                            <th>Fecha Entrega</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ListarCompras compra : compras) {
                        %>
                        <tr>
                            <td><%= compra.getIdSurtido() %></td>
                            <td><%= compra.getNombreProducto() %></td>
                            <td><%= compra.getCantidad() %></td>
                            <td><%= compra.getTotal() %></td>
                            <td><%= compra.getNitProveedor() %></td>
                            <td><%= compra.getFechaEntrega() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <script>
                function toggleTable(type) {
                    const ventasTable = document.getElementById('ventasTable');
                    const comprasTable = document.getElementById('comprasTable');
                    const buttons = document.querySelectorAll('.toggle-btn');

                    if (type === 'ventas') {
                        ventasTable.classList.remove('hidden');
                        comprasTable.classList.add('hidden');
                        buttons[0].classList.add('active');
                        buttons[1].classList.remove('active');
                    } else {
                        ventasTable.classList.add('hidden');
                        comprasTable.classList.remove('hidden');
                        buttons[0].classList.remove('active');
                        buttons[1].classList.add('active');
                    }
                }
            </script>
        </main>
    </body>
</html>

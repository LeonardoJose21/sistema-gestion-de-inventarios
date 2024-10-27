<%-- 
    Document   : historial-ventas-compras
    Created on : Oct 25, 2024, 7:11:37 PM
    Author     : leopa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historia ventas y compras</title>
        <link href="../CSS/estilos.css" rel="stylesheet" type="text/css">
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
                        <!-- Here you would use a JSP forEach to iterate through your sales data -->
                    <c:forEach items="${ventasList}" var="venta">
                        <tr>
                            <td>${venta.id_venta}</td>
                            <td>${venta.nombre_producto}</td>
                            <td>${venta.cantidad}</td>
                            <td>${venta.total}</td>
                            <td>${venta.fecha_hora}</td>
                        </tr>
                    </c:forEach>
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
                        <!-- Here you would use a JSP forEach to iterate through your purchase data -->
                    <c:forEach items="${comprasList}" var="compra">
                        <tr>
                            <td>${compra.id_surtido}</td>
                            <td>${compra.nombre_producto}</td>
                            <td>${compra.cantidad}</td>
                            <td>${compra.total}</td>
                            <td>${compra.nit_proveedor}</td>
                            <td>${compra.fecha_entrega}</td>
                        </tr>
                    </c:forEach>
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

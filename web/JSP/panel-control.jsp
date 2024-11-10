<%-- 
    Document   : panel-control
    Created on : Oct 25, 2024, 7:32:11 PM
    Author     : leopa
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Gson parser = new Gson();
    
    // Obtener el ArrayList del request      
    ArrayList<String> comprasVentasMeses = (ArrayList<String>) request.getAttribute("comprasVentasMeses");
    ArrayList<Double> comprasVentasTotalVentas = (ArrayList<Double>) request.getAttribute("comprasVentasTotalVentas");
    ArrayList<Double> comprasVentasTotalCompras = (ArrayList<Double>) request.getAttribute("comprasVentasTotalCompras");
    String jsonComprasVentasMeses = parser.toJson(comprasVentasMeses);
    String jsonComprasVentasTotalVentas = parser.toJson(comprasVentasTotalVentas);
    String jsonComprasVentasTotalCompras = parser.toJson(comprasVentasTotalCompras);
    
    ArrayList<String> categoryLabels = (ArrayList<String>) request.getAttribute("categoryLabels");
    ArrayList<Double> categoryData = (ArrayList<Double>) request.getAttribute("categoryData");
    String jsonCategoryLabels = parser.toJson(categoryLabels);
    String jsonCategoryData = parser.toJson(categoryData);
    
    ArrayList<String> brandLabels = (ArrayList<String>) request.getAttribute("brandLabels");
    ArrayList<Double> brandData = (ArrayList<Double>) request.getAttribute("brandData");
    String jsonBrandLabels = parser.toJson(brandLabels);
    String jsonBrandData = parser.toJson(brandData);
    
    ArrayList<String> productLabels = (ArrayList<String>) request.getAttribute("productLabels");
    ArrayList<Double> productData = (ArrayList<Double>) request.getAttribute("productData");
    String jsonProductLabels = parser.toJson(productLabels);
    String jsonProductData = parser.toJson(productData);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel</title>
        <link href="${pageContext.request.contextPath}/CSS/estilos.css" rel="stylesheet" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    </head>
    <body>

        <jsp:include page="header.jsp">
            <jsp:param name="page" value="panel-control.jsp" />
        </jsp:include>
        <div class="dashboard">
            <!-- KPIs Section -->
            <div class="kpi-container">
                <div class="kpi-card">
                    <div class="kpi-title">Ventas Totales</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27ce78" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-up"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/></svg>
                        </span>
                        $<%= request.getAttribute("totalVentas") %>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Compras Totales</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce2748" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-down"><polyline points="22 17 13.5 8.5 8.5 13.5 2 7"/><polyline points="16 17 22 17 22 11"/></svg>
                        </span>
                        $<%= request.getAttribute("totalCompras") %>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Ventas Mes Actual</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27ce78" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-up"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/></svg>
                        </span>
                        $<%= request.getAttribute("ventasMesActual") %>
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Compras Mes Actual</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce2748" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-down"><polyline points="22 17 13.5 8.5 8.5 13.5 2 7"/><polyline points="16 17 22 17 22 11"/></svg>
                        </span>
                        $<%= request.getAttribute("comprasMesActual") %>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-container">
                <!-- Ventas vs Compras por Mes -->
                <div class="chart-card">
                    <h3 class="chart-title">Ventas vs Compras por Mes</h3>
                    <canvas id="monthlyChart"></canvas>
                </div>

                <!-- Top 5 Categorías -->
                <div class="chart-card">
                    <h3 class="chart-title">Top 5 Categorías más Vendidas</h3>
                    <canvas id="categoriesChart"></canvas>
                </div>

                <!-- Top 5 Marcas -->
                <div class="chart-card">
                    <h3 class="chart-title">Top 5 Marcas más Vendidas</h3>
                    <canvas id="brandsChart"></canvas>
                </div>

                <!-- Top 5 Productos -->
                <div class="chart-card">
                    <h3 class="chart-title">Top 5 Productos más Vendidos</h3>
                    <canvas id="productsChart"></canvas>
                </div>
            </div>
        </div>

        <script>
            // Monthly Sales vs Purchases Chart
            const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            new Chart(monthlyCtx, {
                type: 'line',
                data: {
                    labels: <%= jsonComprasVentasMeses %>, // From server: ["Ene", "Feb", "Mar", ...]
                    datasets: [{
                            label: 'Ventas',
                            data: <%= jsonComprasVentasTotalVentas %>, // From server: [1000, 2000, 1500, ...]
                            borderColor: '#2ecc71',
                            tension: 0.1
                        }, {
                            label: 'Compras',
                            data: <%= jsonComprasVentasTotalCompras %>, // From server: [800, 1800, 1300, ...]
                            borderColor: '#3498db',
                            tension: 0.1
                        }]
                },
                options: {
                    responsive: false,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Categories Chart
            const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
            new Chart(categoriesCtx, {
                type: 'bar',
                data: {
                    labels: <%= jsonCategoryLabels %>, // From server: ["Cat1", "Cat2", ...]
                    datasets: [{
                            label: 'Ventas por Categoría',
                            data: <%= jsonCategoryData %>, // From server: [500, 400, 300, ...]
                            backgroundColor: '#e74c3c'
                        }]
                },
                options: {
                    responsive: false,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Brands Chart
            const brandsCtx = document.getElementById('brandsChart').getContext('2d');
            new Chart(brandsCtx, {
                type: 'bar',
                data: {
                    labels: <%= jsonBrandLabels %>, // From server: ["Brand1", "Brand2", ...]
                    datasets: [{
                            label: 'Ventas por Marca',
                            data: <%= jsonBrandData %>, // From server: [600, 550, 500, ...]
                            backgroundColor: '#9b59b6'
                        }]
                },
                options: {
                    responsive: false,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Products Chart
            const productsCtx = document.getElementById('productsChart').getContext('2d');
            new Chart(productsCtx, {
                type: 'bar',
                data: {
                    labels: <%= jsonProductLabels %>, // From server: ["Prod1", "Prod2", ...]
                    datasets: [{
                            label: 'Productos más Vendidos',
                            data: <%= jsonProductData %>, // From server: [800, 700, 600, ...]
                            backgroundColor: '#f1c40f'
                        }]
                },
                options: {
                    responsive: false,
                    maintainAspectRatio: false
                }
            });
        </script>
    </body>
</html>

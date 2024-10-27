<%-- 
    Document   : panel-control
    Created on : Oct 25, 2024, 7:32:11 PM
    Author     : leopa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel</title>
        <link href="../CSS/estilos.css" rel="stylesheet" type="text/css">
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
                        $${totalVentas}
                    </div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Compras Totales</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce2748" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-down"><polyline points="22 17 13.5 8.5 8.5 13.5 2 7"/><polyline points="16 17 22 17 22 11"/></svg>
                        </span>
                        $${totalCompras}</div>
                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Ventas Último Mes</div>
                    <div class="kpi-value"><span style="margin-right: 0 ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27ce78" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-up"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/></svg>
                        </span>
                        $${ventasUltimoMes}</div>

                </div>
                <div class="kpi-card">
                    <div class="kpi-title">Compras Último Mes</div>
                    <div class="kpi-value">
                        <span style="margin-right: 2px ">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ce2748" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trending-down"><polyline points="22 17 13.5 8.5 8.5 13.5 2 7"/><polyline points="16 17 22 17 22 11"/></svg>
                        </span>
                        $${comprasUltimoMes}</div>
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
                    labels: ${monthLabels}, // From server: ["Ene", "Feb", "Mar", ...]
                    datasets: [{
                            label: 'Ventas',
                            data: ${monthlyVentas}, // From server: [1000, 2000, 1500, ...]
                            borderColor: '#2ecc71',
                            tension: 0.1
                        }, {
                            label: 'Compras',
                            data: ${monthlyCompras}, // From server: [800, 1800, 1300, ...]
                            borderColor: '#3498db',
                            tension: 0.1
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Categories Chart
            const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
            new Chart(categoriesCtx, {
                type: 'bar',
                data: {
                    labels: ${categoryLabels}, // From server: ["Cat1", "Cat2", ...]
                    datasets: [{
                            label: 'Ventas por Categoría',
                            data: ${categoryData}, // From server: [500, 400, 300, ...]
                            backgroundColor: '#e74c3c'
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Brands Chart
            const brandsCtx = document.getElementById('brandsChart').getContext('2d');
            new Chart(brandsCtx, {
                type: 'bar',
                data: {
                    labels: ${brandLabels}, // From server: ["Brand1", "Brand2", ...]
                    datasets: [{
                            label: 'Ventas por Marca',
                            data: ${brandData}, // From server: [600, 550, 500, ...]
                            backgroundColor: '#9b59b6'
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Top 5 Products Chart
            const productsCtx = document.getElementById('productsChart').getContext('2d');
            new Chart(productsCtx, {
                type: 'bar',
                data: {
                    labels: ${productLabels}, // From server: ["Prod1", "Prod2", ...]
                    datasets: [{
                            label: 'Productos más Vendidos',
                            data: ${productData}, // From server: [800, 700, 600, ...]
                            backgroundColor: '#f1c40f'
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        </script>
    </body>
</html>

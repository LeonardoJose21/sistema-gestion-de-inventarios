<%
    String currentPage = request.getParameter("page");

%>
<nav class="navbar">

    <div class="navbar-content">
        <a href="inicio.jsp">
            <img src ="../assets/logo.png" alt = "Logo" id ="logo-img"/>
        </a>
        <form method="post" action="servelet">
            <div class="nav-buttons">

                <a href="historial-ventas-compras.jsp" class="nav-button" style="<%= "historial-ventas-compras.jsp".equals(currentPage) ? "background-color: #3d4f48;" : ""%>" onclick="setActivePage('historial-ventas-compras')">Ventas y compras<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-scroll-text"><path d="M15 12h-5"/><path d="M15 8h-5"/><path d="M19 17V5a2 2 0 0 0-2-2H4"/><path d="M8 21h12a2 2 0 0 0 2-2v-1a1 1 0 0 0-1-1H11a1 1 0 0 0-1 1v1a2 2 0 1 1-4 0V5a2 2 0 1 0-4 0v2a1 1 0 0 0 1 1h3"/></svg></a>
                <a href="agregar-compra.jsp" class="nav-button" style="<%= "agregar-compra.jsp".equals(currentPage) ? "background-color: #3d4f48;" : ""%>" onclick="setActivePage('agregar-compra')">Agregar Compra<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hand-coins"><path d="M11 15h2a2 2 0 1 0 0-4h-3c-.6 0-1.1.2-1.4.6L3 17"/><path d="m7 21 1.6-1.4c.3-.4.8-.6 1.4-.6h4c1.1 0 2.1-.4 2.8-1.2l4.6-4.4a2 2 0 0 0-2.75-2.91l-4.2 3.9"/><path d="m2 16 6 6"/><circle cx="16" cy="9" r="2.9"/><circle cx="6" cy="5" r="3"/></svg></a>
                <a href="agregar-venta.jsp" class="nav-button" style="<%= "agregar-venta.jsp".equals(currentPage) ? "background-color: #3d4f48;" : ""%>" onclick="setActivePage('agregar-venta')">Agregar Venta<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-dollar-sign"><circle cx="12" cy="12" r="10"/><path d="M16 8h-6a2 2 0 1 0 0 4h4a2 2 0 1 1 0 4H8"/><path d="M12 18V6"/></svg></a>
                <a href="productos.jsp" class="nav-button" style="<%= "productos.jsp".equals(currentPage) ? "background-color: #3d4f48;" : ""%>" onclick="setActivePage('productos')">Productos<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-basket"><path d="m15 11-1 9"/><path d="m19 11-4-7"/><path d="M2 11h20"/><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8a2 2 0 0 0 2-1.6l1.7-7.4"/><path d="M4.5 15.5h15"/><path d="m5 11 4-7"/><path d="m9 11 1 9"/></svg></a>
                <a href="panel-control.jsp" class="nav-button" style="<%= "panel-control.jsp".equals(currentPage) ? "background-color: #3d4f48;" : ""%>" onclick="setActivePage('panel-control')">Panel<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-layout-dashboard"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg></a>
                <a href="../" id ="logout-btn" class="nav-button">Cerrar<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-log-out"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg></a>
                <input type="hidden" name="activePage" id="activePage" value="" />
            </div>
        </form>
        <script>
            function setActivePage(page) {
                document.getElementById('activePage').value = page;
                console.log(document.getElementById('activePage').value);
            }
        </script>
    </div>


</nav>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tienda los pelaos - Inicio</title>
        <link href="${pageContext.request.contextPath}/CSS/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="historial-ventas-compras.jsp" />
        </jsp:include>
        <main class="main-content">
            <image src="../assets/hero.jpg" alt ="hero img" width="100%" />
            <p id="text-hero">Gestiona eficientemente tu inventario</p>
        </main>


    </body>
</html>
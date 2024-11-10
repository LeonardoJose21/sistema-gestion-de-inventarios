

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tienda los pelaos - Login</title>
        <link href="./CSS/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <nav class="navbar">
            <div class="navbar-content">
                <img src ="./assets/logo.png" alt = "Logo" id ="logo-img"/>
                <div class="title-container">
                    <h1>Tienda los pelaos</h1>
                    <h3>Gestión de inventario</h3>
                </div>

            </div>
        </nav>

        <div class="login-container">

            <h2 class="login-title">Iniciar Sesión</h2>
            <form method="post" action="AuthServlet">
                <div class="input-group">
                    <label for="usuario">Usuario</label>
                    <input type="text" id="usuario" placeholder="Ingrese su usuario" name="usuario">
                </div>
                <div class="input-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" placeholder="Ingrese su contraseña" name="password">
                </div>
                <button type="submit" class="login-button">Iniciar Sesión <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-log-out"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg></button>
            </form>
            <% if (request.getAttribute("loginError") != null) { %>
            <p id="error-message" style="color:red; margin-top:1rem; text-align: center;">Sus credenciales son incorrectas, intentelo de nuevo por favor</p>
            <script>
                // JavaScript to hide the error message after 6 seconds
                setTimeout(function () {
                    const errorMessage = document.getElementById("error-message");
                    if (errorMessage) {
                        errorMessage.style.display = "none";
                    }
                }, 6000); // 6000 milliseconds = 6 seconds
            </script>
            <% }%>
        </div>


    </body>
</html>

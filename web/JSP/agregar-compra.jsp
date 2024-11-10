<%-- 
    Document   : agregar-compra
    Created on : Oct 25, 2024, 7:27:11 PM
    Author     : leopa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar compra</title>
        <link href="${pageContext.request.contextPath}/CSS/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="agregar-compra.jsp" />
        </jsp:include>

        <main class="main-content">
            <div class="form-container" style="max-width:1000px;">
                <form action="${pageContext.request.contextPath}/ComprasServlet" method="POST">
                    <h1 style="color:#3d4f48; margin-bottom: 1rem; margin-top: 0.5rem; text-align: center">
                        Registro de compras
                    </h1>
                    <div class="input-group" style="width:300px; margin: 1rem 0.3px; ">
                        <label for="nit_proveedor">NIT del proveedor</label>
                        <input type="number" id="nit_proveedor" name="nit_proveedor" required>
                    </div>
                    <div id="productsContainer" class="products-container">
                        <div class="product-row">
                            <div class="input-group">
                                <label for="productId_1">ID del producto</label>
                                <input type="number" id="productId_1" name="productId[]" required>
                            </div>
                            <div class="input-group">
                                <label for="quantity_1">Cantidad</label>
                                <input type="number" id="quantity_1" name="quantity[]" min="1" required>
                            </div>
                            <div class="input-group">
                                <label for="unit_price_1">Precio Unitario</label>
                                <input type="number" id="unit_price_1" name="unit_price[]" min="1" required>
                            </div>
                            <button type="button" class="add-btn" onclick="addProductRow()"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg></button>
                        </div>
                    </div>

                    <button type="submit" id="btn-c-v">Guardar Compra <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-save"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg></button>
                </form>
            </div>

        </main>
        <script>
            let rowCount = 1;

            function addProductRow() {
                rowCount++;
                const container = document.getElementById('productsContainer');
                const newRow = document.createElement('div');
                newRow.className = 'product-row';
                newRow.innerHTML = `
                <div class="input-group">
                    <label for="productId_${rowCount}">ID del producto</label>
                    <input type="number" id="productId_${rowCount}" name="productId[]" required>
                </div>
                <div class="input-group">
                    <label for="quantity_${rowCount}">Cantidad</label>
                    <input type="number" id="quantity_${rowCount}" name="quantity[]" min="1" required>
                </div>
                <div class="input-group">
                    <label for="unit_price_${rowCount}">Precio Unitario</label>
                    <input type="number" id="unit_price_${rowCount}" name="unit_price[]" min="1" required>
                </div>
                <button type="button" class="remove-btn" onclick="removeProductRow(this)"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-minus"><path d="M5 12h14"/></svg></button>
            `;
                container.appendChild(newRow);
            }

            function removeProductRow(button) {
                button.closest('.product-row').remove();
            }
        </script>
    </body>
</html>

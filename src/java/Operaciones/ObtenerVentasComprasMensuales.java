package Operaciones;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ObtenerVentasComprasMensuales {
    private List<String> meses;
    private List<Double> totalVentas;
    private List<Double> totalCompras;

    public ObtenerVentasComprasMensuales(List<String> meses, List<Double> totalVentas, List<Double> totalCompras) {
        this.meses = meses;
        this.totalVentas = totalVentas;
        this.totalCompras = totalCompras;
    }

    public static ObtenerVentasComprasMensuales obtenerDatosMensuales() throws SQLException {
        List<String> meses = new ArrayList<>();
        List<Double> totalVentas = new ArrayList<>();
        List<Double> totalCompras = new ArrayList<>();

        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_ventas_compras_mensuales()}";
        CallableStatement llamada = con.prepareCall(procedimiento);

        boolean hasResults = llamada.execute();
        Map<String, Double> ventasMap = new HashMap<>();
        Map<String, Double> comprasMap = new HashMap<>();

        // Procesar primer conjunto de resultados (Ventas)
        if (hasResults) {
            ResultSet rs = llamada.getResultSet();
            while (rs.next()) {
                String mes = rs.getString("mes");
                double total = rs.getDouble("totalVentas");
                ventasMap.put(mes, total);
            }
            rs.close();
        }

        // Mover al segundo conjunto de resultados (Compras)
        if (llamada.getMoreResults()) {
            ResultSet rs = llamada.getResultSet();
            while (rs.next()) {
                String mes = rs.getString("mes");
                double total = rs.getDouble("totalCompras");
                comprasMap.put(mes, total);
            }
            rs.close();
        }

        llamada.close();
        dbm.closeConnection(con);

        // Crear lista única de meses ordenada
        meses.addAll(ventasMap.keySet());
        for (String mes : comprasMap.keySet()) {
            if (!meses.contains(mes)) {
                meses.add(mes);
            }
        }
        meses.sort((m1, m2) -> {
            // Ordenar meses de forma cronológica
            String[] monthOrder = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            return Integer.compare(java.util.Arrays.asList(monthOrder).indexOf(m1), java.util.Arrays.asList(monthOrder).indexOf(m2));
        });

        // Agregar totales en el orden de la lista de meses, con null si falta un valor en ventas o compras
        for (String mes : meses) {
            totalVentas.add(ventasMap.getOrDefault(mes, null));
            totalCompras.add(comprasMap.getOrDefault(mes, null));
        }

        return new ObtenerVentasComprasMensuales(meses, totalVentas, totalCompras);
    }

    public List<String> getMeses() {
        return meses;
    }

    public List<Double> getTotalVentas() {
        return totalVentas;
    }

    public List<Double> getTotalCompras() {
        return totalCompras;
    }
}
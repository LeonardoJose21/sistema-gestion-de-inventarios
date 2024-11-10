package Operaciones;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObtenerTopCategorias {
    List<String> topCategorias;
    List<Double> topTotal;

    public ObtenerTopCategorias(List<String> topCategorias, List<Double> topTotal) {
        this.topCategorias = topCategorias;
        this.topTotal = topTotal;
    }
    
    public static ObtenerTopCategorias obtenerTop(int topN) throws SQLException {
        List<String> topCategorias = new ArrayList<>();
        List<Double> topTotal = new ArrayList<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_top_categorias(?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);
        
        llamada.setInt(1, topN);
        ResultSet rs = llamada.executeQuery();
        
        while (rs.next()) {
            topCategorias.add(rs.getString("categoria"));
            topTotal.add(rs.getDouble("total"));
        }
        
        rs.close();
        llamada.close();
        dbm.closeConnection(con);
        
        return new ObtenerTopCategorias(topCategorias, topTotal);
    }

    public List<String> getTopCategorias() {
        return topCategorias;
    }

    public List<Double> getTopTotal() {
        return topTotal;
    }
}

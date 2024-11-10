package Operaciones;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObtenerTopProductos {
    List<String> topProductos;
    List<Double> topTotal;

    public ObtenerTopProductos(List<String> topProductos, List<Double> topTotal) {
        this.topProductos = topProductos;
        this.topTotal = topTotal;
    }
    
    public static ObtenerTopProductos obtenerTop(int topN) throws SQLException {
        List<String> topProductos = new ArrayList<>();
        List<Double> topTotal = new ArrayList<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_top_productos(?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);
        
        llamada.setInt(1, topN);
        ResultSet rs = llamada.executeQuery();
        
        while (rs.next()) {
            topProductos.add(rs.getString("producto"));
            topTotal.add(rs.getDouble("total"));
        }
        
        rs.close();
        llamada.close();
        dbm.closeConnection(con);
        
        return new ObtenerTopProductos(topProductos, topTotal);
    }

    public List<String> getTopProductos() {
        return topProductos;
    }

    public List<Double> getTopTotal() {
        return topTotal;
    }
}

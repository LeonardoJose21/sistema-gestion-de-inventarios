package Operaciones;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObtenerTopMarcas {
    List<String> topMarcas;
    List<Double> topTotal;

    public ObtenerTopMarcas(List<String> topMarcas, List<Double> topTotal) {
        this.topMarcas = topMarcas;
        this.topTotal = topTotal;
    }
    
    public static ObtenerTopMarcas obtenerTop(int topN) throws SQLException {
        List<String> topMarcas = new ArrayList<>();
        List<Double> topTotal = new ArrayList<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_top_marcas(?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);
        
        llamada.setInt(1, topN);
        ResultSet rs = llamada.executeQuery();
        
        while (rs.next()) {
            topMarcas.add(rs.getString("marca"));
            topTotal.add(rs.getDouble("total"));
        }
        
        rs.close();
        llamada.close();
        dbm.closeConnection(con);
        
        return new ObtenerTopMarcas(topMarcas, topTotal);
    }

    public List<String> getTopMarcas() {
        return topMarcas;
    }

    public List<Double> getTopTotal() {
        return topTotal;
    }
    
    
}

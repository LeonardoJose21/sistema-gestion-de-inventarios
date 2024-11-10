package Operaciones;

import java.sql.*;

public class ObtenerTotalVentas {
    public static double obtenerTotal() throws SQLException {
        double totalVentas = 0;
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_total_ventas(?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);
        
        llamada.registerOutParameter(1, Types.DECIMAL);
        llamada.execute();
        totalVentas = llamada.getDouble(1);
        
        llamada.close();
        dbm.closeConnection(con);
        
        return totalVentas;
    }
}

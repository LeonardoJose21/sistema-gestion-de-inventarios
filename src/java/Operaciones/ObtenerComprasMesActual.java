package Operaciones;

import java.sql.*;

public class ObtenerComprasMesActual {
    public static double obtenerTotal() throws SQLException {
        double totalCompras = 0;
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call obtener_compras_mes_actual(?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);
        
        llamada.registerOutParameter(1, Types.DECIMAL);
        llamada.execute();
        totalCompras = llamada.getDouble(1);
        
        llamada.close();
        dbm.closeConnection(con);
        
        return totalCompras;
    }
}

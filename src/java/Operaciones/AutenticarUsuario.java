package Operaciones;

import java.sql.*;

public class AutenticarUsuario {
    public static boolean autenticar(String username, String password) throws SQLException {
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();
        String procedimiento = "{call autenticar_usuario(?, ?, ?)}";
        CallableStatement llamada = con.prepareCall(procedimiento);

        // Establecer parámetros de entrada y salida
        llamada.setString(1, username);
        llamada.setString(2, password);
        llamada.registerOutParameter(3, Types.INTEGER);

        // Ejecutar el procedimiento
        llamada.execute();

        // Obtener el resultado de autenticación
        int resultado = llamada.getInt(3);
        boolean autenticado = (resultado == 1);

        // Cerrar recursos
        llamada.close();
        dbm.closeConnection(con);

        return autenticado;
    }
}
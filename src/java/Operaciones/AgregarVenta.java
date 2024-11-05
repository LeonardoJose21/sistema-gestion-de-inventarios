package Operaciones;

import java.sql.*;
import java.util.List;

public class AgregarVenta {
    private int idVenta;
    private List<Integer> idProductos;
    private List<Integer> cantidades;

    public AgregarVenta(List<Integer> idProductos, List<Integer> cantidades) {
        this.idProductos = idProductos;
        this.cantidades = cantidades;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public List<Integer> getIdProductos() {
        return idProductos;
    }

    public List<Integer> getCantidades() {
        return cantidades;
    }

    public static int createVenta(AgregarVenta venta) throws SQLException {
        DBManager dbm = new DBManager();
        Connection conn = dbm.getConnection();
        CallableStatement csVenta = null;
        CallableStatement csDetalle = null;
        int ventaId = 0;

        try {
            conn.setAutoCommit(false);

            // Llamar al procedimiento almacenado para insertar la venta
            String ventaSQL = "{CALL insertar_venta(?)}";
            csVenta = conn.prepareCall(ventaSQL);
            csVenta.registerOutParameter(1, Types.INTEGER);
            csVenta.executeUpdate();
            ventaId = csVenta.getInt(1);
            venta.setIdVenta(ventaId);

            // Llamar al procedimiento almacenado para cada detalle
            String detalleSQL = "{CALL insertar_detalle(?, ?, ?)}";
            csDetalle = conn.prepareCall(detalleSQL);

            for (int i = 0; i < venta.getIdProductos().size(); i++) {
                csDetalle.setInt(1, ventaId);
                csDetalle.setInt(2, venta.getIdProductos().get(i));
                csDetalle.setInt(3, venta.getCantidades().get(i));
                csDetalle.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (csDetalle != null) csDetalle.close();
            if (csVenta != null) csVenta.close();
            if (conn != null) dbm.closeConnection(conn);
        }

        return ventaId;
    }
}

package Operaciones;

import java.sql.*;
import java.util.List;

public class AgregarCompra {
    private int idSurtido;
    private String nitProveedor;
    private List<Integer> idProductos;
    private List<Integer> cantidades;
    private List<Double> preciosUnitarios;

    public AgregarCompra(String nitProveedor, List<Integer> idProductos, List<Integer> cantidades, List<Double> preciosUnitarios) {
        this.nitProveedor = nitProveedor;
        this.idProductos = idProductos;
        this.cantidades = cantidades;
        this.preciosUnitarios = preciosUnitarios;
    }

    public int getIdSurtido() {
        return idSurtido;
    }

    public void setIdSurtido(int idSurtido) {
        this.idSurtido = idSurtido;
    }

    public String getNitProveedor() {
        return nitProveedor;
    }

    public List<Integer> getIdProductos() {
        return idProductos;
    }

    public List<Integer> getCantidades() {
        return cantidades;
    }

    public List<Double> getPreciosUnitarios() {
        return preciosUnitarios;
    }

    public static int createCompra(AgregarCompra compra) throws SQLException {
        DBManager dbm = new DBManager();
        Connection conn = dbm.getConnection();
        CallableStatement csSurtido = null;
        CallableStatement csDetalle = null;
        int surtidoId = 0;

        try {
            conn.setAutoCommit(false);

            // Llamar al procedimiento almacenado para insertar el surtido
            String surtidoSQL = "{CALL crear_surtido(?, ?)}";
            csSurtido = conn.prepareCall(surtidoSQL);
            csSurtido.setString(1, compra.getNitProveedor());
            csSurtido.registerOutParameter(2, Types.INTEGER);
            csSurtido.executeUpdate();
            surtidoId = csSurtido.getInt(2);
            compra.setIdSurtido(surtidoId);

            // Llamar al procedimiento almacenado para cada detalle del surtido
            String detalleSQL = "{CALL insertar_detalle_surtido(?, ?, ?, ?)}";
            csDetalle = conn.prepareCall(detalleSQL);

            for (int i = 0; i < compra.getIdProductos().size(); i++) {
                csDetalle.setInt(1, surtidoId);
                csDetalle.setInt(2, compra.getIdProductos().get(i));
                csDetalle.setInt(3, compra.getCantidades().get(i));
                csDetalle.setDouble(4, compra.getPreciosUnitarios().get(i));
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
            if (csSurtido != null) csSurtido.close();
            if (conn != null) dbm.closeConnection(conn);
        }

        return surtidoId;
    }
}

package Operaciones;

import java.sql.*;
import java.util.Vector;

public class ListarCompras {
    private int idSurtido;
    private String nombreProducto;
    private int cantidad;
    private double total;
    private String nitProveedor;
    private Date fechaEntrega;

    public ListarCompras(int idSurtido, String nombreProducto, int cantidad, double total, String nitProveedor, Date fechaEntrega) {
        this.idSurtido = idSurtido;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.total = total;
        this.nitProveedor = nitProveedor;
        this.fechaEntrega = fechaEntrega;
    }

    public static synchronized Vector<ListarCompras> listarCompras() throws SQLException {
        Vector<ListarCompras> compras = new Vector<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();

        String procedimiento = "{call mostrar_compras()}";
        CallableStatement llamada = con.prepareCall(procedimiento);

        ResultSet rs = llamada.executeQuery();

        while (rs.next()) {
            compras.add(new ListarCompras(
                rs.getInt("id_surtido"),
                rs.getString("nombre_producto"),
                rs.getInt("cantidad"),
                rs.getDouble("total"),
                rs.getString("nit_proveedor"),
                rs.getDate("fecha_entrega")
            ));
        }

        rs.close();
        llamada.close();
        dbm.closeConnection(con);

        return compras;
    }

    // Getters and Setters
    public int getIdSurtido() {
        return idSurtido;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public double getTotal() {
        return total;
    }

    public String getNitProveedor() {
        return nitProveedor;
    }

    public Date getFechaEntrega() {
        return fechaEntrega;
    }
}
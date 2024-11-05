package Operaciones;

import java.sql.*;
import java.util.Vector;

public class ListarVentas {
    private int idVenta;
    private String nombreProducto;
    private int cantidad;
    private double total;
    private Timestamp fechaHora;

    public ListarVentas(int idVenta, String nombreProducto, int cantidad, double total, Timestamp fechaHora) {
        this.idVenta = idVenta;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.total = total;
        this.fechaHora = fechaHora;
    }

    public static synchronized Vector<ListarVentas> listarVentas() throws SQLException {
        Vector<ListarVentas> ventas = new Vector<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();

        String procedimiento = "{call mostrar_ventas()}";
        CallableStatement llamada = con.prepareCall(procedimiento);

        ResultSet rs = llamada.executeQuery();

        while (rs.next()) {
            ventas.add(new ListarVentas(
                rs.getInt("id_venta"),
                rs.getString("nombre_producto"),
                rs.getInt("cantidad"),
                rs.getDouble("total"),
                rs.getTimestamp("fecha_hora")
            ));
        }

        rs.close();
        llamada.close();
        dbm.closeConnection(con);

        return ventas;
    }

    // Getters and Setters
    public int getIdVenta() {
        return idVenta;
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

    public Timestamp getFechaHora() {
        return fechaHora;
    }
}

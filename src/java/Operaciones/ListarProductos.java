package Operaciones;

import java.sql.*;
import java.util.Vector;

public class ListarProductos {
    private int idProducto;
    private String nombre;
    private String marca;
    private String categoria;
    private int unidades;
    private double precioUnitario;

    public ListarProductos(int idProducto, String nombre, String marca, String categoria, int unidades, double precioUnitario) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.marca = marca;
        this.categoria = categoria;
        this.unidades = unidades;
        this.precioUnitario = precioUnitario;
    }

    public static synchronized Vector<ListarProductos> listarProductos() throws SQLException {
        Vector<ListarProductos> productos = new Vector<>();
        DBManager dbm = new DBManager();
        Connection con = dbm.getConnection();

        String procedimiento = "{call mostrar_productos()}";
        CallableStatement llamada = con.prepareCall(procedimiento);

        ResultSet rs = llamada.executeQuery();

        while (rs.next()) {
            productos.add(new ListarProductos(
                rs.getInt("id_producto"),
                rs.getString("nombre_producto"),
                rs.getString("marca"),
                rs.getString("categoria"),
                rs.getInt("unidades"),
                rs.getDouble("precio_unitario")
            ));
        }

        rs.close();
        llamada.close();
        dbm.closeConnection(con);

        return productos;
    }

    // Getters and Setters
    public int getIdProducto() {
        return this.idProducto;
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getMarca() {
        return this.marca;
    }

    public String getCategoria() {
        return this.categoria;
    }

    public int getUnidades() {
        return this.unidades;
    }

    public double getPrecioUnitario() {
        return this.precioUnitario;
    }
}
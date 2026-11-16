package com.proyecto.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL_CONEXION = "jdbc:mysql://localhost:3306/proyecto_sena_db?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "";

    public static Connection obtenerConexion() {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL_CONEXION, USUARIO_BD, CLAVE_BD);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error de conexión JDBC: " + e.getMessage());
        }
        return conexion;
    }
}
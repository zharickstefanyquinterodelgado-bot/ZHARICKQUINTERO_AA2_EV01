package com.proyecto.dao;

import com.proyecto.conexion.ConexionBD;
import com.proyecto.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // INSERCIÓN (CREATE)
    public boolean insertarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuarios (documento, nombres, apellidos, correo, telefono) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getDocumento());
            ps.setString(2, usuario.getNombres());
            ps.setString(3, usuario.getApellidos());
            ps.setString(4, usuario.getCorreo());
            ps.setString(5, usuario.getTelefono());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al insertar usuario: " + e.getMessage());
            return false;
        }
    }

    // CONSULTA GENERAL (READ)
    public List<Usuario> listarUsuarios() {
        List<Usuario> listaUsuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY id_usuario DESC";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario(
                    rs.getInt("id_usuario"),
                    rs.getString("documento"),
                    rs.getString("nombres"),
                    rs.getString("apellidos"),
                    rs.getString("correo"),
                    rs.getString("telefono")
                );
                listaUsuarios.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios: " + e.getMessage());
        }
        return listaUsuarios;
    }

    // CONSULTA POR ID (READ BY ID)
    public Usuario obtenerUsuarioPorId(int idUsuario) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("documento"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getString("correo"),
                        rs.getString("telefono")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario: " + e.getMessage());
        }
        return usuario;
    }

    // ACTUALIZACIÓN (UPDATE)
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET documento = ?, nombres = ?, apellidos = ?, correo = ?, telefono = ? WHERE id_usuario = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getDocumento());
            ps.setString(2, usuario.getNombres());
            ps.setString(3, usuario.getApellidos());
            ps.setString(4, usuario.getCorreo());
            ps.setString(5, usuario.getTelefono());
            ps.setInt(6, usuario.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    // ELIMINACIÓN (DELETE)
    public boolean eliminarUsuario(int idUsuario) {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
}
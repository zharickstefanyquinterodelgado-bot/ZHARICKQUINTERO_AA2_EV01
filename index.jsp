<%@page import="java.util.List"%>
<%@page import="com.proyecto.modelo.Usuario"%>
<%@page import="com.proyecto.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    String mensaje = null;
    Usuario usuarioEditar = null;

    // Procesar peticiones POST (Inserción y Actualización)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String idTexto = request.getParameter("idUsuario");
        Usuario u = new Usuario();
        u.setDocumento(request.getParameter("documento"));
        u.setNombres(request.getParameter("nombres"));
        u.setApellidos(request.getParameter("apellidos"));
        u.setCorreo(request.getParameter("correo"));
        u.setTelefono(request.getParameter("telefono"));

        if (idTexto == null || idTexto.isEmpty() || idTexto.equals("0")) {
            if (usuarioDAO.insertarUsuario(u)) {
                mensaje = "Usuario registrado correctamente.";
            }
        } else {
            u.setIdUsuario(Integer.parseInt(idTexto));
            if (usuarioDAO.actualizarUsuario(u)) {
                mensaje = "Usuario actualizado correctamente.";
            }
        }
    }

    // Procesar peticiones GET (Consulta para editar y Eliminación)
    String accion = request.getParameter("accion");
    if ("editar".equals(accion)) {
        int idEditar = Integer.parseInt(request.getParameter("id"));
        usuarioEditar = usuarioDAO.obtenerUsuarioPorId(idEditar);
    } else if ("eliminar".equals(accion)) {
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        if (usuarioDAO.eliminarUsuario(idEliminar)) {
            mensaje = "Usuario eliminado correctamente.";
        }
    }

    List<Usuario> listaUsuarios = usuarioDAO.listarUsuarios();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Módulo CRUD Java JDBC - SENA</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <header>
        <h1>Módulo de Gestión de Usuarios</h1>
        <p>Evidencia GA7-220501096-AA2-EV01 | Java + JDBC + HTML/CSS</p>
    </header>

    <main class="contenedor">
        <% if (mensaje != null) { %>
            <div class="alerta"><%= mensaje %></div>
        <% } %>

        <section class="tarjeta">
            <h2><%= (usuarioEditar != null) ? "Actualizar Usuario" : "Registrar Nuevo Usuario" %></h2>
            <form action="index.jsp" method="POST" class="formulario">
                <input type="hidden" name="idUsuario" value="<%= (usuarioEditar != null) ? usuarioEditar.getIdUsuario() : "0" %>">
                
                <div class="campo">
                    <label for="documento">Documento:</label>
                    <input type="text" id="documento" name="documento" required value="<%= (usuarioEditar != null) ? usuarioEditar.getDocumento() : "" %>">
                </div>
                <div class="campo">
                    <label for="nombres">Nombres:</label>
                    <input type="text" id="nombres" name="nombres" required value="<%= (usuarioEditar != null) ? usuarioEditar.getNombres() : "" %>">
                </div>
                <div class="campo">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" id="apellidos" name="apellidos" required value="<%= (usuarioEditar != null) ? usuarioEditar.getApellidos() : "" %>">
                </div>
                <div class="campo">
                    <label for="correo">Correo:</label>
                    <input type="email" id="correo" name="correo" required value="<%= (usuarioEditar != null) ? usuarioEditar.getCorreo() : "" %>">
                </div>
                <div class="campo">
                    <label for="telefono">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" required value="<%= (usuarioEditar != null) ? usuarioEditar.getTelefono() : "" %>">
                </div>

                <div class="botones">
                    <button type="submit" class="btn btn-guardar"><%= (usuarioEditar != null) ? "Actualizar" : "Guardar" %></button>
                    <% if (usuarioEditar != null) { %>
                        <a href="index.jsp" class="btn btn-cancelar">Cancelar</a>
                    <% } %>
                </div>
            </form>
        </section>

        <section class="tarjeta">
            <h2>Listado de Usuarios (Consulta)</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Documento</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Correo</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Usuario u : listaUsuarios) { %>
                    <tr>
                        <td><%= u.getIdUsuario() %></td>
                        <td><%= u.getDocumento() %></td>
                        <td><%= u.getNombres() %></td>
                        <td><%= u.getApellidos() %></td>
                        <td><%= u.getCorreo() %></td>
                        <td><%= u.getTelefono() %></td>
                        <td>
                            <a href="index.jsp?accion=editar&id=<%= u.getIdUsuario() %>" class="btn btn-editar">Editar</a>
                            <a href="index.jsp?accion=eliminar&id=<%= u.getIdUsuario() %>" class="btn btn-eliminar" onclick="return confirm('¿Eliminar este registro?');">Eliminar</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>

<%-- 
    Document   : estadoRestriccion
    Created on : 08/03/2018, 10:33:42
    Author     : Tefii
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="FORM.Valores"%>
<%@page import="java.util.LinkedList"%>
<%@page import="FORM.TipoPreguntas"%>
<%@page import="FORM.Preguntas"%>
<%@page import="FORM.Grupo"%>
<%@page import="FORM.Formulario"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Estado Restriccion</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body> 
        <%@page import="org.apache.log4j.Logger"%>
        <%! static Logger logger = Logger.getLogger("bitacora.subnivel.Control");%>
        <%logger.info("esta es la prueba."); %>
        <%logger.debug("Demostracion del mensaje");%>
        <%logger.warn("Show WARN message");%>
        <%logger.error("Show ERROR message");%>
        <%logger.fatal("Show FATAL message"); %>
        <%
            try {

        %> 

        <div>
            <div class="row bg-default">
                <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
                <div class="col-md-8"><center><h1>Gestión de Formularios</h1></center></div>
                <div class="col-md-2"></div>
            </div>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation"><a href="publicarUsuario.jsp">Volver</a></li>
            </ul>
        </div>
        <%            DB con = DB.getInstancia();
            Connection co = con.getConnection();
            LinkedList<Formulario> listaF = new LinkedList<Formulario>();
            LinkedList<Grupo> listaG = new LinkedList<Grupo>();
            LinkedList<Preguntas> listaP = new LinkedList<Preguntas>();
            LinkedList<TipoPreguntas> listaTP = new LinkedList<TipoPreguntas>();
            LinkedList<Valores> listaV = new LinkedList<Valores>();
            String NombreF = request.getParameter("Submit");
            int Cod = Integer.parseInt(NombreF);
            ResultSet rs = co.prepareStatement("SELECT * FROM UTIC.UZGTFORMULARIOS WHERE codigo_UZGTFORMULARIOS = '" + Cod + "'").executeQuery();
            while (rs.next()) {
                Formulario F = new Formulario();
                F.setCodigo_formulario(rs.getInt(1));
                F.setNombre_formulario(rs.getString(2));
                F.setDescripcion_formulario(rs.getString(3));
                F.setFecha_formulario(rs.getDate(4));
                F.setObjetivo_formulario(rs.getString(5));
                F.setBase_formulario(rs.getString(6));
                listaF.add(F);
            }
            rs.close();
            rs = co.prepareStatement("SELECT * FROM UTIC.UZGTGRUPO WHERE codigo_UZGTFORMULARIOS = '" + Cod + "' order by codigo_UZGTGRUPO ASC").executeQuery();
            while (rs.next()) {
                Grupo G = new Grupo();
                G.setCodigo_formulario(rs.getInt(1));
                G.setCodigo_grupo(rs.getInt(2));
                G.setNombre_grupo(rs.getString(3));
                G.setDescripcion_grupo(rs.getString(4));
                listaG.add(G);
            }
            rs.close();
            rs = co.prepareStatement("SELECT * FROM UTIC.UZGTPREGUNTAS WHERE codigo_UZGTFORMULARIOS = '" + Cod + "' order by codigo_UZGTPREGUNTAS ASC").executeQuery();
            while (rs.next()) {
                Preguntas P = new Preguntas();
                P.setCodigo_formulario(rs.getInt(1));
                P.setCodigo_grupo(rs.getInt(2));
                P.setCodigo_preguntas(rs.getInt(3));
                P.setCodigo_tipo_pregunta(rs.getInt(7));
                P.setLabel_pregunta(rs.getString(8));
                listaP.add(P);
            }
            rs.close();
            rs = co.prepareStatement("SELECT * FROM UTIC.UZGTVALORES WHERE codigo_UZGTFORMULARIOS = '" + Cod + "' order by codigo_UZGTVALORES").executeQuery();
            while (rs.next()) {
                Valores Val = new Valores();
                Val.setCodigo_Valores(rs.getInt(1));
                Val.setCodig_Formularios(rs.getInt(2));
                Val.setCodigo_Grupo(rs.getInt(3));
                Val.setCodigo_Preguntas(rs.getInt(4));
                Val.setValores(rs.getString(5));
                listaV.add(Val);
            }
            rs.close();
            String query = request.getParameter("query");
            out.print(Cod);
            out.print(query);
            ///////////////////////////////////////////////////////////////////////////////
            /*INSERT RESTRICCION*/
            try {
                //String sql= "INSERT INTO UTIC.UZGTFORMULARIO_PERSONA (SPRIDEN_PIDM,CODIGO_UZGTFORMULARIOS_PERSONA,CODIGO_UZGTFORMULARIOS,UZGTFORMULARIOS_PERSONA_FECHA) VALUES (?,?,?,?)";
                PreparedStatement ps = co.prepareStatement(query);
                ps.executeUpdate();
                out.println("INSERT RESTRICCION");
            } //out.println("<center><div class=\"alert alert-success\"><strong>Exito!</strong> Se Guardo correctamente</div></center>");
            catch (Exception ex) {
                out.println("ERROR INSERT RESTRICCION" + ex);
            }
            out.print("<form action=\"\" method=\"POST\" target=\"_self\" style=\"display:inline;\">");
            out.println("<br><div class=\"col-md-10\"><center><button class=\"btn btn-default\" type=\"submit\" name=\"Submit\" onclick=\"this.form.action='publicarUsuario.jsp';this.form.submit();\" value=\"" + Cod + "\">Volver</button></center></div>");
            out.print("</div></form>");
            con.closeConexion();
        %>
        <%             } catch (Exception e) {
                System.out.println("error." + e.getMessage());

            }
        %>

    </body>
</html>

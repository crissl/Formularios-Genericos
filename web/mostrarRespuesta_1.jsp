<%-- 
    Document   : mostrarFormulario
    Created on : 14-ene-2018, 21:55:20
    Author     : D4ve
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.LinkedList"%>
<%@page import="FORM.Formulario"%>
<%@page import="FORM.DB"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.Usuario"%> <!-- import de Usuario -->
<%@page session="true" %> <!-- Se agrega a modo de validacion -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Usuario currentUser = (Usuario) (session.getAttribute("currentSessionUser")); //Recibe el atributo de sesion del Servlet
/*Si el atributo es diferente de nulo muestra la pagina */
    if (currentUser != null) { %>
<head>
  

<div class="row bg-default"></br>
    <div class="col-md-2"><center><a href="index.jsp"><img src="Logo_ESPE.png"  WIDTH="125" HEIGHT="100"/></a></center></div></br>
    <div class="col-md-8" style="color:green;"><center><div  class='text alert alert-success'><p style='color:green;'><strong><h2>Mostrar Respuestas<Formulario</h2></strong></p></div></div>
    <div class="col-md-2"></div></br>
</div>
<ul class="nav nav-tabs " role="tablist">

    <%
        out.print("<li class=\"navbar navbar-inverse navbar-fixed-top navbar-custom\" role=\"presentation\"><a style=\"color:black;\"  href=\"NewForm.jsp\"><img src=\"n.png\"/><strong> Nuevo Formulario</strong></a></li>");
        out.print("<li class=\"navbar navbar-inverse navbar-fixed-top navbar-custom\" role=\"presentation\"><a style=\"color:black;\" href=\" mostrarFormulario.jsp\"><img src=\"m.png\"/><strong> Gestión Formulario</strong></a></li>");
        out.print("<li class=\"navbar navbar-inverse navbar-fixed-top navbar-custom\" role=\"presentation\"><a style=\"color:black;\" href=\"mostrarGRes.jsp?param=\"null\"\"><img src=\"pm.png\"/><strong> Formularios Publicados</strong></a></li>");
        out.print("<li class=\"navbar navbar-inverse navbar-fixed-top navbar-custom\" role=\"presentation\"><a style=\"color:black ;\" href=\"mostrarRespuesta.jsp\"><img src=\"a.png\"/><strong> Mostrar Respuestas</strong></a></li></br>");
    %>
</ul>

<meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
<title>Mostrar-Formularios</title>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<%
    DB con = DB.getInstancia();
    Connection co = con.getConnection();
    LinkedList<Formulario> listaF = new LinkedList<Formulario>();
    ResultSet rs = co.prepareStatement("SELECT * FROM UTIC.UZGTFORMULARIOS ORDER BY codigo_UZGTFORMULARIOS ASC").executeQuery();
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


%>

</head>  
<style>.navbar-custom {
            color: #FFFFFF;
            background-color: #229954 ;
            border-color: #000
        }
    </style>

<%--<li role="presentation"><a  href="mostrarGRes.jsp" >Volver</a></li>--%>
</br></ul>
<form action="LoginServlet" method="POST">
    <div class="row">
        <div class="col-md-3"></div>

        <div class="col-md-3"></div>
    </div>
    <%        for (int i = 0; i < listaF.size(); i++) {

            String cod = "";
            out.print("<form action=\"\" method=\"POST\" target=\"_self\" style=\"display:inline;\"><center>");
            out.println("</center></div>");
            out.print("<div class=\"row\">");
            out.print("<div class=\"col-md-2\"></div>");
            out.print("<div class=\"col-md-1\"><p id=\"cod\">" + listaF.get(i).getCodigo_formulario() + "</p></div>");
            out.print("<div class=\"col-md-4\"><p name=\"nombre\">" + listaF.get(i).getNombre_formulario() + "</p></div>");
            out.print("<div class=\"col-md-3\"><button class=\"btn btn-default\" type=\"text\" name=\"Submit\" onclick=\"this.form.action='mostrarFormularioUsuario_1.jsp';this.form.submit();\" value='" + cod + listaF.get(i).getCodigo_formulario() + "'>Ver</button></div>");
            out.print("</div></form>");
            //out.print("<form action=\"publicarUsuario.jsp\" method=\"POST\" target=\"_self\" style=\"display: inline;\">");
            //out.print("<div class=\"row\">");
            //out.print("<div class=\"col-md-3\"><button class=\"btn btn-default\" type=\"text\" name=\"enviar\" value='"+cod+listaF.get(i).getCodigo_formulario()+"'>Publicar</button></div>");
            //out.print("</div></form>");
        }
        con.closeConexion();
        /*
        for(int i=0; i<listaF.size();i++)
        {
                            
            String cod = "";
            out.println("<form action=\"publicarUsuario.jsp\" method=\"POST\" target=\"_self\">");
            out.println("<div class=\"col-md-4\"><button class=\"btn btn-default\" type=\"text\" name=\"enviar\" value='"+cod+listaF.get(i).getCodigo_formulario()+"'>Publicar</button></div>");
            out.println("</div></form>");
        }*/

    %>
</form>  
<% } else {

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet"></link>
        <title>No Autorizado</title>
    </head>
    <body>
        <%@page import="org.apache.log4j.Logger"%>
        <%! static Logger logger = Logger.getLogger("bitacora.subnivel.Control");%>
        <%logger.info("esta es la prueba."); %>
        <%logger.debug("Demostracion del mensaje");%>
        <%logger.warn("Show WARN message");%>
        <%logger.error("Show ERROR message");%>
        <%logger.fatal("Show FATAL message"); %>
        <%             try {

        %>
        <ul class="nav nav-tabs" role="tablist">




            <div class="col-md-4">Error! Usuario no autorizado</div>


        </form>


    </ul>
    <%             } catch (Exception e) {
            System.out.println("error." + e.getMessage());

        }
    %>
</body>
</html>



<% }%>
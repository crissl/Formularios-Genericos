<%-- 
    Document   : Message
    Created on : 9/03/2018, 09:56:12 AM
    Author     : D4ve
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensaje</title>
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

        <center>

            <div id="imprimir">
                <div class="row bg-default">
                    <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
                    <div class="col-md-8"><center><h1>Gesti�n de Formularios</h1></center></div>
                    <div class="col-md-2"></div>
                </div>
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation"><a href="almacenarR.jsp">Volver</a></li>
                </ul>
                <center><div class="alert alert-success"><strong>Exito!</strong><%=request.getAttribute("Message")%></center></div>
        </center>

        <%
            } catch (Exception e) {
                System.out.println("error." + e.getMessage());

            }
        %>
    </body>
</html>
<%-- 
    Document   : index
    Created on : 22-jun-2016, 18:04:45
    Author     : david
--%>

<%@page import="FORM.ParametrosBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script>

            window.onload = function () {

                // Una vez cargada la página, el formulario se enviara automáticamente.
                //vent=window.open('','123','width=725,height=600,scrollbars=no,resizable=yes,status=yes,menubar=no,location=no');
                document.forms["login"].submit();

            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet"></link>
        <title>Pagina Principal</title>
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

        <div class="row bg-default">
            <div class="col-md-4"><img src="espelogo.jpg"/></div>
            
           <div class="col-md-3.5"><p style='color:green;'><strong><h2 class='text alert alert-success'>Gestión de Formulario<strong><Formulario</h2></strong></p></div></div>
            
            
        </div>

        <%--<div class="container">--%> 
        <ul class="nav nav-tabs" role="tablist">

            <li role="presentation"><a href="Test.jsp?param="  style= "color:green;">Gestión de Formularios</a></li> 
        </ul>
        <form action ="LoginServlet" method="POST" >



        </form> 
        </br></br></br><center><img src="formularios2.png"  width="350" height="341">

        <%--</div> <!-- /container -->--%>
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>        
        <!--JQuery (necesaria para los plugins de JavaScript de Bootstrap) --> 
        <script src = "js/jquery.min.js" ></script>
        <!-- incluir todos los plugins compilados (abajo), o incluir archivos individuales según sea necesario --> 
        <script src = "js/bootstrap.min.js" ></script> 
        <%             } catch (Exception e) {
                System.out.println("error." + e.getMessage());

            }
        %>
    </body>
</html>
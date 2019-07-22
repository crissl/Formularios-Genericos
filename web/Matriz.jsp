<%-- 
    Document   : Matriz
    Created on : 09/09/2016, 12:09:03 PM
    Author     : Jorge
--%>



<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<%@page import="FORM.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>        
    <head>
        <meta name="description" content="Guia 1 HTML/JavaScript - ADSI 259128"/>
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script> $(document).ready(function ()
            {
        $(
                    '[data-toggle="tooltip"]'
        ).tooltip();
            });
        </script>
        <script>
            /*function valMatriz(fil, col){
             if(fil>5){
             alert('A sobrepasado el tamaño máximo permitido')
             }else if(col>5){
             alert('A sobrepasado el tamaño máximo permitido')
             }else if(fil>5 && col>5){
             alert('A sobrepasado el tamaño máximo permitido')
             }else{
             genMatrices(fil, col);
             }
             }*/
            try {
            function genMatrices(fil
            }, col) {
                            c = new String();
                            e = document.getElementById('Matriz');
                            c += '<table name"tblMatriz" id="tblMatriz" border=1>';
                            c += '<tr>';
 
                            c += '<td align="center" valing="middle">';
                            c += '<table name="tblMtz">';
                            for (i = 0; i <= fil; i++) {
                                c += '<tr>';
                                for (j = 0; j <= col; j++) {
                                    c += '<td><input type="text" name=' + i + j + ' id=' + i + j + ' size="30" maxlength="30" placeholder=' + i + j + '></td>';
                                }
                                c += '</tr>';
                            }
                            c += '</table>';
                            c += '</td>';
                            e.innerHTML = c;     
                        }
            } catch (Exception e) {
            System.out.println("tienes un error." + e.getMessaage());
            }
        </script>
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
            <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
            <div class="col-md-8"><center><h1>Formularios Genericos</h1></center></div>
            <div class="col-md-2"></div>
        </div>
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation"><button align="center" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Volver"><a href="mostrarFormulario.jsp"><i class='fas fa-arrow-left' style='font-size:40px;color:white'></i></a></button></li>

        </ul>
        <form action="nuevaMatriz.jsp" name="frmArreglo" id="frmArreglo">
            <hr/>
            <h2 align="center">DESCRIPCION MATRIZ</h2>
            <table align="center" border="1">
                <tr>
                    <td>
                        <table table-responsive>
                            <tr>
                                <td align="center" colspan="7">
                            <div class="col-md-12"><h5>Descripcion de la Matriz: </h5></div>
                            <div class="col-md-12"><center><input id="descripcion" type="text" name="descripcion" class="form-control" placeholder="DESCRIPCION MATRIZ" required/></center></div>
                </tr>

            </table></td>
    </tr>
</table>
<h2 align="center">INGRESO DE MATRICES</h2>
<table align="center" border="1">
    <tr>
        <td>
            <table>
                <tr>
                    <td align="center" colspan="4"><b>MATRIZ A GENERAR</b></td>
                </tr>
                <tr>
                    <td>Filas:</td><td>
                        <div class="col-md-8"><center><input id="filas" type="number" name="filas" class="form-control" placeholder="numero de filas" required/></center></div>


                        </div>
                    </td><td>Columnas:</td><td>
                        <div class="col-md-8"><center><input id="columnas" type="number" name="columnas" class="form-control" placeholder="numero de filas" required/></center></div>

                        </div>
                </tr>

            </table></td>
    </tr>
</table>

<br />


<div align="center">
    <button class="btn btn-success" type="submit" name="Submit" value="guardar"><strong>Aceptar</strong></button>
</div>



<br/>
<div id="Matriz">
</div>
</form>

<%             } catch (Exception e) {
        System.out.println(" error." + e.getMessage());

    }
%>

</body>
</html>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="FORM.Valores"%>
<%@page import="FORM.TipoPreguntas"%>
<%@page import="FORM.Preguntas"%>
<%@page import="FORM.Grupo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="FORM.Formulario"%>
<%@page import="FORM.FormPersona"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Publicar Formulario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            
        <div class="row bg-default">
            <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
            <div class="col-md-8"><center><h1>Gesti�n de Formularios</h1></center></div>
        <div class="col-md-2"></div>
        </div>
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation"><button align="center" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Volver"><a href="mostrarFormulario.jsp"><i class='fas fa-arrow-left' style='font-size:40px;color:white'></i></a></button></li>
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
            String eF = request.getParameter("estadoSeg");
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
                F.setQueryP(rs.getString(12));
                F.setEstadoPublicacion(rs.getInt(9));
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
            con.closeConexion();
            %>
            <%if (listaF.getFirst().getEstadoPublicacion() == 0) {%>
        <form action="estadoPublicacion.jsp" method="POST">


        <div class="container">
        <%
                    out.println("<div class=\"row\">");
                    out.println("<div class=\"col-md-3\"></div>");
            out.println("<div class=\"col-md-6\"><center><h4 class=\"text-success\">" + "Nombre del Formulario: " + listaF.getFirst().getNombre_formulario() + "</h4></center></div>");
                    out.println("</div>");
        %>
        <h3>Selecciona el/los grupos de usuarios:</h3> 
                <textarea name="query" rows="5" cols="150" class="panel-body" placeholder="Ingrese el query de b�squeda"></textarea>
                <h3>Fecha de vigencia</h3><br>
        <ul><div class="col-md-2"><h4>Desde: </h4></div>
                <li class="col-md-3"><label for="fechaInicio" class="sr-only">fechaInicio</label><input id="fechaInicio" type="date" name="fechaInicio" class="form-control" placeholder="fechaInicio" required/></li>
        <div class="col-md-2"><h4>Hasta: </h4></div>
            <li class="col-md-3"><label for="fechaFin" class="sr-only">fechaFin</label><input id="fechaFin" type="date" name="fechaFin" class="form-control" placeholder="fechaFin" required/></li></ul>
        <br><br>
        <h3>Estado de Formulario</h3>       
        <div class="col-md-2"><h4>Escoja una opcion: </h4></div>
                <div class="col-md-3"><select  name="estadoSeg" type= "text" class="form-control" required>
                <option <text selected  value= "A" </text>Activo</option>
                <option <text selected  value= "I"  </text>Inactivo</option>   
        <!--<option <text selected  value= "T"  </text>Terminado</option>-->
            </select>
            </div>    
            <br><br>
            <h3>Tipo Formulario</h3>
            <div class="col-md-2"><h4>Elija una opci�n: </h4></div>
            <div class="col-md-3"><select  name="tipoFormulario" onchange="yesnoCheck(this);" class="form-control" required>
                <option selected value="1">Obligatorio</option>
                <option selected value="0">Opcional</option>
                </select>
          
                
                </div>
                
                <div id="ifYes" style="display: none;">
            <textarea name="queryRes" rows="5" cols="150" class="panel-body" placeholder="Ingrese el query de restriccion"></textarea>
                </div>
        <%-- <div class="col-md-3"><button class="btn btn-default" type="submit" name="Submit" value="restriccion">Generar Restricci�n</button></div>--%> 

    </div>
</div><br><br>
<%
            out.println("<div class=\"col-md-10\"><center><button class=\"btn btn-success btn-lg\" type=\"submit\" name=\"Submit\" onclick=\"this.form.action='estadoPublicacion.jsp';this.form.submit();\" value=\"" + Cod + "\">Publicar</button></center></div>");
            out.println(" <button align=\"center\" class=\"btn btn-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Volver\"> <div class=\"col-md-3\"><a href=\"mostrarRespuesta.jsp?Submit=\"" + Cod + "\" ><i class='fas fa-arrow-left' style='font-size:40px;color:white'></i></a></button>");
%>          
    </form>
<%} else {%>
    <form action="estadoPublicacion.jsp" method="POST">


        <div class="container">
<%
                out.println("<div class=\"row\">");
                out.println("<div class=\"col-md-3\"></div>");
                out.println("<div class=\"col-md-6\"><center><h4 class=\"text-success\">" + "Nombre del Formulario: " + listaF.getFirst().getNombre_formulario() + "</h4></center></div>");
                out.println("<div class=\"col-md-12\"><center><h4 class=\"text-success\">" + "El Formulario ya est� PUBLICADO" + "</h4></center></div>");
                out.println("</div>");
%>
<h3>Selecciona el/los grupos de usuarios:</h3> 
<% out.println("<textarea name=\"query\" rows=\"5\" cols=\"150\" class=\"panel-body\" value=\"" + listaF.getFirst().getQueryP() + "\">" + listaF.getFirst().getQueryP() + "</textarea>");%>
            <h3>Fecha de vigencia</h3><br>
                <div class="col-md-2"><h4>Desde: </h4></div>
               <div class="col-md-3"> <label for="fechaInicio" class="sr-only">fechaInicio</label><input id="fechaInicio" type="date" name="fechaInicio" class="form-control" placeholder="fechaInicio" required/></div>
                <div class="col-md-2"><h4>Hasta: </h4></div>
                <div class="col-md-3"><label for="fechaFin" class="sr-only">fechaFin</label><input id="fechaFin" type="date" name="fechaFin" class="form-control" placeholder="fechaFin" required/></div>
                <br><br>

            <h3>Estado de Formulario</h3>       
            <div class="col-md-2"><h4>Escoja una opcion: </h4></div>
            <div class="col-md-3"><select  name="estadoSeg"   type= "text" class="form-control" required>
                    <option <text selected  value= 'A'  </text>Activo</option>
                    <option <text selected  value= 'I'  </text>Inactivo</option>   
                  <!--  <option <text selected  value= 'T'  </text>Terminado</option>-->
                </select>
            </div> 
            <br><br>
            <h3>Tipo Formulario</h3>
            <div class="col-md-2"><h4>Elija una opci�n: </h4></div>
            <div class="col-md-3"><select  name="tipoFormulario" onchange="yesnoCheck(this);" class="form-control" required>
                    <option selected value="1">Obligatorio</option>
                    <option selected value="0">Opcional</option>
                </select>

            </div>

            <div id="ifYes" style="display: none;">
                <textarea name="queryRes" rows="5" cols="150" class="panel-body" placeholder="Ingrese el query de restriccion"></textarea>
            </div>
<%-- <div class="col-md-3"><button class="btn btn-default" type="submit" name="Submit" value="restriccion">Generar Restricci�n</button></div>--%> 

        </div>
    </div><br><br>
<%
        out.println("<div class=\"col-md-12\"><center><button class=\"btn btn-success btn-lg\" type=\"submit\" name=\"Submit\" onclick=\"this.form.action='estadoPublicacion.jsp';this.form.submit();\" value=\"" + Cod + "\", \"" + eF + "\" >Publicar</button></center></div>");
       
%>



<%}%>
<%             } catch (Exception e) {
            System.out.println("error." + e.getMessage());

        }
%>

    </body>

    <script>
        function yesnoCheck(that) {
            if (that.value == "1") {

                document.getElementById("ifYes").style.display = "block";
            } else {
                document.getElementById("ifYes").style.display = "none";
            }
        }
</script>
</html>

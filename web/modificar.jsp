<%-- 
    Document   : modificar.jsp
    Created on : 18/12/2017, 9:40:36
    Author     : DIEGOPC
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="FORM.Cabecera"%>
<%@page import="FORM.Matriz"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="FORM.Valores"%>
<%@page import="FORM.TipoPreguntas"%>
<%@page import="FORM.Preguntas"%>
<%@page import="java.util.LinkedList"%>
<%@page import="FORM.Grupo"%>
<%@page import="FORM.Formulario"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Modificación-Formularios</title>
        <link href="css/bootstrap3.min.css" rel="stylesheet"/>
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
        <%
            request.setCharacterEncoding("UTF-8");
            DB con = DB.getInstancia();
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
        %>
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
        <%--    <li role="presentation"><a href="mostrarFormulario.jsp">Volver</a></li>--%>
        </ul>
        <form action="modificado.jsp" method="POST">
            <div class="container">
                <%                request.setCharacterEncoding("UTF-8");
                    out.println("<div class=\"row\">");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("<div class=\"col-md\"><input type=\"text\" class=\"col-md-6 panel panel-info panel-heading\" name=\"nombreF\" value=" + "\"" + listaF.getFirst().getNombre_formulario() + "\"/></center></div>");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("</div>");

                    for (int i = 0; i < listaG.size(); i++) {
                    out.println("</br><div class=\"row\">");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("<div class=\"col-md-6\"><center><input class=\"col-md-6 panel panel-info panel-heading\" name=\"nomG" + i + "\"  value=" + "\"" + listaG.get(i).getNombre_grupo() + "\"/></center></div>");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("</div>");

                    for (int j = 0; j < listaP.size(); j++) {
                            if (listaP.get(j).getCodigo_grupo() == listaG.get(i).getCodigo_grupo()) {
                    out.println("<div class=\"row\">");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("<input class=\"col-md-6 panel panel-info panel-heading\" name=\"nomP" + i + "\" value=" + "\"" + listaP.get(j).getLabel_pregunta() + "\"/>");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("</div>");

                                if (listaP.get(j).getCodigo_tipo_pregunta() == 1) {

                                    //out.println("</br><div class=\"col-md-3\"><input id=\"valor\" type=\"text\" name=\"valor\" class=\"form-control\"/></div>");
                                
                                }

                                if (listaP.get(j).getCodigo_tipo_pregunta() == 2) {
                                    out.println("</div>");
                                    for (int k = 0; k < listaV.size(); k++) {
                                        if (listaV.get(k).getCodigo_Preguntas() == listaP.get(j).getCodigo_preguntas()) {
                                            out.println("<div class=\"row\">");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-6\"><label><input type=\"text\" name=\"Seleccion" + k + "\" value=" + "\"" + listaV.get(k).getValores() + "\"/></input></label></div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("</div>");
                                        }
                                    }
                                }
                                if (listaP.get(j).getCodigo_tipo_pregunta() == 3) {
                                    out.println("</div>");
                                    for (int k = 0; k < listaV.size(); k++) {
                                        if (listaV.get(k).getCodigo_Preguntas() == listaP.get(j).getCodigo_preguntas()) {
                                            out.println("<div class=\"row\">");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-6\"><input type=\"text\" name=\"seleccion" + k + "\" value=" + "\"" + listaV.get(k).getValores() + "\"/></input></div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("</div>");
                                        }
                                    }
                                }
                                if (listaP.get(j).getCodigo_tipo_pregunta() == 5) {
                                    
                                    out.println("<div class=\"row\">");
                                    out.println("<div class=\"col-md-3\"></div>");
                                    out.println("<div class=\"col-md-3\"><select type=\"text\" name=\"lista\">");
                                    out.println("<div class=\"col-md-3\"></div></br>");
                                  
                                    for (int k = 0; k < listaV.size(); k++) {
                                        if (listaV.get(k).getCodigo_Preguntas() == listaP.get(j).getCodigo_preguntas()) {

                                            out.println("<option>" + listaV.get(k).getValores() + "</option>");

                                        }
                                    }
                                    out.println("</select></br>");
                                    out.println("</div></br>");
                                }
                                if (listaP.get(j).getCodigo_tipo_pregunta() == 4) {
                                   
                                    out.println("</br><div class=\"row\">");
                                    out.println("<div class=\"col-md-3\"></div>");
                                    
                                    ResultSet rs2 = co.prepareStatement("SELECT * FROM UTIC.UZGTMATRIZ WHERE codigo_UZGTPREGUNTAS = '" + listaP.get(j).getCodigo_preguntas() + "'order by codigo_uzgtmatriz ASC").executeQuery();
                                    LinkedList<Matriz> ListaMatriz = new LinkedList<Matriz>();
                                    LinkedList<Cabecera> ListaCabeceras = new LinkedList<Cabecera>();
                                    while (rs2.next()) {
                                        Matriz Mat = new Matriz(rs2.getInt(1), rs2.getInt(2), rs2.getInt(3), rs2.getInt(4), rs2.getInt(5), rs2.getInt(6), rs2.getString(7));
                                        ListaMatriz.add(Mat);
                                    }
                                    rs2.close();
                                    int mat = ListaMatriz.getFirst().getCodigo_matriz();
                                    int filas = ListaMatriz.getFirst().getFila() + 1;
                                    int columnas = ListaMatriz.getFirst().getColumna() + 1;
                                    ResultSet rs3 = co.prepareStatement("SELECT * FROM UTIC.UZGTCABECERAS WHERE codigo_UZGTMATRIZ = '" + mat + "' order by codigo_uzgtcabezera ASC").executeQuery();
                                    while (rs3.next()) {
                                        Cabecera Cab = new Cabecera(rs3.getInt(1), rs3.getInt(2), rs3.getString(3), rs3.getInt(4), rs3.getInt(5));
                                        ListaCabeceras.add(Cab);
                                    }
                                    rs3.close();
                                    out.println("<div class=\"col-md-6 table-responsive\"><table class=\"table table-bordered\">");
                                    int puntero = 0;
                                    for (int n = 0; n < filas; n++) {
                                        out.println("<tr>");
                                        for (int m = 0; m < columnas; m++) {

                                            if (puntero < ListaCabeceras.size() && ListaCabeceras.get(puntero).getPosicionX() == n && ListaCabeceras.get(puntero).getPosicionY() == m) {
                                                out.println("<th>" + ListaCabeceras.get(puntero).getValor_cabecera() + "</th>");
                                                puntero++;
                                            } else {
                                                out.println("<td><input type=\"text\" name=\"Texto\" placeholder=\"Texto\"'></td>");
                                            }
                                        }
                                        out.println("</tr>");
                                    }
                                    out.println("</table></div>");
                                    out.println("</div></br>");
                                }
                            }
                        }
                    }
                    out.println("<div class=\"row\">");
                    out.println("<div class=\"col-md-3\"></div>");
                    out.println("<div class=\"col-md-6\"><center><button class=\"btn btn-success btn-lg\" type=\"text\" name=\"Submit\" value='" + Cod + "'>Modificar</button></center></div>");
                    out.println("<div class=\"col-md-3\"align=\"center\"><button align=\"center\" class=\"btn btn-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Volver\"><a href=\"mostrarFormulario.jsp\"><i class=\"fas fa-arrow-left\" style=\"font-size:40px;color:white\"></i></a></button></div>");
                    out.println("</div>");
                %>
                
            </div><br>
        </form>

        <%
            /*
                            
                            ResultSet rs2 = co.prepareStatement("SELECT * FROM UTIC.UZGTMATRIZ WHERE codigo_UZGTFORMULARIOS = '"+listaF.getFirst().getCodigo_formulario()+"'order by codigo_uzgtmatriz ASC").executeQuery();
                            LinkedList<Matriz> ListaMatriz = new LinkedList<Matriz>();
                            LinkedList<Cabecera> ListaCabeceras = new LinkedList<Cabecera>();     
                            while(rs2.next())
                            {
                                Matriz Mat = new Matriz(rs2.getInt(1),rs2.getInt(2),rs2.getInt(3),rs2.getInt(4),rs2.getInt(5),rs2.getInt(6),rs2.getString(7));
                                ListaMatriz.add(Mat);                
                            }
                            rs2.close();
                            for(int m=0;m<ListaMatriz.size();m++)
                            {
                                try{
                                    co.prepareStatement("UPDATE UTIC.UZGTCABECERAS SET  = WHERE codigo_UZGTMATRIZ='"+ListaMatriz.get(m).getCodigo_matriz()+"'").executeQuery();
                                }
                                catch (SQLException ex)
                                {
                                    out.println("cabecera no modificada.");
                                }
                                try{
                                    co.prepareStatement("DELETE FROM UTIC.UZGTMATRIZ WHERE codigo_UZGTMATRIZ = '"+ListaMatriz.get(m).getCodigo_matriz()+"'").executeQuery();
                                }
                                catch (SQLException ex)
                                {
                                    out.println("matriz no modificada.");
                                }
                            }
                            /* try
                            {
                                co.prepareStatement("UPDATE UTIC.UZGTVALORES SET codigo_UZGTFORMULARIOS='"+listaF.getFirst().get +"'").executeUpdate();
                                out.println("Valor eliminado.");
                            }
                            catch (SQLException ex)
                            {
                                out.println("valor no eliminado.");
                            }
                            try
                            {
                                co.prepareStatement("UPDATE UTIC.UZGTPREGUNTAS SET  UZGTPREGUNTAS="+listaP.getFirst()+" WHERE codigo_UZGTFORMULARIOS ='"+listaF.getFirst().getCodigo_formulario()+"'").executeUpdate();
                                out.println("pregunta modificada.");
                            }
                            catch (SQLException ex)
                            {
                                out.println("pregunta no modificado.");
                            }
                            /* try
                            {
                                co.prepareStatement("UPDATE SET UZGTGRUPO='"+request.getParameter(name) " FROM UTIC.UZGTGRUPO WHERE codigo_UZGTFORMULARIOS ='"+listaF.getFirst().getCodigo_formulario()+"'").executeUpdate();
                                out.println("grupo modificado.");
                            }catch (SQLException ex){
                                out.println("grupo no modificado.");
                            } */
            con.closeConexion();


        %>

        <%             } catch (Exception e) {
                System.out.println("error." + e.getMessage());

            }
        %>

    </body>
</html>


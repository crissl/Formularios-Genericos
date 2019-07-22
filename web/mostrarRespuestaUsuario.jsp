<%-- 
    Document   : mostrarRespuestaUsuario
    Created on : 15/03/2018, 12:52:15
    Author     : DIEGOPC
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="FORM.FormPersona"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="FORM.Cabecera"%>
<%@page import="FORM.Matriz"%>
<%@page import="FORM.TipoPreguntas"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="FORM.Formulario"%>
<%@page import="FORM.Grupo"%>
<%@page import="FORM.Preguntas"%>
<%@page import="FORM.Valores"%>
<%@page import="FORM.Respuestas"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario-Respuesta</title>
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

        <%            DB con = DB.getInstancia();
            Connection co = con.getConnection();
            LinkedList<Formulario> listaF = new LinkedList<Formulario>();
            LinkedList<Grupo> listaG = new LinkedList<Grupo>();
            LinkedList<Preguntas> listaP = new LinkedList<Preguntas>();
            LinkedList<TipoPreguntas> listaTP = new LinkedList<TipoPreguntas>();
            LinkedList<Valores> listaV = new LinkedList<Valores>();
            LinkedList<Respuestas> listaR = new LinkedList<Respuestas>();
            FormPersona fp = new FormPersona();
            String pidmS = request.getParameter("pidm");
            int pidm = Integer.parseInt(pidmS);
            //int usPidm=2401;
            String NombreF = request.getParameter("Submit");
            int Cod = Integer.parseInt(NombreF);
            String iteracion = request.getParameter("iter");
            int iter = 0;
            if (iteracion != null) {
                iter = Integer.parseInt(iteracion);
            }
            //JOptionPane.showMessageDialog(null, iter+" es la iteracion");          
            //JOptionPane.showMessageDialog(null, "Pidm: "+pidm+"CodForm: "+Cod);
            /*aqui obtengo el "codigo form persona" que pertenece al "formulario" que seleccion y el "pidm"*/
            try {
                //JOptionPane.showMessageDialog(null, "try: ");
                ResultSet rest = co.prepareStatement("select * from uzgtrespuestas where codigo_uzgtformularios=" + Cod + " and spriden_pidm=" + pidm).executeQuery();
                while (rest.next()) {
                    //JOptionPane.showMessageDialog(null, "codigo fp: "+rest.getInt(2));
                    fp.setCodFormP(rest.getInt(2));
                }
                rest.close();

            } catch (SQLException er) {
                //JOptionPane.showMessageDialog(null, ""+er.getSQLState());
            }
            //JOptionPane.showMessageDialog(null, "Codigo Formulario Persona: "+fp.getCodFormP());
            /*obtener datos del formulario*/
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
            rs = co.prepareStatement("SELECT * FROM UTIC.UZGTVALORES WHERE codigo_UZGTFORMULARIOS = '" + Cod + "' order by codigo_UZGTPREGUNTAS ASC").executeQuery();
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
            /*selecciono las respuestas de acuerdo al "pidm", "cod_form_persona" y "codigo_form"*/
            int conC = 0;

            rs = co.prepareStatement("select * from uzgtrespuestas where codigo_UZGTFORMULARIOS=" + Cod + " and codigo_uzgtformularios_persona=" + fp.getCodFormP() + " and spriden_pidm=" + pidm + " and uzgtrespuestas_iteracion=" + iter + " ORDER BY CODIGO_UZGTRESPUESTAS ASC").executeQuery();

            //rs = co.prepareStatement("select * from uzgtrespuestas where codigo_UZGTFORMULARIOS="+Cod+" and codigo_uzgtformularios_persona="+fp.getCodFormP()+" and spriden_pidm="+pidm+" and uzgtrespuestas_iteracion="+iter+" order by codigo_uzgtrespuestas asc").executeQuery();
            while (rs.next()) {
                Respuestas res = new Respuestas();
                //res.setPidm_usuario(1234);
                res.setCodigo_persona(rs.getInt(2));
                res.setCodigo_formulario(rs.getInt(3));
                res.setCodigo_grupo(rs.getInt(4));
                res.setCodigo_preguntas(rs.getInt(5));
                res.setCodigo_Respuestas(rs.getInt(6));
                res.setValor_Respuestas(rs.getString(7));
                listaR.add(res);
            }

            rs.close();

            if (listaR.isEmpty()) {
                out.print("<div id=\"imprimir\">");
                out.print("<div class=\"row bg-default\">");
                out.print("<div class=\"col-md-2\"><center><img src=\"espelogo.jpg\"/></center></div>");
                out.print("<div class=\"col-md-2\"></div>");
                out.print("</div>");
                out.print("<ul class=\"nav nav-tabs\" role=\"tablist\">");
                out.print("<li role=\"presentation\" ><a href=\"mostrarFormularioUsuario.jsp?Submit=" + Cod + "\" >Volver</a></li>");
                out.print("</ul>");
                out.print("<div class=\"container\">");
                out.print("<center><div class=\"alert alert-info\">El usuario con el pidm seleccionado no ha llenado el formulario</div></center>");
            } else {

        %>
        <div id="imprimir">
            <div class="row bg-default">
                <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
                <div class="col-md-2"></div>

            </div>
            <%--
         out.print("<li fas fa-sign-in-alt role=\"presentation\"><a href=\"mostrarFormularioUsuario.jsp?Submit=" + Cod + "\" >Volver</a></li> ");
             
            --%> 



        </ul>
        <div class="container">

            <!--PARTE AGREGADA PARA PROBAR IMPRESION JUNTO CON RESPUESTAS-->

            <div class="container" class="col-md-10">
                <% out.println("<div class=\"row\">");
                        out.println("<div class=\"col-md-3\"></div>");
                        out.println("<div class=\"col-md-6\" align=\"center\"><h5 class=\"text-uppercase\">" + listaF.getFirst().getNombre_formulario() + "</h5></div>");
                        out.println("</div>");
                        out.println("<div class=\"row\">");
                        out.println("<div class=\"col-md-3\"></div>");
                        out.println("<div class=\"col-md-6\" align=\"justify\"><h6 class=\"text-success text-uppercase\">" + " *" + listaF.getFirst().getDescripcion_formulario() + "</h6></div>");
                        out.println("</div>");
                        int numT1 = 0;
                        int numC1 = 0;
                        int numR1 = 0;
                        int numL1 = 0;
                        int numFech1 = 0;
                        int numN1 = 0;
                        int numA = 0;
                        int contRM = 0;

                        int numDC = 0;

                        int codR = 0;

                        for (int i = 0; i < listaG.size(); i++) {
                            out.println("<div class=\"row \">");
                            out.println("<div class=\"col-md-3\"></div>");
                            out.println("<div class=\"col-md-6 panel panel-info panel-heading\"><center><h5 class=\"panel-title\">" + listaG.get(i).getNombre_grupo() + "</h5></center></div>");
                            out.println("<div class=\"col-md-3\"></div>");
                            out.println("</div>");
                            out.println("<div class=\"row\">");
                            out.println("<div class=\"col-md-3\"></div>");
                            out.println("<div class=\"col-md-5\" align=\"justify\"><h6 class=\"text-success text-uppercase\">" + " *" + listaG.get(i).getDescripcion_grupo() + "</h6></center></div>");
                            out.println("</div>");

                            for (int j = 0; j < listaP.size(); j++) {
                                if (listaP.get(j).getCodigo_grupo() == listaG.get(i).getCodigo_grupo()) {
                                    out.println("<div class=\"row\"  align=\"justify\">");
                                    out.println("<div class=\"col-md-3\"></div>");
                                    out.println("<div class=\"col-md-6\"  align=\"justify\"><h5>" + listaP.get(j).getLabel_pregunta() + "</h5></div>");
                                    int codP = listaP.get(j).getCodigo_preguntas();
                                    //////////////////////////////////////////////////////////////////////////////
                                    ////////////////////////////////TIPO TEXTO//////////////////////////////////
                                    /////////////////////////////////////////////////////////////////////////////
                                    //JOptionPane.showMessageDialog(null, "TIPO DE PREGUNTA"+listaP.get(j).getCodigo_tipo_pregunta());
                                    //for(int r=0;r<listaR.size();r++)
                                    //{
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 1) {

                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\"  align=\"center\"> " + listaR.get(codR).getValor_Respuestas() + "</div>");
                                        //
                                        out.println("</div>");
                                        //numT1++;
                                        codR++;
                                    }
                                    /*DATOS COMUNES*/
                                    //JOptionPane.showMessageDialog(null, "TIPO DE PREGUNTA"+listaP.get(j).getCodigo_tipo_pregunta()+" valor: " + listaR.get(j).getValor_Respuestas());
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 9) {

                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\"  align=\"justify\">" + listaR.get(j).getValor_Respuestas() + "</center></div>");
                                        //
                                        out.println("</div>");
                                        numDC++;
                                        codR++;
                                    }

                                    ///////////////////////////////////////////////////////////////////////////
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 2) {
                                        //JOptionPane.showMessageDialog(null, "Entra en check");

                                        for (int k = 0; k < listaV.size(); k++) {
                                            //JOptionPane.showMessageDialog(null, "codigo lista  V: "+listaV.get(k).getCodigo_Preguntas());
                                            //JOptionPane.showMessageDialog(null, "codigo lista R: "+listaP.get(j).getCodigo_preguntas());
                                            if (listaV.get(k).getCodigo_Preguntas() == listaP.get(j).getCodigo_preguntas()) {
                                                //recorrer lista de respuestas
                                                //JOptionPane.showMessageDialog(null, "codigo resp: "+listaR.get(j).getCodigo_Respuestas()+" valor respuesta: "+listaR.get(r).getValor_Respuestas()+" valor valores: "+listaV.get(k).getValores());
                                                if (listaV.get(k).getValores().equals(listaR.get(codR).getValor_Respuestas())) {
                                                    //JOptionPane.showMessageDialog(null, "entra en igualdad");
                                                    out.println("<div class=\"row\">");
                                                    out.println("<div class=\"col-md-3\"></div>");
                                                    out.println("<div class=\"col-md-6 offset-md-3\" align=\"justify\">" + listaV.get(k).getValores() + "</div>");
                                                    out.println("<div class=\"col-md-3\"></div>");
                                                    out.println("</div>");
                                                    codR++;
                                                }

                                            }

                                        }

                                        /*
                                    String[] select = request.getParameterValues("seleccion"+numC1); 
                                                for(String tempSelect: select)   
                                                {
                                    //out.println("</div>");
                                
                                       
                                    for(int k=0; k<listaV.size();k++)
                                    {
                                        if(contC<1){
                                        if(listaV.get(k).getCodigo_Preguntas()== listaP.get(j).getCodigo_preguntas())
                                        {
                                        
                                            out.println("<div class=\"row\">");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-3\">"+tempSelect+"</div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("</div>");
                                            //contC++;
                                        }
                                        }
                                        contC++;
                                    }
                                                }//cierre for del select*/
                                    }//cierre del combobox
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 3) {
                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\" align=\"justify\">" + listaR.get(codR).getValor_Respuestas() + "</div>");
                                        out.println("</div>");
                                        //numC1++;
                                        codR++;

                                        /*
                                    for(int k=0; k<listaV.size();k++)
                                    {
                                    
                                        if(listaV.get(k).getCodigo_Preguntas()== listaP.get(j).getCodigo_preguntas())
                                        {
                                            if(contR<1){
                                            out.println("<div class=\"row\">");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-3\">"+request.getParameter("radio"+numR1)+"</div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("<div class=\"col-md-3\"></div>");
                                            out.println("</div>");}
                                            contR++;
                                        }
                                    }*/
                                    }
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 5) {
                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\" align=\"justify\">" + listaR.get(codR).getValor_Respuestas() + "</div>");
                                        out.println("</div>");
                                        //numC1++;
                                        codR++;
                                    }
                                    ////////////////////////////////////////////////////////////////////////////////
                                    ////////////////////////////////Guardar Archivo/////////////////////////////////
                                    ////////////////////////////////////////////////////////////////////////////////
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 6) {
                                        numA++;

                                        out.println("<form name = \"asd\" action=\"downloadFileServlet\" method=\"POST\" ><center>");
                                        out.println("<input type=\"hidden\" name=\"codigo\" value=\"" + Cod + "\">");
                                        out.println("<input type=\"hidden\" name=\"codForm\" value=\"" + fp.getCodFormP() + "\">");
                                        out.println("<input type=\"hidden\" name=\"pidm\" value=\"" + pidm + "\">");
                                        out.println("<input type=\"hidden\" name=\"pregunta\" value=\"" + listaP.get(j).getCodigo_preguntas() + "\">");
                                        out.println("<input type=\"hidden\" name=\"iter\" value=\"" + iter + "\">");
                                        out.println("<div ><center><button class=\"btn btn-default\"type=\"submit\" name=\"archivo\">Descargar</button></center></div>");
                                        out.println("</center></form>");
                                        //out.println("</div>");
                                        codR++;
                                    }
                                    ////////////////////////////////////////////////////////////////////////////////
                                    ////////////////////////TIPO DATE///////////////////////////////////////////////
                                    ////////////////////////////////////////////////////////////////////////////////
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 7) {
                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\"><center>" + listaR.get(codR).getValor_Respuestas() + "</center></div>");
                                        //
                                        out.println("</div>");
                                        //numFech1++;
                                        codR++;
                                        //out.println("</div>");
                                    }
                                    ///////////////////////////////////////////////////////////////////////////////
                                    //////////////////////Tipo Numerico////////////////////////////////////////////
                                    ///////////////////////////////////////////////////////////////////////////////
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 8) {
                                        out.println("<div class=\"col-md-3\"></div>");
                                        out.println("<div class=\"col-md-6 offset-md-3\"><center>" + listaR.get(codR).getValor_Respuestas() + "</center></div>");
                                        //
                                        out.println("</div>");
                                        //numN1++;
                                        codR++;
                                    }

                                    //JOptionPane.showMessageDialog(null, "TIPO DE PREGUNTA"+listaP.get(j).getCodigo_tipo_pregunta());
                                    ////////////////////////////////////////////////////////////////////////////////
                                    if (listaP.get(j).getCodigo_tipo_pregunta() == 4) {
                                        //JOptionPane.showConfirmDialog(null, "ENTRA MOSTRAR MATRIZ");

                                        out.println("</div>");
                                        out.println("<div class=\"row\">");
                                        out.println("<div class=\"col-md-3\" align=\"justify\"></div>");
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
                                        out.println("<div class=\"col-md-6 table-responsive\" align=\"justify\"><table class=\"table table-bordered\">");
                                        int puntero = 0;
                                        for (int n = 0; n < filas; n++) {
                                            out.println("<tr>");
                                            for (int m = 0; m < columnas; m++) {

                                                if (puntero < ListaCabeceras.size() && ListaCabeceras.get(puntero).getPosicionX() == n && ListaCabeceras.get(puntero).getPosicionY() == m) {
                                                    out.println("<th>" + ListaCabeceras.get(puntero).getValor_cabecera() + "</th>");
                                                    puntero++;
                                                } else if (n == 0 && m == 0) {
                                                    out.println("<td><input type=\"text\" name=\"Texto\" placeholder=\"Item\"' disabled></td>");
                                                } else {
                                                    //JOptionPane.showMessageDialog(null, request.getParameter("Texto"+contRM));
                                                    //out.println("<td><input type=\"text\" name=\"Texto"+listaR.get(contRM).getValor_Respuestas()+"\" placeholder=\"Texto\"'></td>");
                                                    out.println("<td><input type=\"text\" name=\"Texto" + contRM + "\" placeholder=\"" + listaR.get(codR).getValor_Respuestas() + "\"' disabled></td>");
                                                    //codR++;
                                                    contRM++;

                                                }
                                            }
                                            out.println("</tr>");
                                        }
                                        out.println("</table></div>");
                                        out.println("</div>");
                                    }//cierre if de la matriz
                                    //}
                                }
                            }
                        }

                        out.println("<div class=\"row\">");
                        out.println("<div class=\"col-md-4\"></div>");
                        //out.println("<div class=\"col-md-4\"><center><button class=\"btn btn-default\" type=\"text\" name=\"Submit\" value='"+Cod+"'>Guardar</button></center></div>"); 
                        out.println("</div>");
                    }//cierre de else en caso de que existan respuestas para el usuario
                    con.closeConexion();
                %>
            </div>
            <script type="text/javascript">
                function info() {
                    pulsado = document.elegir.radio;
                    for (i = 0; i < pulsado.length; i++) {
                        valor = pulsado[i].checked;
                        if (valor == true) {
                            elegido = pulsado[i].value;
                        }
                    }
                }
                function Imprimir_Contenido()
                {
                    var ficha = document.getElementById("imprimir");
                    var Ventana_Impresion = window.open(' ', 'popimpr');
                    Ventana_Impresion.document.write(ficha.innerHTML);
                    Ventana_Impresion.document.close();
                    Ventana_Impresion.print( );
                    Ventana_Impresion.close();
                }
            </script>

            <br>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6"> <center><a href="javascript:Imprimir_Contenido()" class="btn btn-success btn-lg">
                            <span  class="d-inline-block" tabindex="0" data-toggle="tooltip" title="Imprimir" class="glyphicon glyphicon-print  /*alert alert-info*/">
                                <i class='fas fa-print'style='font-size:35px' ></i></span>  
                        </a><center></center></div>
                <button align="center" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Volver"> <div class="col-md-3"><a href="mostrarRespuesta.jsp?Submit=" + Cod + " " ><i class='	fas fa-arrow-left' style='font-size:40px;color:white'></i></a></button>

            </div> 
            <%--  <center><a class="glyphicon glyphicon-print alert alert-info" href="javascript:Imprimir_Contenido()" ></a></center>--%>
            <%             } catch (Exception e) {
                    System.out.println("error." + e.getMessage());

                }
            %>
            </body>
            </html>

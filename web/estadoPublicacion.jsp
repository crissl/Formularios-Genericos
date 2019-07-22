

<%-- 
    Document   : estadoPublicacion
    Created on : 05/03/2018, 10:40:27
    Author     : Tefii
--%>

<%@page import="FORM.DB2"%>
<%@page import="FORM.FormPersona"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.LinkedList"%>
<%@page import="FORM.Formulario"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="FORM.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="FORM.Usuario"%> <!-- import de Usuario -->
<%@page session="true" %> <!-- Se agrega a modo de validacion -->
<!DOCTYPE html>
<% Usuario currentUser = (Usuario) (session.getAttribute("currentSessionUser")); //Recibe el atributo de sesion del Servlet
/*Si el atributo es diferente de nulo muestra la pagina */
    if (currentUser != null) { %>
<html>
    <head>
        <title>Estado Publicación</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body>

        <div>
            <div class="row bg-default">
                <div class="col-md-2"><center><img src="espelogo.jpg"/></center></div>
                <div class="col-md-8"><center><h1>Gestión de Formularios</h1></center></div>
                <div class="col-md-2"></div>
            </div>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation"><a href="mostrarFormulario.jsp">Volver</a></li>
            </ul>
        </div>
        <%
            request.setCharacterEncoding("UTF-8");
            //DESARROLLO
            DB con = DB.getInstancia();
            Connection co = con.getConnection();
            //PAS8
            DB2 con2 = DB2.getInstancia();
            Connection co2 = con2.getConnection();

            //request publicar Usuario 
            String query = request.getParameter("query");
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            String tF = request.getParameter("tipoFormulario");
            String eF = request.getParameter("estadoSeg");
            String EO = request.getParameter("estadoPublicacion");
            String nomF = request.getParameter("Submit");
            int codF = Integer.parseInt(nomF);
            String[] parts = fechaInicio.split("-");
            String anioInicio = parts[0];
            String mesInicio = parts[1];
            String diaInicio = parts[2];
            String FechaInicio = diaInicio + "/" + mesInicio + "/" + anioInicio;
            String[] parts2 = fechaFin.split("-");
            String anioFin = parts2[0];
            String mesFin = parts2[1];
            String diaFin = parts2[2];
            String FechaFin = diaFin + "/" + mesFin + "/" + anioFin;

            String queryF = "\"" + query + "\"";

            java.util.Date date = new java.util.Date();
            long t = date.getTime();
            java.sql.Date sqlDate = new java.sql.Date(t);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /*EJECUCION QUERY PARA EXTRAER PIDM*/
            LinkedList<Integer> listaPIDM = new LinkedList<Integer>();
            LinkedList<Integer> PIDM = new LinkedList<Integer>();
            LinkedList<FormPersona> listaFP = new LinkedList<FormPersona>();
            try {
                ResultSet rs2 = co2.prepareStatement(query).executeQuery();
                int codPIDM = 0;
                while (rs2.next()) {
                    codPIDM = (rs2.getInt(1));
                    listaPIDM.add(codPIDM);

                }
                rs2.close();
            } catch (Exception ex) {
                out.println("Error en sacar pidms \n" + ex);
            }
            /*obtenemos los datos de la tabla formulario_persona para hacer el codigo sin repeticion*/
            ResultSet rs1 = co.prepareStatement("SELECT * FROM UTIC.UZGTFORMULARIO_PERSONA order by codigo_UZGTFORMULARIOS_PERSONA ASC").executeQuery();
            while (rs1.next()) {
                FormPersona fp = new FormPersona();
                fp.setPidm(rs1.getInt(1));
                fp.setCodFormP(rs1.getInt(2));
                listaFP.add(fp);
            }
            rs1.close();
            ///////////////////////////////////////////////
            /*INSERT TABLA PIDM*/
 /*COMPARAR PIDMS*/
 /*    ResultSet rsC = co.prepareStatement("SELECT * FROM UTIC.SATURN_SPRIDEN").executeQuery();
           int valPIDM=0;
           while(rsC.next())
           {
               valPIDM=(rsC.getInt(1));
               PIDM.add(valPIDM);
                
           }
           rsC.close();*/

            Date Fecha = new Date();
            java.sql.Date FechaSql = new java.sql.Date(Fecha.getYear(), Fecha.getMonth(), Fecha.getDate());
            //JOptionPane.showMessageDialog(null, FechaSql.toString());
            /*  try
           {
               String sql= "INSERT INTO UTIC.SATURN_SPRIDEN (SPRIDEN_PIDM) VALUES (?)";
               PreparedStatement ps = co.prepareStatement(sql);
                
               for (int i=0 ; i<listaPIDM.size();i++)
               {
                   for(int j=0;j<PIDM.size();j++)
                   {
                       if(!listaPIDM.get(i).equals(PIDM.get(j)))
                       {
                           ps.setInt(1, listaPIDM.get(i));
                           ps.executeUpdate();
                       }                
                   }
               }
           }
           catch (Exception ex)
           {
               //out.println("Error en guardar pidms"+ex);
           }*/
            //////////////////////////////////////////////
            /*INSERT FORMULARIO -PERSONA*/
            int cod = 0;
            if (listaFP.isEmpty()) {
                cod = 1;
            } else {
                cod = listaFP.getLast().getCodFormP() + 1;
            }

            try {
                String sql = "INSERT INTO UTIC.UZGTFORMULARIO_PERSONA (SPRIDEN_PIDM,CODIGO_UZGTFORMULARIOS_PERSONA,CODIGO_UZGTFORMULARIOS,UZGTFORMULARIOS_PERSONA_FECHA,UZGTFORMULARIOS_ESTADO_SEG, UZGTFORMULARIOS_ESTADO_LLENADO, UZGTFORMULARIOSPER_FECHA_CREA, UZGTFORMULARIOSPER_USUA_CREA) VALUES (?,?,?,?,?,?,?,?)";
                PreparedStatement ps = co.prepareStatement(sql);

                for (int i = 0; i < listaPIDM.size(); i++) {
                    ps.setInt(1, listaPIDM.get(i));
                    ps.setInt(2, cod + i);
                    ps.setInt(3, codF);
                    ps.setDate(4, sqlDate);
                    ps.setString(5, eF);
                    ps.setString(6, "N");
                    ps.setDate(7, sqlDate);
                    ps.setInt(8, listaPIDM.get(i));
                    ps.executeUpdate();
                }
                //out.println("<center><div class=\"alert alert-success\"><strong>Exito!</strong> Se Guardo correctamente</div></center>");

            } catch (Exception ex) {
                out.println("Error en formulario-persona" + ex);
            }

            //////////////////////////////////////////////////////////////////////////////////
            /*UPDATE TABLA FORMULARIOS*/
            try {
                String cadena = query;
                String aux = "";
                String apos = "'";
                for (int i = 0; i < cadena.length(); i++) {
                    if (cadena.charAt(i) == apos.charAt(0)) {
                        aux = aux + cadena.charAt(i) + "'";
                    } else {
                        aux = aux + cadena.charAt(i);
                    }
                }
                co.prepareStatement("UPDATE UTIC.UZGTFORMULARIOS SET UZGTFORMULARIOS_FECHA_INICIO='" + FechaInicio + "', UZGTFORMULARIOS_FECHA_FIN='" + FechaFin + "', UZGTFORMULARIOS_ESTADO= 1, UZGTFORMULARIOS_EO= '" + tF + "', UZGTFORMULARIOS_QUERY_P= '" + aux + "'  WHERE CODIGO_UZGTFORMULARIOS =" + codF + "").executeUpdate();
                PreparedStatement ps = co.prepareStatement("UPDATE UTIC.UZGTFORMULARIOS SET UZGTFORMULARIOS_FECHA_MODIF= ? WHERE CODIGO_UZGTFORMULARIOS =" + codF + "");
                ps.setDate(1, sqlDate);
                ps.executeUpdate();
//co.prepareStatement("UPDATE UTIC.UZGTFORMULARIOS SET  UZGTFORMULARIOS_FECHA_INICIO='" + diaInicio+"/"+mesI +"/"+anioInicio +"' WHERE CODIGO_UZGTFORMULARIOS ="+codF+"").executeUpdate();                                                                                       UZGTFORMULARIOSPER_USUA_MODIF                         
                //co.prepareStatement("UPDATE UTIC.UZGTFORMULARIO_PERSONA SET UZGTFORMULARIOS_ESTADO_SEG= '" + eF + "'  WHERE  SPRIDEN_PIDM =" + listaPIDM + "").executeUpdate();
                out.println("<meta http-equiv='refresh' content='3;URL=mostrarFormulario.jsp'>");//redirects after 3 seconds
                out.println("<center><div h5 class='text alert alert-success'><strong><p style='color:green;'>Éxito Formulario Publicado</p></strong></h5></div></center>");
            } catch (Exception ex) {
                out.println("Error update " + ex);

            }
            con.closeConexion();

            //out.println("SQL "+queryF);
        %>
    </body>
</html>
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
        <%
            try {

        %> 
        <ul class="nav nav-tabs" role="tablist">

            <div class="col-md-4 alert alert-danger"><center>Error! Usuario no autorizado</center></div>       
        </form>
    </ul>
    <%            } catch (Exception e) {
            System.out.println("error." + e.getMessage());

        }
    %>
</body>
</html>



<% }%>
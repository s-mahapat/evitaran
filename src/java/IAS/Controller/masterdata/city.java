package IAS.Controller.masterdata;

import IAS.Class.JDSLogger;
import IAS.Controller.JDSController;
import IAS.Model.masterdata.cityModel;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;

/**
 *
 * @author Deepali gokhale
 */
public class city extends JDSController {

    private cityModel _cityModel = null;
    private static final Logger logger = JDSLogger.getJDSLogger(IAS.Controller.masterdata.city.class.getName());

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String url = null;

        try {
            _cityModel = new IAS.Model.masterdata.cityModel(request);

            if (action.equalsIgnoreCase("save")) {

                _cityModel.Save();
                url = "/jsp/masterdata/displayCity.jsp";

            } else if (action.equalsIgnoreCase("add")) {
                int cityID = 0;
                JSONObject obj = new JSONObject();
                try {
                    cityID = _cityModel.Save();
                    obj.put("message", "Success");
                } catch (SQLException ex) {
                    obj.put("message", "Failed to add city");
                } finally {
                    obj.put("id", cityID);
                }
                response.getWriter().write(obj.toJSONString());

            } else if (action.equalsIgnoreCase("edit")) {

                _cityModel.editCity();
                url = "/jsp/masterdata/editCity.jsp";

            } else if (action.equalsIgnoreCase("view")) {

                _cityModel.viewCity();
                url = "/jsp/masterdata/displayCity.jsp";

            } else if (action.equalsIgnoreCase("search")) {

                // searchInward gets all the inwards based on the search criteria entered on screen by the user.
                String xml = _cityModel.searchCity();
                request.setAttribute("xml", xml);
                url = "/xmlserver";
            }
        } catch (SQLException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException | ParserConfigurationException | TransformerException e) {
            logger.error(e.getMessage(), e);
            throw new javax.servlet.ServletException(e);

        } finally {
            if (url != null) {
                RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                if (rd != null) {
                    rd.forward(request, response);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

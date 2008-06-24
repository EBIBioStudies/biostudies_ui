package uk.ac.ebi.ae15.servlets;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import uk.ac.ebi.ae15.app.ApplicationServlet;
import uk.ac.ebi.ae15.components.Experiments;
import uk.ac.ebi.ae15.components.XsltHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class QueryServlet extends ApplicationServlet
{
    // logging machinery
    private final Log log = LogFactory.getLog(getClass());

    // Respond to HTTP GET requests from browsers.
    public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException
    {
        log.debug(
                new StringBuilder("Processing request: ")
                        .append(request.getRequestURL())
                        .append("?")
                        .append(request.getQueryString())
        );


        String type = "xml";
        String stylesheet = "default";

        Pattern p = Pattern.compile("servlets/query/([^/]+)/?([^/]*)");
        Matcher m = p.matcher(request.getRequestURL());
        if (m.find()) {
            stylesheet = m.group(1);
            if (0 < m.group(2).length())
                type = m.group(2).toLowerCase();
        }

        if ( type.equals("xls") ) {
            // special case for Excel docs
            // we actually send tab-delimited file but mimick it as XLS doc
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment; filename=\"ae-experiments.xls\"");
            type = "plain";
        } else if ( type.equals("tab") ) {
                response.setContentType("text/plain; charset=ISO-8859-1");
                response.setHeader("Content-disposition", "attachment; filename=\"ae-experiments.txt\"");
                type = "plain";
        } else {
            // Set content type for HTML/XML/plain
            response.setContentType("text/" + type + "; charset=ISO-8859-1");
        }
        // Disable cache no matter what (or we're fucked on IE side)
        response.addHeader("Pragma", "no-cache");
        response.addHeader("Cache-Control", "no-cache");
        response.addHeader("Cache-Control", "must-revalidate");
        response.addHeader("Expires", "Fri, 16 May 2008 10:00:00 GMT"); // some date in the past

        // Output goes to the response PrintWriter.
        PrintWriter out = response.getWriter();
        Experiments experiments = (Experiments) getComponent("Experiments");
        if (stylesheet.equals("arrays-select")) {
            out.print(experiments.getArrays());
        } else if (stylesheet.equals("species-select")) {
            out.print(experiments.getSpecies());
        } else {
            String stylesheetName = new StringBuilder(stylesheet).append('-').append(type).append(".xsl").toString();

            XsltHelper xsltHelper = (XsltHelper) getComponent("XsltHelper");
            if (!xsltHelper.transformDocumentToPrintWriter(
                    experiments.getExperiments(),
                    stylesheetName,
                    request.getParameterMap(),
                    out)) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
        out.close();
    }
}

/*
 * Copyright 2009-2015 European Molecular Biology Laboratory
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package uk.ac.ebi.fg.biostudies.servlets;

import net.sf.saxon.om.DocumentInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import uk.ac.ebi.fg.biostudies.components.SaxonEngine;
import uk.ac.ebi.fg.biostudies.utils.HttpServletRequestParameterMap;
import uk.ac.ebi.fg.biostudies.utils.StringTools;
import uk.ac.ebi.fg.biostudies.utils.saxon.SaxonException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ErrorServlet extends AuthAwareApplicationServlet {

    private static final long serialVersionUID = 2398894710133584526L;

    private transient final Logger logger = LoggerFactory.getLogger(getClass());

    protected boolean canAcceptRequest( HttpServletRequest request, RequestType requestType )
    {
        return true;
    }

    protected void doAuthenticatedRequest(
            HttpServletRequest request
            , HttpServletResponse response
            , RequestType requestType
            , String authUserName
    ) throws ServletException, IOException
    {
        logRequest(logger, request, requestType);

        response.setContentType("text/html; charset=UTF-8");
        // Output goes to the response PrintWriter.

        PrintWriter out = response.getWriter();
            String stylesheetName = "error-html.xsl";

            HttpServletRequestParameterMap params = new HttpServletRequestParameterMap(request);
            params.put("original-request-uri", (String)request.getAttribute("javax.servlet.error.request_uri"));
            params.put("userid", StringTools.listToString(getUserIds(authUserName), " OR "));
            params.put("username", authUserName);

            SaxonEngine saxonEngine = (SaxonEngine) getComponent("SaxonEngine");
            DocumentInfo source = saxonEngine.getAppDocument();

            try {
				if (!saxonEngine.transformToWriter(
				        source
				        , stylesheetName
				        , params
				        , out
				)) {                     // where to dump resulting text
				    throw new Exception("Transformation returned an error");
				}
			} catch (SaxonException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//        } catch (Exception x) {
//            throw new RuntimeException(x);
//        }
    }}
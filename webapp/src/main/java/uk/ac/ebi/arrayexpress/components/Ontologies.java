package uk.ac.ebi.arrayexpress.components;

/*
 * Copyright 2009-2010 European Molecular Biology Laboratory
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import uk.ac.ebi.arrayexpress.app.ApplicationComponent;
import uk.ac.ebi.arrayexpress.utils.saxon.search.Controller;
import uk.ac.ebi.microarray.ontology.efo.EFONode;
import uk.ac.ebi.microarray.ontology.efo.EFOOntologyHelper;

import java.util.HashMap;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;


public class Ontologies extends ApplicationComponent
{
    // logging machinery
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private EFOOntologyHelper ontology;

    private Map<String, Integer> expCountByEfoId;

    private final String EFO_ROOT_ID = "http://www.ebi.ac.uk/efo/EFO_0000001";

    private final String EFO_NOT_LOADED_YET = "";

    public Ontologies()
    {
        super("Ontologies");
    }

    public void initialize() throws Exception
    {
        this.expCountByEfoId = new HashMap<String, Integer>();
        ((JobsController)getComponent("JobsController")).executeJob("reload-ontology");
    }

    public void terminate() throws Exception
    {
    }

    public void setOntology( EFOOntologyHelper efoOntology )
    {
        this.ontology = efoOntology;
        buildExpCountMap();
    }

    public String getEfoTreeJson( String efoId, String jsonp )
    {
        if (null == this.ontology) {
            return EFO_NOT_LOADED_YET;
        }

        if (null == efoId || "".equals(efoId)) {
            efoId = EFO_ROOT_ID;
        }

        if ("".endsWith(jsonp)) {
            return "{" + getEfoNodeJson(efoId) + "}";
        } else {
            return jsonp + "({" + getEfoNodeJson(efoId) + "})";
        }
    }

    private String getEfoNodeJson( String efoId )
    {
        EFONode node = ontology.getEfoMap().get(efoId);
        if (null != node) {
            StringBuilder sb = new StringBuilder();
            sb.append('"').append(node.getId()).append("\":");
            if (node.hasChildren()) {
                sb.append("{");
                int count = node.getChildren().size();
                for (EFONode child : node.getChildren()) {
                    sb.append(getEfoNodeJson(child.getId()));
                    if (--count > 0) {
                        sb.append(",");
                    }
                }
                sb.append("}");

            } else {
                sb.append("1");
            }
            return sb.toString();
        } else
            return "";
    }

    public String getEfoDictJson( String jsonp )
    {
        if (null == ontology) {
            return EFO_NOT_LOADED_YET;
        }

        StringBuilder sb = new StringBuilder();


        if (!"".endsWith(jsonp)) {
            sb.append(jsonp).append("(");
        }
        sb.append("{");
        SortedSet<String> sortedKeys= new TreeSet<String>(ontology.getEfoMap().keySet());
        int count = sortedKeys.size();
        for (String key : sortedKeys) {
            --count;
            EFONode node = ontology.getEfoMap().get(key);
            if (null != node ) {
                sb.append('"')
                  .append(key)
                  .append("\":{")
                  .append("\"term\":\"")
                  .append(node.getTerm())
                  .append("\", \"organizational_class\":")
                  .append(node.isOrganizational() ? "\"true\"" : "\"false\"")
                  .append(", \"experiments\":")
                  .append(String.valueOf(this.expCountByEfoId.get(key)))
                  .append("}");
                if (count > 0 ) {
                    sb.append(",");
                }
            }
        }
        sb.append("}");
        if (!"".endsWith(jsonp)) {
            sb.append(")");
        }

        return sb.toString();
    }

    private void buildExpCountMap()
    {
        // build experiment count map
        logger.debug("Building experiment count map for EFO terms");

        Controller c = ((SearchEngine)getComponent("SearchEngine")).getController();

        Map<String, String[]> q = new HashMap<String, String[]>();
        q.put("userid", new String[]{"1"}); // do this only for public data
        q.put("efv", new String[]{""});     // query experimental factor values

        this.expCountByEfoId.clear();
        
        for (EFONode node : ontology.getEfoMap().values()) {
            q.get("efv")[0] = node.getTerm();
                try {
                    Integer docs = c.getDocCount("experiments", q);
                    this.expCountByEfoId.put(node.getId(), docs);
                } catch (Exception x) {
                }

        }
        logger.debug("Building completed");

    }
}

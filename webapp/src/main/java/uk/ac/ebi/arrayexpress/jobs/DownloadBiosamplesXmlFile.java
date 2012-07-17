/**
 * 
 */
package uk.ac.ebi.arrayexpress.jobs;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @author rpslpereira
 *
 */
public class DownloadBiosamplesXmlFile {

	/**
	 * @param args
	 */
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	String url="http://tomcat-18:21480/biosamples/";
	String username="rui";
	String password="ruipereire";
	String sessionCookieName="AGESESS";
	//String downloadDirectory="/Users/rpslpereira/Apps/apache-tomcat-6.0.33/temp/StagingArea/DownloadXml/";
	
	public static void main(String[] args) {
		DownloadBiosamplesXmlFile test= new DownloadBiosamplesXmlFile();
		try {
		test.downloadXml("/Users/rpslpereira/Apps/apache-tomcat-6.0.33/temp/StagingArea/DownloadXml/");
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public boolean downloadXml(String downloadDirectory) throws Exception {
		// TODO Auto-generated method stub
	
		String sessionKey = null;
        DefaultHttpClient httpclient = null;
        boolean ok = false;
		try {
			httpclient = new DefaultHttpClient();
            HttpPost httpost = new HttpPost(url + "Login");

            List<NameValuePair> nvps = new ArrayList<NameValuePair>();
            nvps.add(new BasicNameValuePair("username", username));
            nvps.add(new BasicNameValuePair("password", password != null ? password : ""));

            httpost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));

            log.debug("Trying to login onto the server");

            HttpResponse response = httpclient.execute(httpost);

            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
            	log.debug("Server response code is: " + response.getStatusLine().getStatusCode());
                return false;
            }

            HttpEntity ent = response.getEntity();

            String respStr = EntityUtils.toString(ent).trim();
            if (respStr.startsWith("OK:")) {
            	log.debug("Login successful");
                sessionKey = respStr.substring(3);
                log.debug("Call XMLDataExport URL");
                 URL website = new URL(url + "XMLDataExport?" + sessionCookieName +"=" + sessionKey );
//                 ReadableByteChannel rbc = Channels.newChannel(website.openStream());
//                 FileOutputStream fos = new FileOutputStream("biosamples.xml");
//                 fos.getChannel().transferFrom(rbc, 0, 1 << 2400);
                 
                 BufferedInputStream in = null;
                 FileOutputStream fout = null;
                 String fileLocation="";
                 try
                 {
                         in = new BufferedInputStream(website.openStream());
                         fileLocation=downloadDirectory + "biosamples.xml";
                         fout = new FileOutputStream( fileLocation);

                         byte data[] = new byte[1024];
                         int count;
                         while ((count = in.read(data, 0, 1024)) != -1)
                         {
                                 fout.write(data, 0, count);
                         }
                 }
                 finally
                 {
                         if (in != null)
                                 in.close();
                         if (fout != null)
                                 fout.close();
                         log.debug("File {} created successful",fileLocation);
                 }
   

            } else {
            	log.debug("Login failed: " + respStr);
                return false;
            }
            ok = true;
        } catch (Exception e) {
        	 log.error("ERROR on download: " + e.getMessage());
        	 throw new RuntimeException(e);
        	 //return false;
        } finally {
            if (!ok) {
                httpclient.getConnectionManager().shutdown();
                log.error("Login failed");

            }
        }
		
		return ok;
	}



}

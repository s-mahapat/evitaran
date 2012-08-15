/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.commons.fileupload.FileItem;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

/**
 *
 * @author Newton
 */
public class URNModel extends FileUploadBase {

    @Override
    public void processFiles() throws IOException {
        for (FileItem item : this.getFiles()) {

            try {
                InputStream xml = item.getInputStream();
                StringBuilder buffer = new StringBuilder();
                byte[] _b = new byte[4096];
                for (int n; (n = xml.read(_b)) != -1;) {
                    buffer.append(new String(_b, 0, n));
                }
                String str = buffer.toString();
                DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                DocumentBuilder docb = dbf.newDocumentBuilder();
                byte b[] = new byte[364];
                xml.read(b);
                ByteArrayInputStream x = new ByteArrayInputStream(b);
                Document doc = docb.parse(x);
                String root = doc.getDocumentElement().getNodeName();
                String _root = root;
            } catch (ParserConfigurationException | IOException | SAXException e) {
                throw (new IOException(e.getMessage()));
            }

        }

    }
}

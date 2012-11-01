/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Model.JDSModel;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import org.apache.commons.fileupload.FileItem;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

/**
 *
 * @author Newton
 */
public class FileUploadBase extends JDSModel {

    public FileUploadBase(HttpServletRequest request) throws SQLException{
        super(request);
    }
    private ArrayList<FileItem> uploadedFiles=new ArrayList<>();

    public void addFiles(List<FileItem> _uploadedFiles) {        
        Iterator i = _uploadedFiles.iterator();
        while (i.hasNext()) {
            FileItem fileItem = (FileItem) i.next();
            if (fileItem.isFormField() == false) {                
                uploadedFiles.add(fileItem);                
            }
        }
    }
  

    public List<FileItem> getFiles() {
        return uploadedFiles;
    }

    public void processFiles() throws IOException, SQLException {
        throw (new NotImplementedException());
    }

    public String getOutputAsXML() throws IOException, TransformerException, ParserConfigurationException{
        throw (new NotImplementedException());
    }
    
    public ArrayList<String> getOutputAsLIST() {
        throw (new NotImplementedException());
    }
}

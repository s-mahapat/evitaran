/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Model.FileUpload;

import IAS.Model.JDSModel;
import java.io.IOException;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

/**
 *
 * @author Newton
 */
public class FileUploadBase extends JDSModel{
    
    private List<FileItem> uploadedFiles;
    
    public void addFiles(List<FileItem> _uploadedFiles){
        uploadedFiles = _uploadedFiles;
    }
    
    public List<FileItem> getFiles(){
        return uploadedFiles;
    }
    
    public void processFiles() throws IOException{
        throw(new NotImplementedException());
    }
    
    public String getOutput(){
        throw(new NotImplementedException());
    }
}

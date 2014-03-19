/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Model.Subscriber.subscriberModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Properties;

/**
 *
 * @author Newton
 */
public class ChequeReturnPDF extends JDSPDF{

    //private InputStream pdfTemplatesFile = null;

    public ChequeReturnPDF(){
        super();
    }

    public ByteArrayOutputStream getPDF( String SubscriberNumber, String InwardNumber,
                                    String ChequeNumber, String ChequeDate,
                                    float Amount, String Reason) throws DocumentException, MalformedURLException, IOException{

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        document.add(this.getSalutation());
        document.add(this.getChequeReturnLetterBody(SubscriberNumber, InwardNumber,
                                                    ChequeNumber, ChequeDate,
                                                    Amount, Reason));
        document.add(this.getLetterFooter());
        document.close();
        pdfWriter.close();
        return outputStream;

    }

    private Paragraph getChequeReturnLetterBody( String SubscriberNumber, String InwardNumber,
                                                String ChequeNumber, String ChequeDate,
                                                float Amount, String Reason) throws IOException{
        Paragraph paragraph = new Paragraph();
        Paragraph paragraph2 = new Paragraph();
        Paragraph paragraph3 = new Paragraph();
        Paragraph paragraphAddress = new Paragraph();
        Paragraph paragraphShippingAddress = new Paragraph();        
        PdfPTable addressTable = new PdfPTable(1);
        
        //paragraphAddress.setAlignment(Element.ALIGN_LEFT);
        paragraphAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraphAddress.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        paragraphAddress.add(addressTable);
        addressTable.setWidthPercentage(100);
        

        //Font _IASFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, BaseColor.BLACK);
        paragraph.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        paragraph.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph.setFont(_IASFont);
        paragraph.setAlignment(Element.ALIGN_LEFT);

        paragraph2.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph2.setFont(_IASFont);
        paragraph2.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        paragraph2.setAlignment(Element.ALIGN_LEFT);
        
        // create the shipping and invoice address table with 1 row and 2 cols
        //paragraphShippingAddress.add(addressTable);
        //paragraphShippingAddress.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraphShippingAddress.setSpacingBefore(JDSPDF.LESS_OUTER_PARAGRAPH_SPACE);
        
        
        Chunk shippingAddressHeader = new Chunk("SHIPPING ADDRESS", JDSPDF.JDS_FONT_BODY);
        shippingAddressHeader.setTextRise(2);
        shippingAddressHeader.setUnderline(1, 0);
        paragraphShippingAddress.add(shippingAddressHeader);
        paragraphShippingAddress.add(Chunk.NEWLINE);
        subscriberFormBean subscriber = null;
        try{
            subscriberModel subscriber_model = new IAS.Model.Subscriber.subscriberModel();
            subscriber = subscriber_model.GetSubscriber(SubscriberNumber);
            
        }catch(SQLException | ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException ex){
            throw new IOException(ex.getMessage());
        }
        
        
        paragraphShippingAddress.add(new Phrase(subscriber.getSubscriberName(), JDSPDF.JDS_FONT_BODY));
        String _department = subscriber.getDepartment();
        String _institute = subscriber.getInstitution();
        String _shipping_address = subscriber.getShippingAddress();
        String _city = subscriber.getCity();
        String _country = subscriber.getCountry();
        String _state = subscriber.getState();
        int _pincode = subscriber.getPincode();

        if (_department != null && _department.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_department, JDSPDF.JDS_FONT_BODY));
        }
        if (_institute != null && _institute.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_institute, JDSPDF.JDS_FONT_BODY));
        }
        if (_shipping_address.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_shipping_address, JDSPDF.JDS_FONT_BODY));
        }
        if (_city.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_city, JDSPDF.JDS_FONT_BODY));
        }
        if (_state.length() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_state, JDSPDF.JDS_FONT_BODY));
        }
        if (_country.length() > 0 && !_country.equalsIgnoreCase("india")) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(_country, JDSPDF.JDS_FONT_BODY));
        }
        if (subscriber.getPincode() > 0) {
            paragraphShippingAddress.add(Chunk.NEWLINE);
            paragraphShippingAddress.add(new Phrase(String.valueOf(_pincode), JDSPDF.JDS_FONT_BODY));
        }

        PdfPCell shippingAddressCell = new PdfPCell(paragraphShippingAddress);
        shippingAddressCell.setBorder(Rectangle.NO_BORDER);
        shippingAddressCell.setPaddingLeft(0);
        shippingAddressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        shippingAddressCell.setVerticalAlignment(Element.ALIGN_TOP);        
        addressTable.addCell(shippingAddressCell);
        paragraph2.add(addressTable);

        paragraph3.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph2.setFont(_IASFont);
        paragraph3.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        paragraph3.setAlignment(Element.ALIGN_LEFT);

        Properties props = new Properties();
        props.load(this.pdfTemplatesFile);
        String template = props.getProperty("cheque_return");
        String _body = String.format(template, ChequeNumber,
                                     ChequeDate, String.valueOf(Amount));

        Chunk _bodychunk = new Chunk(_body, JDS_FONT_BODY);
        paragraph2.add(_bodychunk);

        paragraph2.add(Chunk.NEWLINE);
        //paragraph2.add(Chunk.NEWLINE);
        List orderedList = new List(List.UNORDERED);
        //orderedList.setListSymbol("*");
        orderedList.add(new ListItem(Reason, JDS_FONT_BODY));
        paragraph2.add(orderedList);
        paragraph.add(paragraph2);

        String _subscriber = String.format("%-13s : %-11s", "Subscriber No", SubscriberNumber);
        paragraph3.add(new Chunk(_subscriber, JDS_FONT_BODY));
        paragraph3.add(Chunk.NEWLINE);

        String _inward = String.format("%-15s : %-11s", "Inward No", InwardNumber);
        paragraph3.add(new Chunk(_inward, JDS_FONT_BODY));
        paragraph3.add(Chunk.NEWLINE);
        paragraph.add(paragraph3);


        return paragraph;

    }
}

package IAS.Class;

import IAS.Bean.Inward.inwardFormBean;
import IAS.Bean.Subscriber.subscriberFormBean;
import IAS.Model.Inward.inwardModel;
import IAS.Model.Subscriber.subscriberModel;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

public class InwardAckPDF extends JDSPDF {

    Connection conn = null;

    public InwardAckPDF(Connection _conn) {
        super();
        this.conn = _conn;
    }

    public ByteArrayOutputStream getPDF(int subscriptionID,
            String inwardNumber,
            int paymentModeID,
            String paymentMode,
            String inwardPurpose,
            int inwardPurposeID,
            String chqDDNumber,
            String chqDate,
            float amount,
            String LetterNumber,
            String LetterDate,
            String customText) throws SQLException, DocumentException, MalformedURLException, IOException {

        com.itextpdf.text.Document document = this.getPDFDocument();

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter pdfWriter = this.getPDFWriter(document, outputStream);

        document.open();
        document.add(this.getLetterHead());
        document.add(this.getInwardAckLetterBody(String.valueOf(subscriptionID),
                inwardNumber,
                paymentModeID,
                paymentMode,
                inwardPurpose,
                inwardPurposeID,
                LetterNumber,
                LetterDate,
                chqDDNumber,
                chqDate,
                String.valueOf(amount),
                customText));
        document.add(this.getLetterFooter());
        document.close();
        pdfWriter.close();
        return outputStream;

    }

    private Paragraph getInwardAckLetterBody(String subscriptionID,
            String inwardNumber,
            int paymentModeID,
            String paymentMode,
            String inwardPurpose,
            int inwardPurposeID,
            String letterNumber,
            String LetterDate,
            String chequeDDNo,
            String chqDate,
            String amount,
            String customText) throws SQLException, IOException {

        inwardModel _inwardModel = new inwardModel();
        inwardFormBean _inwardFormBean;
        try {
            _inwardFormBean = _inwardModel.GetInward(inwardNumber);
        } catch (ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException ex) {
            throw new IOException(ex);
        }
        Paragraph paragraph1 = new Paragraph();
        Paragraph paragraph2 = new Paragraph();
        Paragraph paragraph3 = new Paragraph();
        Paragraph address = new Paragraph();

        PdfPTable addressTable = new PdfPTable(1);
        addressTable.setWidthPercentage(100);
        addressTable.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        /*Chunk AddressHeader = new Chunk("ADDRESS", JDSPDF.JDS_FONT_BODY);
         AddressHeader.setTextRise(2);
         AddressHeader.setUnderline(1, 0);
         address.add(AddressHeader);
         address.add(Chunk.NEWLINE);*/

        /*
         * If the subscriber id is selected in the inward show the subscriber address in the pdf
         * else form the address using different fields of the inward
         */
        if (_inwardFormBean.getSubscriberId().length() > 0) {
            subscriberModel _subscriberModel = new subscriberModel();
            subscriberFormBean _subscriberFormBean;
            try {
                _subscriberFormBean = _subscriberModel.GetSubscriber(_inwardFormBean.getSubscriberId());
            } catch (ParseException | InvocationTargetException | IllegalAccessException | ClassNotFoundException ex) {
                throw new IOException(ex);
            }
            address.add(new Phrase(_subscriberFormBean.getFullShippingAddress(), JDSPDF.JDS_FONT_BODY));
        } else {
            address.add(new Phrase(_inwardFormBean.getInwardAddress(), JDSPDF.JDS_FONT_BODY));
        }

        //create a new cell and add the address para to the cell
        PdfPCell addressCell = new PdfPCell(address);
        addressCell.setBorder(Rectangle.NO_BORDER);
        //addressCell.setPaddingLeft(JDSPDF.LEFT_INDENTATION_MORE * 1);
        addressCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        addressCell.setVerticalAlignment(Element.ALIGN_TOP);

        // add the cell to the table
        addressTable.addCell(addressCell);

        // add the table to the main para
        paragraph1.add(addressTable);

        paragraph1.add(this.getSalutation());

        //paragraph1.setSpacingBefore(JDSPDF.OUTER_PARAGRAPH_SPACE);
        paragraph1.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraph1.setAlignment(Element.ALIGN_LEFT);

        paragraph2.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        paragraph2.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);

        //paragraph3.setIndentationLeft(JDSPDF.LEFT_INDENTATION_LESS);
        //paragraph3.setSpacingBefore(JDSPDF.INNER_PARAGRAPH_SPACE);
        //paragraph1.add(new Chunk("Subject: Acknowledgement of your request", JDSPDF.JDS_FONT_BODY));
        //paragraph1.add(Chunk.NEWLINE);

        String bodyText;
        float _amount = Float.parseFloat(amount);

        InwardAck _ack = new InwardAck();
        bodyText = _ack.getText(chequeDDNo, chqDate, _amount, paymentModeID, inwardPurposeID, letterNumber, LetterDate);
        if (!customText.isEmpty()) {
            bodyText = bodyText + "\n" + customText;
        }
        paragraph2.add(new Phrase(bodyText, JDSPDF.JDS_FONT_BODY));
        paragraph1.add(paragraph2);
        paragraph1.add(paragraph3);
        paragraph3.add(Chunk.NEWLINE);
        paragraph3.add(new Chunk("Inward No: " + inwardNumber, JDSPDF.JDS_FONT_BODY));

        return paragraph1;

    }
}

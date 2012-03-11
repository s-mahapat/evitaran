<%@page import="java.sql.ResultSet"%>
<%@page import="IAS.Model.Reports.reportModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="/JDS/css/report/printreport.css" />
        <title>SubTypes Report</title>
        <script type="text/javascript">

        </script>
    </head>
    <body onload="window.print()">
        <table class="reportTable">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Subscriber Type Code</th>
                    <th>Subscriber Type</th>
                    <th>Free/paid</th>
                    <th>Indian/Foreign</th>
                    <th>Institute/Personal</th>
                    <th>Free Journals</th>
                    <th>Discount</th>
                </tr>
            </thead>
            <tbody>

                <%
                    ResultSet rs = (ResultSet) request.getAttribute("ResultSet");
                    String html = null;
                    while (rs.next()) {
                        html = (html == null) ? "<tr><td>" : (html + "<tr><td>");
                        html += rs.getString(1) + "</td>"
                                + "<td>" + rs.getString(2) + "</td>"
                                + "<td>" + rs.getString(3) + "</td>"
                                + "<td>" + rs.getString(4) + "</td>"
                                + "<td>" + rs.getString(5) + "</td>"
                                + "<td>" + rs.getString(6) + "</td>"
                                + "<td>" + rs.getString(7) + "</td>"
                                + "<td>" + rs.getString(8) + "</td>";
                        html += "</tr>\n";
                    }
                    out.println(html);


                %>
            </tbody>
        </table>
    </body>
</html>

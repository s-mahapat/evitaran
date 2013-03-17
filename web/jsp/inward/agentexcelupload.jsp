<!DOCTYPE HTML>
<%--<%@include file="../templates/layout.jsp" %>--%>
<%--<form action="" method="POST" enctype="multipart/form-data" id="agntXLUploadForm">--%>
    <input type="hidden" name="purpose" id="purpose" value="<%=request.getParameter("purpose")%>"/>

    <fieldset class="MainFieldset">
        <legend>Upload Agent Excel</legend>
        <fieldset class="subMainFieldSet">
            <legend>File Upload</legend>
            <div class="IASFormLeftDiv">
                <div id="uploader">
                    <p>Your browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
                </div>
            </div>
            <div class="IASFormRightDiv">
                <div class="IASFormFieldDiv">
                    <b>Note:</b>
                    <ul style="margin-top: 0">
                        <li>The maximum file size for uploads is unlimited.</li>
                        <li>Only xls files (<strong>.XLS</strong>) are allowed.</li>
                        <li>The xls file will be validated and then subscriber and subscription will be created.</li>
                        <li>Click <a href="templates?id=1">here</a> to download excel template</li>
                    </ul>
                </div>
            </div>
        </fieldset>
        <fieldset class="subMainFieldSet">
            <legend>Results</legend>
            <div class="IASFormFieldDiv">
                <table class="datatable" id="subsTable"></table>
                <div id="pager"></div>
            </div>
        </fieldset>
    </fieldset>
    <div id="ErrorPage" style="padding:20px; display: none" title="Agent Excel Upload">                       
    </div>
<!--</form>-->

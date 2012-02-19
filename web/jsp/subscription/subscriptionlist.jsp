<%--
    Document   : Subscription List
--%>
<fieldset class="subMainFieldSet">
    <legend>Subscription Summary</legend>
    <div class="IASFormFieldDiv">
        <table class="datatable" id="subscriptionList"></table>
        <div id="pager"></div>

    </div>

</fieldset>
<fieldset class="subMainFieldSet">
    <a name="subdetails"></a>
    <legend>Subscription Details</legend>
    <div class="IASFormFieldDiv">
        <table class="datatable" id="subscriptionDetail"></table>
        <div id="pager2"></div>
    </div>
    <div class="IASFormRightDiv">
        <div class="IASFormFieldDiv">
            <span class="IASFormDivSpanLabel">
                <label>Remarks</label>
            </span>

            <span class="IASFormDivSpanInputBox">
                <textarea class="IASTextArea" TABINDEX="12" name="remarks" id="remarks"></textarea>
            </span>
        </div>
    </div>
</fieldset>
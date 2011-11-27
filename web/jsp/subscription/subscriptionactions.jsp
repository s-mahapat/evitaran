<%--
    Document   : Subscription Actions
--%>
<fieldset class="subMainFieldSet">

    <div class="actionBtnDiv">
        <input type="hidden" name="action" id="action"/>
        <input onclick="setActionValue('view')" class="IASButton" TABINDEX="101" type="submit" value="View Subscription" id="btnViewSubscription" name="btnSubmitAction"/>
        <input onclick="setActionValue('save')"  class="IASButton" TABINDEX="101" type="submit" value="Save" id="btnSaveSubscription" name="btnSubmitAction"/>
        <input onclick="setActionValue('edit')" class="IASButton" TABINDEX="101" type="submit" value="Edit Subscription" id="btnEditSubscription" name="btnSubmitAction"/>
    </div>

</fieldset>
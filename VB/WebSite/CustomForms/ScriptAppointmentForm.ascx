<%@ Control Language="vb" AutoEventWireup="true" CodeFile="ScriptAppointmentForm.ascx.vb" Inherits="CustomForms_ScriptAppointmentForm" %>

<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxsc" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>

<table class="dxscAppointmentForm" style="width: 600px; height: 100px;">
    <tr>
        <td class="dxscDoubleCell" colspan="2">
            <table class="dxscLabelControlPair">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblSubject" runat="server" AssociatedControlID="tbSubject" Text="Subject:" />
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxTextBox ID="tbSubject" runat="server" Width="100%" EnableClientSideAPI="true" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblStartDate" runat="server" AssociatedControlID="edtStartDate" Text="Start time:" />
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxDateEdit ID="edtStartDate" runat="server" Width="100%" EditFormat="DateTime" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair">
                <tr>
                    <td class="dxscLabelCell" style="padding-left: 25px;">
                        <dxe:ASPxLabel runat="server" ID="lblEndDate" Text="End time:" AssociatedControlID="edtEndDate" />
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxDateEdit ID="edtEndDate" runat="server" Width="100%" EditFormat="DateTime" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="dxscDoubleCell" colspan="2"> 
            <table class="dxscLabelControlPair">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblPrice" runat="server" AssociatedControlID="edtPrice" Text="Price:" />
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxTextBox ID="edtPrice" runat="server" Width="70px" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table style="width: 600px; height: 35px;">
    <tr>
        <td style="width: 100%; height: 100%;" align="center">
            <table style="height: 100%;">
                <tr>
                    <td>
                        <dxe:ASPxButton runat="server" ID="btnOk" Text="OK" UseSubmitBehavior="false"
                            AutoPostBack="false" EnableViewState="false" Width="91px" />
                    </td>
                    <td>
                        <dxe:ASPxButton runat="server" ID="btnCancel" Text="Cancel" UseSubmitBehavior="false"
                            AutoPostBack="false" EnableViewState="false" Width="91px"
                            CausesValidation="False" />
                    </td>
                    <td>
                        <dxe:ASPxButton runat="server" ID="btnDelete" Text="Delete" EnableClientSideApi="true"
                            UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" Width="91px" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script id="dxss_ASPxSchedulerClientAppoinmentForm" type="text/javascript">
    ASPxClientAppointmentForm =  ASPx.CreateClass(ASPxClientFormBase, {
        Initialize: function() {
            this.controls.btnOk.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnOkClick, this));
            this.controls.btnCancel.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnCancelClick, this));
            this.controls.btnDelete.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnDeleteClick, this));
        },
        OnBtnOkClick: function(s, e) {
            var apt = this.Parse();
            this.Close();
            if (apt.appointmentId) 
                this.scheduler.UpdateAppointment(apt);
            else {
                this.scheduler.InsertAppointment(apt);
           }
        },
        OnBtnCancelClick: function(s, e) {
            this.Close();
        },
        OnBtnDeleteClick: function(s, e) {
            var apt = this.Parse();
            this.Close();
            this.scheduler.DeleteAppointment(apt);
        },
        Parse: function() {
            var subject = this.controls.tbSubject.GetText();
            var start = this.controls.edtStartDate.GetDate();
            var end = this.controls.edtEndDate.GetDate();
            var price = this.controls.edtPrice.GetValue();

            var apt = new ASPxClientAppointment();

            apt.SetAppointmentType(ASPxAppointmentType.Normal);
            apt.SetSubject(subject);
            apt.SetStart(start);
            apt.SetEnd(end);
            apt.Price = price;

            if (this.appointmentCopy)
                apt.AddResource(this.appointmentCopy.GetResource(0));

            if (this.appointmentCopy && this.appointmentCopy.GetId()) 
                apt.SetId(this.appointmentCopy.GetId());

	        return apt;
        },
        Update: function(apt) {
            this.appointmentCopy = apt;
            this.controls.tbSubject.SetText(apt.GetSubject());
            this.controls.edtStartDate.SetDate(apt.GetStart());
            this.controls.edtEndDate.SetDate(apt.GetEnd());
            this.controls.edtPrice.SetText(apt.Price);
            this.controls.btnDelete.SetEnabled((apt.GetId()) ? true : false);
        },
        Clear: function() {
            this.controls.tbSubject.SetText('');
            this.controls.edtStartDate.SetDate();
            this.controls.edtEndDate.SetDate();
            this.controls.edtPrice.SetText('');
        }
    });
</script>
using System.Web.UI;
using DevExpress.Web.ASPxScheduler;

public partial class CustomForms_ScriptAppointmentForm : ASPxSchedulerClientFormBase {
    public override string ClassName { get { return "ASPxClientAppointmentForm"; } }

    protected override Control[] GetChildControls() {
        Control[] controls = new Control[] { 
            tbSubject, edtStartDate, edtEndDate,
            edtPrice, btnOk, btnCancel, btnDelete
        };
        return controls;
    }
}


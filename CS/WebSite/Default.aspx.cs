using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using DevExpress.XtraScheduler;
using DevExpress.Web.ASPxScheduler;

public partial class _Default : System.Web.UI.Page {
    private int lastInsertedAppointmentId;

    protected void Page_Load(object sender, EventArgs e) {
        ASPxScheduler1.DataBind();
        if (!IsPostBack) {
            if (ASPxScheduler1.Storage.Appointments.Count > 0)
                ASPxScheduler1.Start = ASPxScheduler1.Storage.Appointments[0].Start;
        }
    }

    protected void ASPxScheduler1_AppointmentRowInserting(object sender, DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertingEventArgs e) {
        e.NewValues.Remove("ID");
    }

    protected void SqlDataSourceAppointments_Inserted(object sender, SqlDataSourceStatusEventArgs e) {
        SqlConnection connection = (SqlConnection)e.Command.Connection;

        using (SqlCommand command = new SqlCommand("SELECT IDENT_CURRENT('CarScheduling')", connection)) {
            lastInsertedAppointmentId = Convert.ToInt32(command.ExecuteScalar());
        }
    }

    protected void ASPxScheduler1_AppointmentRowInserted(object sender, DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertedEventArgs e) {
        e.KeyFieldValue = lastInsertedAppointmentId;
    }

    protected void ASPxScheduler1_AppointmentsInserted(object sender, DevExpress.XtraScheduler.PersistentObjectsEventArgs e) {
        Appointment apt = (Appointment)e.Objects[0];
        ASPxSchedulerStorage storage = (ASPxSchedulerStorage)sender;
        storage.SetAppointmentId(apt, lastInsertedAppointmentId);
    }

    protected void ASPxScheduler1_BeforeExecuteCallbackCommand(object sender, SchedulerCallbackCommandEventArgs e) {
        if (e.CommandId == SchedulerCallbackCommandId.ClientSideUpdateAppointment)
            e.Command = new CustomUpdateAppointmentCommand((ASPxScheduler)sender);
        else if (e.CommandId == SchedulerCallbackCommandId.ClientSideInsertAppointment)
            e.Command = new CustomInsertAppointmentCommand((ASPxScheduler)sender);
    }
}
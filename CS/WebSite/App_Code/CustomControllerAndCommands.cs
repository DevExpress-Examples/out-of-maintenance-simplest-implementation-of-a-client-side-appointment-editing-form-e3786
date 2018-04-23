using System;
using DevExpress.XtraScheduler;
using DevExpress.Web.ASPxScheduler;
using DevExpress.Web.ASPxScheduler.Internal;

public class CustomInsertAppointmentCommand : AppointmentClientSideInsertCallbackCommand {
    public CustomInsertAppointmentCommand(ASPxScheduler scheduler)
        : base(scheduler) {
    }

    protected override AppointmentFormController CreateAppointmentFormController(Appointment apt) {
        return new CustomAppointmentFormController(Control, apt);
    }

    protected override void AssignControllerCustomFieldsValues(AppointmentFormController controller, ClientAppointmentProperties clientAppointment) {
        Appointment editedAppointment = controller.EditedAppointmentCopy;

        if (clientAppointment.Properties["Price"] != null) {
            double result = 0;
            Double.TryParse(clientAppointment.Properties["Price"].ToString(), out result);
            editedAppointment.CustomFields["Price"] = result;
        }

        base.AssignControllerCustomFieldsValues(controller, clientAppointment);
    }
}

public class CustomUpdateAppointmentCommand : AppointmentClientSideUpdateCallbackCommand {
    public CustomUpdateAppointmentCommand(ASPxScheduler scheduler)
        : base(scheduler) {
    }

    protected override AppointmentFormController CreateAppointmentFormController(Appointment apt) {
        return new CustomAppointmentFormController(Control, apt);
    }

    protected override void AssignControllerCustomFieldsValues(AppointmentFormController controller, ClientAppointmentProperties clientAppointment) {
        Appointment editedAppointment = controller.EditedAppointmentCopy;

        if (clientAppointment.Properties["Price"] != null) {
            double result = 0;
            Double.TryParse(clientAppointment.Properties["Price"].ToString(), out result);
            editedAppointment.CustomFields["Price"] = result;
        }
        else
            editedAppointment.CustomFields["Price"] = null;

        base.AssignControllerCustomFieldsValues(controller, clientAppointment);
    }
}

public class CustomAppointmentFormController : AppointmentFormController {
    private const string PriceFieldName = "Price";

    public CustomAppointmentFormController(ASPxScheduler control, Appointment apt)
        : base(control, apt) {
    }

    public double? Price {
        get { return (double?)EditedAppointmentCopy.CustomFields[PriceFieldName]; }
        set { EditedAppointmentCopy.CustomFields[PriceFieldName] = value; }
    }

    double? SourcePrice {
        get { return (double?)SourceAppointment.CustomFields[PriceFieldName]; }
        set { SourceAppointment.CustomFields[PriceFieldName] = value; }
    }

    protected override void ApplyCustomFieldsValues() {
        SourcePrice = Price;
    }
}
Imports System
Imports DevExpress.XtraScheduler
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal

Public Class CustomInsertAppointmentCommand
    Inherits AppointmentClientSideInsertCallbackCommand

    Public Sub New(ByVal scheduler As ASPxScheduler)
        MyBase.New(scheduler)
    End Sub

    Protected Overrides Function CreateAppointmentFormController(ByVal apt As Appointment) As AppointmentFormController
        Return New CustomAppointmentFormController(Control, apt)
    End Function

    Protected Overrides Sub AssignControllerCustomFieldsValues(ByVal controller As AppointmentFormController, ByVal clientAppointment As ClientAppointmentProperties)
        Dim editedAppointment As Appointment = controller.EditedAppointmentCopy

        If clientAppointment.Properties("Price") IsNot Nothing Then
            Dim result As Double = 0
            Double.TryParse(clientAppointment.Properties("Price").ToString(), result)
            editedAppointment.CustomFields("Price") = result
        End If

        MyBase.AssignControllerCustomFieldsValues(controller, clientAppointment)
    End Sub
End Class

Public Class CustomUpdateAppointmentCommand
    Inherits AppointmentClientSideUpdateCallbackCommand

    Public Sub New(ByVal scheduler As ASPxScheduler)
        MyBase.New(scheduler)
    End Sub

    Protected Overrides Function CreateAppointmentFormController(ByVal apt As Appointment) As AppointmentFormController
        Return New CustomAppointmentFormController(Control, apt)
    End Function

    Protected Overrides Sub AssignControllerCustomFieldsValues(ByVal controller As AppointmentFormController, ByVal clientAppointment As ClientAppointmentProperties)
        Dim editedAppointment As Appointment = controller.EditedAppointmentCopy

        If clientAppointment.Properties("Price") IsNot Nothing Then
            Dim result As Double = 0
            Double.TryParse(clientAppointment.Properties("Price").ToString(), result)
            editedAppointment.CustomFields("Price") = result
        Else
            editedAppointment.CustomFields("Price") = Nothing
        End If

        MyBase.AssignControllerCustomFieldsValues(controller, clientAppointment)
    End Sub
End Class

Public Class CustomAppointmentFormController
    Inherits AppointmentFormController

    Private Const PriceFieldName As String = "Price"

    Public Sub New(ByVal control As ASPxScheduler, ByVal apt As Appointment)
        MyBase.New(control, apt)
    End Sub

    Public Property Price() As Double?
        Get
            Return CType(EditedAppointmentCopy.CustomFields(PriceFieldName), Double?)
        End Get
        Set(ByVal value? As Double)
            EditedAppointmentCopy.CustomFields(PriceFieldName) = value
        End Set
    End Property

    Private Property SourcePrice() As Double?
        Get
            Return CType(SourceAppointment.CustomFields(PriceFieldName), Double?)
        End Get
        Set(ByVal value? As Double)
            SourceAppointment.CustomFields(PriceFieldName) = value
        End Set
    End Property

    Protected Overrides Sub ApplyCustomFieldsValues()
        SourcePrice = Price
    End Sub
End Class
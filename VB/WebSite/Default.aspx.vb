﻿Imports System
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports DevExpress.XtraScheduler
Imports DevExpress.Web.ASPxScheduler

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Private lastInsertedAppointmentId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        ASPxScheduler1.DataBind()
        If Not IsPostBack Then
            If ASPxScheduler1.Storage.Appointments.Count > 0 Then
                ASPxScheduler1.Start = ASPxScheduler1.Storage.Appointments(0).Start
            End If
        End If
    End Sub

    Protected Sub ASPxScheduler1_AppointmentRowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertingEventArgs)
        e.NewValues.Remove("ID")
    End Sub

    Protected Sub SqlDataSourceAppointments_Inserted(ByVal sender As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim connection As SqlConnection = CType(e.Command.Connection, SqlConnection)

        Using command As New SqlCommand("SELECT IDENT_CURRENT('CarScheduling')", connection)
            lastInsertedAppointmentId = Convert.ToInt32(command.ExecuteScalar())
        End Using
    End Sub

    Protected Sub ASPxScheduler1_AppointmentRowInserted(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertedEventArgs)
        e.KeyFieldValue = lastInsertedAppointmentId
    End Sub

    Protected Sub ASPxScheduler1_AppointmentsInserted(ByVal sender As Object, ByVal e As DevExpress.XtraScheduler.PersistentObjectsEventArgs)
        Dim apt As Appointment = CType(e.Objects(0), Appointment)
        Dim storage As ASPxSchedulerStorage = DirectCast(sender, ASPxSchedulerStorage)
        storage.SetAppointmentId(apt, lastInsertedAppointmentId)
    End Sub

    Protected Sub ASPxScheduler1_BeforeExecuteCallbackCommand(ByVal sender As Object, ByVal e As SchedulerCallbackCommandEventArgs)
        If e.CommandId = SchedulerCallbackCommandId.ClientSideUpdateAppointment Then
            e.Command = New CustomUpdateAppointmentCommand(DirectCast(sender, ASPxScheduler))
        ElseIf e.CommandId = SchedulerCallbackCommandId.ClientSideInsertAppointment Then
            e.Command = New CustomInsertAppointmentCommand(DirectCast(sender, ASPxScheduler))
        End If
    End Sub
End Class
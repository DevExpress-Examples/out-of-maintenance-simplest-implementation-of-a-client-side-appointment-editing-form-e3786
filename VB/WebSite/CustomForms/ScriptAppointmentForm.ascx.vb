Imports Microsoft.VisualBasic
Imports System.Web.UI
Imports DevExpress.Web.ASPxScheduler

Partial Public Class CustomForms_ScriptAppointmentForm
	Inherits ASPxSchedulerClientFormBase
	Public Overrides ReadOnly Property ClassName() As String
		Get
			Return "ASPxClientAppointmentForm"
		End Get
	End Property

	Protected Overrides Function GetChildControls() As Control()
		Dim controls() As Control = { tbSubject, edtStartDate, edtEndDate, edtPrice, btnOk, btnCancel, btnDelete }
		Return controls
	End Function
End Class


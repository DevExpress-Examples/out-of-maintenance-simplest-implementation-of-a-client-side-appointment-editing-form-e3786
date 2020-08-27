<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v18.1, Version=18.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v18.1.Core, Version=18.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="dxschsc" %>
<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Src="~/CustomForms/ScriptAppointmentForm.ascx" TagName="ScriptAppointmentForm" TagPrefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script type="text/javascript">
        function OnPredefinedMenuItemClick(s, e) {
            if (e.itemName == "OpenAppointment") {
                e.handled = true;
                OpenAppointment(scheduler);
            }
            else if (e.itemName == "NewAppointment") {
                e.handled = true;
                NewAppointment(scheduler);
            }
            else if (e.itemName == "NewAllDayEvent") {
                e.handled = true;
                NewAllDayEvent(scheduler);
            }
        }

        function NewAppointment(scheduler) {
            var apt = CreateAppointment(scheduler)
            ShowAppointmentForm(apt);
        }

        function NewAllDayEvent(scheduler) {
            var apt = CreateAllDayEvent(scheduler);
            ShowAppointmentForm(apt);
        }

        function OpenAppointment(scheduler) {
            var apt = GetSelectedAppointment(scheduler);
            scheduler.RefreshClientAppointmentProperties(apt, AppointmentPropertyNames.Normal + ";Price", OnAppointmentRefresh);
        }

        function CreateAppointment(scheduler) {
            var apt = new ASPxClientAppointment();
            var selectedInterval = scheduler.GetSelectedInterval();
            apt.SetStart(selectedInterval.GetStart());
            apt.SetEnd(selectedInterval.GetEnd());
            apt.AddResource(scheduler.GetSelectedResource());
            apt.SetLabelId(0);
            apt.SetStatusId(0);
            return apt;
        }

        function CreateAllDayEvent(scheduler) {
            var apt = CreateAppointment(scheduler);
            var start = apt.interval.start;
            var today = new Date(start.getFullYear(), start.getMonth(), start.getDate());
            apt.SetStart(today);
            apt.SetDuration(24 * 60 * 60 * 1000);
            apt.SetAllDay(true);
            return apt;
        }

        function GetSelectedAppointment(scheduler) {
            var aptIds = scheduler.GetSelectedAppointmentIds();
            if (aptIds.length == 0)
                return;
            var apt = scheduler.GetAppointmentById(aptIds[0]);
            return apt;
        }

        function OnAppointmentRefresh(apt) {
            ShowAppointmentForm(apt);
        }

        function ShowAppointmentForm(apt) {
            MyScriptForm.Clear();
            MyScriptForm.Update(apt);
            if (apt.GetSubject() != "")
                myFormPopup.SetHeaderText(apt.GetSubject() + " - Appointment");
            else
                myFormPopup.SetHeaderText("Untitled - Appointment");
            myFormPopup.Show();
        }

        function CloseAppointmentForm() {
            myFormPopup.Hide();
            myFormPopup.SetSize(0, 0);
        }
    </script>
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server" ClientInstanceName="scheduler" GroupType="Resource"
                AppointmentDataSourceID="SqlDataSourceAppointments"
                ResourceDataSourceID="SqlDataSourceResources"
                OnBeforeExecuteCallbackCommand="ASPxScheduler1_BeforeExecuteCallbackCommand"
                OnAppointmentRowInserted="ASPxScheduler1_AppointmentRowInserted"
                OnAppointmentRowInserting="ASPxScheduler1_AppointmentRowInserting"
                OnAppointmentsInserted="ASPxScheduler1_AppointmentsInserted">
                <ClientSideEvents MenuItemClicked="OnPredefinedMenuItemClick" />
                <Storage>
                    <Appointments ResourceSharing="True">
                        <Mappings
                            AppointmentId="ID"
                            AllDay="AllDay"
                            Description="Description"
                            End="EndTime"
                            Label="Label"
                            Location="Location"
                            ReminderInfo="ReminderInfo"
                            ResourceId="CarId"
                            Start="StartTime"
                            Status="Status"
                            Subject="Subject" />
                        <CustomFieldMappings>
                            <dxwschs:ASPxAppointmentCustomFieldMapping Name="Price" Member="Price" ValueType="Decimal" />
                        </CustomFieldMappings>
                    </Appointments>
                    <Resources>
                        <Mappings
                            ResourceId="ID"
                            Caption="Model" />
                    </Resources>
                </Storage>
                <Views>
                    <DayView ResourcesPerPage="3" />
                </Views>
            </dxwschs:ASPxScheduler>

            <asp:SqlDataSource ID="SqlDataSourceResources" runat="server"
                ConnectionString="<%$ ConnectionStrings:CarsXtraSchedulingConnectionString %>"
                SelectCommand="SELECT [ID], [Model] FROM [Cars]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceAppointments" runat="server"
                ConnectionString="<%$ ConnectionStrings:CarsXtraSchedulingConnectionString %>"
                DeleteCommand="DELETE FROM [CarScheduling] WHERE [ID] = @ID"
                InsertCommand="INSERT INTO [CarScheduling] ([CarId], [UserId], [Status], [Subject], [Description], [Label], [StartTime], [EndTime], [Location], [AllDay], [EventType], [RecurrenceInfo], [ReminderInfo], [Price], [ContactInfo]) VALUES (@CarId, @UserId, @Status, @Subject, @Description, @Label, @StartTime, @EndTime, @Location, @AllDay, @EventType, @RecurrenceInfo, @ReminderInfo, @Price, @ContactInfo)"
                SelectCommand="SELECT * FROM [CarScheduling]"
                UpdateCommand="UPDATE [CarScheduling] SET [CarId] = @CarId, [UserId] = @UserId, [Status] = @Status, [Subject] = @Subject, [Description] = @Description, [Label] = @Label, [StartTime] = @StartTime, [EndTime] = @EndTime, [Location] = @Location, [AllDay] = @AllDay, [EventType] = @EventType, [RecurrenceInfo] = @RecurrenceInfo, [ReminderInfo] = @ReminderInfo, [Price] = @Price, [ContactInfo] = @ContactInfo WHERE [ID] = @ID"
                OnInserted="SqlDataSourceAppointments_Inserted">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                    <asp:Parameter Name="CarId" Type="String" />
                    <asp:Parameter Name="UserId" Type="Int32" />
                    <asp:Parameter Name="Status" Type="Int32" />
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Label" Type="Int32" />
                    <asp:Parameter Name="StartTime" Type="DateTime" />
                    <asp:Parameter Name="EndTime" Type="DateTime" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="AllDay" Type="Boolean" />
                    <asp:Parameter Name="EventType" Type="Int32" />
                    <asp:Parameter Name="RecurrenceInfo" Type="String" />
                    <asp:Parameter Name="ReminderInfo" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="ContactInfo" Type="String" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="CarId" Type="String" />
                    <asp:Parameter Name="UserId" Type="Int32" />
                    <asp:Parameter Name="Status" Type="Int32" />
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Label" Type="Int32" />
                    <asp:Parameter Name="StartTime" Type="DateTime" />
                    <asp:Parameter Name="EndTime" Type="DateTime" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="AllDay" Type="Boolean" />
                    <asp:Parameter Name="EventType" Type="Int32" />
                    <asp:Parameter Name="RecurrenceInfo" Type="String" />
                    <asp:Parameter Name="ReminderInfo" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="ContactInfo" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="myFormPopup"
                AllowDragging="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                PopupAnimationType="Auto" Width="0px" Height="0px" Modal="true" CloseAction="CloseButton">
                <ContentCollection>
                    <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <form:ScriptAppointmentForm runat="server" ID="AppointmentForm" SchedulerId="ASPxScheduler1"
                            ClientInstanceName="MyScriptForm" ClientSideEvents-FormClosed="function(s, e) { CloseAppointmentForm();}" />
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
        </div>
    </form>
</body>
</html>

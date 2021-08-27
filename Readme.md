<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128547927/18.1.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E3786)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
# Simplest implementation of a client-side appointment editing form


<p>This example illustrates the simplest possible implementation for the client-side appointment editing form. This form allows modifying only four attributes of an appointment: </p><p>- Subject, Start, and End regular attributes<br />
- Price custom field</p><p>Other features are skipped/disabled for the sake of clarity. Note that it is necessary to leave the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxSchedulerASPxAppointmentMappingInfo_RecurrenceInfotopic"><u>ASPxAppointmentMappingInfo.RecurrenceInfo</u></a> and <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxSchedulerASPxAppointmentMappingInfo_Typetopic"><u>ASPxAppointmentMappingInfo.Type</u></a> mappings empty to completely disable the <a href="http://documentation.devexpress.com/#AspNet/CustomDocument3812"><u>Recurrence</u></a> feature. In this case, all pattern appointments and exceptions will be displayed as simple (non-recurring) appointments, and recurrence information contained in patterns will be ignored. The <strong>New Recurring Appointment</strong> and <strong>New Recurring Event</strong> items will be removed from the context menu.</p><p>Prior to running this example, it is required to register a CarsXtraScheduling database on your local SQL Server instance. You can download the corresponding SQL scripts from the <a href="https://www.devexpress.com/Support/Center/p/E215">How to bind ASPxScheduler to MS SQL Server database</a> example.</p><p><strong>See Also:</strong><br />
<a href="https://www.devexpress.com/Support/Center/p/E1547">How to implement a client-side appointment editing form with custom fields</a></p>

<br/>



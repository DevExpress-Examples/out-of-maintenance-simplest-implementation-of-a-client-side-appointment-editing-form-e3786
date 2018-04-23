<%--
{************************************************************************************}
{                                                                                    }
{   DO NOT MODIFY THIS FILE!                                                         }
{                                                                                    }
{   It will be overwritten without prompting when a new version becomes              }
{   available. All your changes will be lost.                                        }
{                                                                                    }
{   This file contains the default template and is required for the form             }
{   rendering. Improper modifications may result in incorrect behavior of            }
{   the appointment form.                                                            }
{                                                                                    }
{   In order to create and use your own custom template, perform the following       }
{   steps:                                                                           }
{       1. Save a copy of this file with a different name in another location.       }
{       2. Specify the file location as the                                          }
{          'OptionsForms.RecurrentAppointmentDeleteFormTemplateUrl'                  }
{          property of the ASPxScheduler control.                                    }
{       3. If you need to display and process additional controls, you               }
{          should accomplish steps 4-6; otherwise, go to step 7.                     }
{       4. Create a class, derived from the                                          }
{          RecurrentAppointmentDeleteFormTemplateContainer,                          }
{          containing additional properties which correspond to your controls.       }
{          This class definition can be located within a class file in the App_Code  }
{          folder.                                                                   }
{       5. Replace RecurrentAppointmentDeleteFormTemplateContainer references in the }
{          template page with the name of the class you've created in step 4.        }
{       6. Handle the RecurrentAppointmentDeleteFormShowing event to create an       }
{          instance of the  template container class, defined in step 5, and specify }
{          it as the destination container  instead of the  default one.             }
{       7. Modify the overall appearance of the page and its layout.                 }
{                                                                                    }
{************************************************************************************}
--%>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="RecurrentAppointmentDeleteForm" CodeFile="RecurrentAppointmentDeleteForm.ascx.cs" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v10.1, Version=10.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v10.1, Version=10.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<table style="width:100%; height:100%">
    <tr>
        <td rowspan="2"  style="vertical-align:top;">
            <dxe:ASPxImage id="imgWarning" runat="server" EnableViewState="False">
            </dxe:ASPxImage>
        </td>
        <td style="width:100%;">
            <dxe:ASPxLabel ID="lblConfirm" runat="server" Text='<%# "Do you want to delete all occurrences of the recurring appointment \"" + ((DevExpress.Web.ASPxScheduler.RecurrentAppointmentDeleteFormTemplateContainer)Container).Appointment.Subject + "\", or just this one?"%>'/>
        </td>
    </tr>
    <tr>
        <td style="width:100%;">
            <dxe:ASPxRadioButtonList ID="rbAction" runat="server" ValueType="System.Int32" SelectedIndex="0">
                                <Border BorderStyle="None" />
                                <Items>
                                    <dxe:ListEditItem Text="The series" Value="1" />
                                    <dxe:ListEditItem Text="This occurrence" Value="2" />
                                </Items>
                            </dxe:ASPxRadioButtonList>
        </td>
    </tr>
    <tr>
        <td align="center" style="width:100%" colspan="2">
            <table>
                <tr>
                    <td>
                        <dxe:ASPxButton ID="btnOk" ClientInstanceName="_dx" runat="server" Text="OK" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" Width="91px" />
                    </td>
                    <td>
                        <dxe:ASPxButton ID="btnCancel" ClientInstanceName="_dx" runat="server" Text="Cancel" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" 
                            Width="91px" CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>    

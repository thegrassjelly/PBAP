<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewReservations.aspx.cs" Inherits="Admin_Reservations_ViewReservations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-list"></i> View Reservations
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-1">
                            <div class="input-group">
                                <asp:DropDownList ID="ddlStatus" runat="server" class="form-control"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                    <asp:ListItem>All Reservations</asp:ListItem>
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Approved</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <asp:DropDownList ID="ddlPaymentStatus" runat="server" class="form-control"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlPaymentStatus_SelectedIndexChanged">
                                    <asp:ListItem>All Payments</asp:ListItem>
                                    <asp:ListItem>Unpaid</asp:ListItem>
                                    <asp:ListItem>Paid</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" class="form-control autosuggest"
                                    placeholder="Keyword..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                <span class="input-group-btn">
                                    <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-info"
                                        OnClick="btnSearch_Click">
                                      <i class="fa fa-search"></i>
                                    </asp:LinkButton>
                                </span>
                            </div>
                        </div>
                    </div>

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>#</th>
                                    <th>Attendee Name</th>
                                    <th>Seminar Code</th>
                                    <th>Seminar Title</th>
                                    <th>Reservation Status</th>
                                    <th>Payment Status</th>
                                    <th>Reservation Date</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvReservations" runat="server"
                                        OnPagePropertiesChanging="lvReservations_PagePropertiesChanging"
                                        OnDataBound="lvReservations_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("ReservationID") %></td>
                                                <td><%# Eval("AttendeeName") %></td>
                                                <td><%# Eval("SeminarCode") %></td>
                                                <td><%# Eval("SeminarTitle") %></td>
                                                <td><span class="label label-primary"><%# Eval("ReservationStatus") %></span</td>
                                                <td><span class="label label-success"><%# Eval("PaymentStatus") %></span</td>
                                                <td><%# Eval("DateAdded", "{0: MMMM dd, yyyy}") %></td>
                                                <td><%# Eval("DateModified", "{0: MMMM dd, yyyy}") %></td>
                                                <td>
                                                    <a href='ReservationDetails.aspx?ID=<%# Eval("ReservationID") %>'>
                                                        <asp:Label runat="server" ToolTip="Show Info"><i class="fa fa-search"></i></asp:Label></a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <tr>
                                                <td colspan="12">
                                                    <h2 class="text-center">No records found.</h2>
                                                </td>
                                            </tr>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">
                                    <center>
                                        <asp:DataPager id="dpReservations" runat="server" pageSize="10" PagedControlID="lvReservations" QueryStringField="PageNumber">
                                            <Fields>
                                                <asp:NumericPagerField Buttontype="Button"
                                                    NumericButtonCssClass="btn btn-default"
                                                    CurrentPageLabelCssClass="btn btn-success"
                                                    NextPreviousButtonCssClass ="btn btn-default" 
                                                    ButtonCount="10" />
                                            </Fields>
                                        </asp:DataPager>
                                    </center>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


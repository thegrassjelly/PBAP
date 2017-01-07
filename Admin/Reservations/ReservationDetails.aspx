<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ReservationDetails.aspx.cs" Inherits="Admin_Reservations_ReservationDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-search"></i> Reservation & Payment Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="col-lg-12">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-lg-7">
                        <div class="panel panel-midnightblue">
                            <div class="panel-heading">
                                Reservation Information
                            </div>
                            <div class="panel-body">
                                <div id="upsuccess" runat="server" class="alert alert-success" visible="false">
                                    Reservation Status Updated.
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4"></label>
                                        <div class="col-lg-1">
                                            <a href="#" data-toggle="modal" data-target="#userInfo" title="View Attendee Info">
                                                <span id="driverModal" visible="true" runat="server" class="btn btn-primary">
                                                    <i class="fa fa-male"></i> View Attendee Info
                                                </span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Seminar Code</label>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtCode" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Seminar Title</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtTitle" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Competency</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtCompt" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Units</label>
                                        <div class="col-lg-4">
                                            <asp:TextBox ID="txtUnits" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Seminar Fee</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtFee" class="form-control" runat="server" TextMode="Number" disabled />
                                                <span class="input-group-addon">.00</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Location</label>
                                        <div class="col-lg-6">
                                            <asp:TextBox ID="txtLocation" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Seminar Date</label>
                                        <div class="col-lg-7">
                                            <div id="pnlTBA" runat="server" visible="false">
                                                <asp:TextBox ID="txtTBA" class="form-control" runat="server" disabled />
                                            </div>
                                            <div id="pnlDate" runat="server">
                                            <div class="input-group date" id="datepicker-pastdisabled">
                                                <asp:TextBox ID="txtDate" class="form-control" runat="server" TextMode="Date" disabled />
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Speaker</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtSpeaker" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Date Added</label>
                                        <div class="col-lg-7">
                                            <div class="input-group date" id="datepicker-pastdisabled">
                                                <asp:TextBox ID="txtDAdded" class="form-control" runat="server" TextMode="Date" disabled />
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="control-label col-lg-2">Description</label>
                                        <div class="col-lg-10">
                                            <asp:TextBox ID="txtDesc" class="form-control" runat="server"
                                                TextMode="Multiline" Style="max-width: 100%;" disabled />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <hr />
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4">Reservation Date</label>
                                            <div class="col-lg-7">
                                                <div class="input-group date" id="datepicker-pastdisabled">
                                                    <asp:TextBox ID="txtRDate" class="form-control" runat="server" TextMode="Date" disabled />
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4">Reservation Status</label>
                                            <div class="col-lg-5">
                                                <asp:DropDownList ID="ddlRStatus" class="form-control" runat="server">
                                                    <asp:ListItem>Pending</asp:ListItem>
                                                    <asp:ListItem>Approved</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <div class="pull-right">
                                    <asp:Button ID="btnUpdateRStatus" class="btn btn-success" runat="server"
                                        Text="Update Reservation Status" OnClick="btnUpdateRStatus_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnUpdateRStatus" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-lg-5">
                        <div class="panel panel-midnightblue">
                            <div class="panel-heading">
                                Payment Information
                            </div>
                            <div class="panel-body">
                                <div id="paysuccess" runat="server" class="alert alert-success" visible="false">
                                    Payment Status Updated.
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Payment ID</label>
                                    <div class="col-lg-2">
                                        <asp:TextBox ID="txtPayID" runat="server" class="form-control"
                                            disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Subscription ID</label>
                                    <div class="col-lg-2">
                                        <asp:TextBox ID="txtSID" runat="server" class="form-control"
                                            disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Voucher Code</label>
                                    <div class="col-lg-3">
                                        <asp:TextBox ID="txtVoucher" runat="server" class="form-control"
                                            disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Payment Amount</label>
                                    <div class="col-lg-5">
                                        <div class="input-group">
                                            <span class="input-group-addon">₱</span>
                                            <asp:TextBox ID="txtPaymentAmount" class="form-control" runat="server" TextMode="Number" disabled />
                                            <span class="input-group-addon">.00</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Payment Type</label>
                                    <div class="col-lg-4">
                                        <asp:DropDownList ID="ddlPayType" class="form-control" runat="server" disabled>
                                            <asp:ListItem>Cash</asp:ListItem>
                                            <asp:ListItem>Bank Deposit</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Payment Date</label>
                                    <div class="col-lg-4">
                                        <div class="input-group date" id="datepicker-pastdisabled">
                                            <asp:TextBox ID="txtPaymentDate" class="form-control" runat="server" TextMode="Date" required />
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Payment Status</label>
                                    <div class="col-lg-4">
                                        <asp:DropDownList ID="ddlPayStatus" runat="server" class="form-control">
                                            <asp:ListItem>Paid</asp:ListItem>
                                            <asp:ListItem>Unpaid</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <div class="pull-right">
                                    <asp:Button ID="btnUpdatePayStatus" class="btn btn-success" runat="server"
                                        Text="Update Payment Status" OnClick="btnUpdatePayStatus_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnUpdatePayStatus" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div id="userInfo" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">User Information</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel panel-midnightblue">
                            <div class="panel-body">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">User ID</label>
                                        <div class="col-lg-4">
                                            <asp:TextBox ID="txtID" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">First Name</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtFN" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Middle Name</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtMN" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Last Name</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtLN" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Date of Birth</label>
                                        <div class="col-lg-8">
                                            <asp:TextBox ID="txtBday" class="form-control" runat="server" TextMode="Date" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Company</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtCompany" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Position</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtPosition" class="form-control" runat="server" disabled />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Email</label>
                                        <div class="col-lg-8">
                                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                                                class="form-control" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Mobile No.</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtMNo" class="form-control" runat="server"
                                                TextMode="Number" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Landline No.</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtLNo" class="form-control" runat="server"
                                                TextMode="Number" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Fax No.</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtFax" class="form-control" runat="server"
                                                TextMode="Number" disabled />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Status</label>
                                        <div class="col-lg-6">
                                            <asp:DropDownList ID="ddlStatus" class="form-control" runat="server" disabled>
                                                <asp:ListItem>Active</asp:ListItem>
                                                <asp:ListItem>Inactive</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">User Type</label>
                                        <div class="col-lg-6">
                                            <asp:DropDownList ID="ddlType" class="form-control" runat="server" disabled>
                                                <asp:ListItem>User</asp:ListItem>
                                                <asp:ListItem>Admin</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="control-label col-lg-2">Address</label>
                                        <div class="col-lg-10">
                                            <asp:TextBox ID="txtAddr" class="form-control" runat="server"
                                                TextMode="Multiline" Style="max-width: 100%;" disabled />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


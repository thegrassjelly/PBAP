<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewLogins.aspx.cs" Inherits="Admin_Logs_ViewLogins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i> User Login Logs
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-12">
                    <div class="panel panel-midnightblue">
                        <div class="panel-body">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>#</th>
                                    <th>User Name</th>
                                    <th>Log Title</th>
                                    <th>User IP Address</th>
                                    <th>Log Type</th>
                                    <th>Log Date</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvLoginLogs" runat="server"
                                        OnPagePropertiesChanging="lvLoginLogs_PagePropertiesChanging"
                                        OnDataBound="lvLoginLogs_DataBound"
                                        OnItemCommand="lvLoginLogs_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("LogID") %></td>
                                                <asp:Literal ID="ltUserID" runat="server" Text='<%# Eval("UserID") %>' Visible="false" />
                                                <td><%# Eval("UserName") %></td>
                                                <td><%# Eval("LogTitle") %></td>
                                                <td><%# Eval("LogContent") %></td>
                                                <td><span class="label label-success">
                                                    <%# Eval("LogType") %>
                                                     </span>
                                                </td>
                                                <td><%# Eval("LogDate") %></td>
                                                <td>
                                                    <asp:Button ID="btnUserInfo" CommandName="userinfo"
                                                        class="btn btn-sm btn-primary" runat="server" Text='View User Info'
                                                        OnSubmitBehavior="false" />
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
                        </div>
                        <div class="panel-footer">
                            <center>
                                        <asp:DataPager id="dpLogs" runat="server" pageSize="10" PagedControlID="lvLoginLogs">
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
            </ContentTemplate>
        </asp:UpdatePanel>

        <div id="userInfo" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">User Information</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel panel-midnightblue">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
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
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


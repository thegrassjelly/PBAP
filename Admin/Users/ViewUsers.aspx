<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewUsers.aspx.cs" Inherits="Admin_Users_ViewUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-list"></i> Users List
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
                                    <asp:ListItem Text="Active" Value="Active" />
                                    <asp:ListItem Text="Inactive" Value="Inactive" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-1">
                            <div class="input-group">
                                <asp:DropDownList ID="ddlType" runat="server" class="form-control"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                    <asp:ListItem Text="All Users" />
                                    <asp:ListItem Text="User" Value="User" />
                                    <asp:ListItem Text="Admin" Value="Admin" />
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
                                    <th>Name</th>
                                    <th>Company</th>
                                    <th>Position</th>
                                    <th>Email Address</th>
                                    <th>Mobile No.</th>
                                    <th>Status</th>
                                    <th>User Type</th>
                                    <th>Date Added</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvUsers" runat="server"
                                        OnPagePropertiesChanging="lvUsers_PagePropertiesChanging"
                                        OnDataBound="lvUsers_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("UserID") %></td>
                                                <td><%# Eval("UserName") %></td>
                                                <td><%# Eval("UserCompany") %></td>
                                                <td><%# Eval("UserPosition") %></td>
                                                <td><%# Eval("UserEmail") %></td>
                                                <td><%# Eval("UserMobileNo") %></td>
                                                <td><span class="label label-success"><%# Eval("UserStatus") %></span</td>
                                                <td><span class="label label-primary"><%# Eval("UserType") %></span</td>
                                                <td><%# Eval("DateAdded", "{0: MMMM dd, yyyy}") %></td>
                                                <td><%# Eval("DateModified", "{0: MMMM dd, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateUsers.aspx?ID=<%# Eval("UserID") %>'>
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
                                        <asp:DataPager id="dpUsers" runat="server" pageSize="10" PagedControlID="lvUsers" QueryStringField="PageNumber">
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


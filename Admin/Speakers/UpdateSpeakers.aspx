<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="UpdateSpeakers.aspx.cs" Inherits="Admin_Speakers_UpdateSpeakers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<i class="fa fa-edit"></i> Update Speaker Information
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Speaker Information
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="control-label col-lg-3">Speaker ID</label>
                        <div class="col-lg-1">
                            <asp:TextBox ID="txtID" class="form-control" runat="server" disabled />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Title</label>
                        <div class="col-lg-2">
                            <asp:DropDownList ID="ddlTitle" class="form-control" runat="server">
                                <asp:ListItem>Mr.</asp:ListItem>
                                <asp:ListItem>Ms.</asp:ListItem>
                                <asp:ListItem>Mrs.</asp:ListItem>
                                <asp:ListItem>Dr.</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">First Name</label>
                        <div class="col-lg-5">
                            <asp:TextBox ID="txtFN" class="form-control" runat="server" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Last Name</label>
                        <div class="col-lg-5">
                            <asp:TextBox ID="txtLN" class="form-control" runat="server" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Mobile No.</label>
                        <div class="col-lg-3">
                            <asp:TextBox ID="txtMN" class="form-control" TextMode="Number" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Email Address</label>
                        <div class="col-lg-3">
                            <asp:TextBox ID="txtEAdd" class="form-control" TextMode="Email" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">Speaker Status</label>
                        <div class="col-lg-3">
                            <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                <asp:ListItem>Active</asp:ListItem>
                                <asp:ListItem>Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="pull-right">
                        <asp:Button ID="btnUpdate" class="btn btn-success" runat="server" Text="Update"
                            OnClick="btnUpdate_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


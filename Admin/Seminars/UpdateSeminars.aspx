<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="UpdateSeminars.aspx.cs" Inherits="Admin_Seminars_UpdateSeminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-edit"></i>Update Seminar Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Seminar Details
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Seminar ID</label>
                            <div class="col-lg-2">
                                <asp:TextBox ID="txtID" class="form-control" runat="server" disabled />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Seminar Code</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtCode" class="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Seminar Title</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtTitle" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Competency</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtCompetency" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Units</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtUnits" TextMode="Number" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Seminar Price</label>
                            <div class="col-lg-6">
                                <div class="input-group">
                                    <span class="input-group-addon">₱</span>
                                    <asp:TextBox ID="txtPrice" class="form-control" runat="server" TextMode="Number" required />
                                    <span class="input-group-addon">.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Venue</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtLocation" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Date</label>
                            <div class="col-lg-6">
                                <div class="input-group date" id="datepicker-pastdisabled">
                                    <asp:TextBox ID="txtDate" class="form-control" runat="server" TextMode="Date" required />
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Status</label>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Speaker</label>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="ddlSpeaker" class="form-control" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label class="control-label col-lg-1">Description</label>
                            <div class="col-lg-10">
                                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"
                                    class="form-control" Style="max-width: 100%;" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="pull-right">
                        <asp:Button ID="btnUpdate" class="btn btn-success" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


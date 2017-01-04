<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="AddSeminars.aspx.cs" Inherits="Admin_Seminars_AddSeminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <h1><i class="icon icon-plus"></i> Add New Seminars</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon"><i class="icon-plus"></i></span>
                    <h5>Seminar Details</h5>
                </div>
                <div class="widget-content nopadding">
                    <div class="span6">
                        <div class="control-group">
                            <label class="control-label">Seminar Code</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCode" runat="server" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Seminar Title</label>
                            <div class="controls">
                                <asp:TextBox ID="txtTitle" runat="server" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Competency</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCompetency" runat="server" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Units</label>
                            <div class="controls">
                                <asp:TextBox ID="txtUnits" TextMode="Number" runat="server" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Description</label>
                            <div class="controls">
                                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"
                                    Style="max-width: 100%;" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Seminar Price</label>
                            <div class="controls">
                                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" required />
                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="control-group">
                            <label class="control-label">Venue</label>
                            <div class="controls">
                                <asp:TextBox ID="txtLocation" runat="server" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Date</label>
                            <div class="controls">
                                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" required />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Status</label>
                            <div class="controls">
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Speaker</label>
                            <div class="controls">
                                <asp:DropDownList ID="ddlSpeaker" runat="server" />
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="control-label"></div>
                            <div class="controls">
                                <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


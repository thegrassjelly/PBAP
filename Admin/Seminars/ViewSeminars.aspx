<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewSeminars.aspx.cs" Inherits="Admin_Seminars_ViewSeminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i> Seminars List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
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
                        <div class="col-lg-11">
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
                                    <th>Image</th>
                                    <th>Company</th>
                                    <th>Status</th>
                                    <th>Date Added</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>
    </form>
</asp:Content>


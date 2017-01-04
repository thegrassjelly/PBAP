<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewSeminars.aspx.cs" Inherits="Admin_Seminars_ViewSeminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <h1><i class="icon icon-list"></i>Seminars List</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
            <div class="span5">
                <div class="input-group">
                    <asp:DropDownList ID="ddlStatus" runat="server" class="form-control"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="span7">
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
                   
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-lg-12">
                        <div class="widget-box">
                            <div class="widget-title">
                                <span class="icon"><i class="icon-list"></i></span>
                                <h5>Seminar List</h5>
                            </div>
                            <div class="widget-content nopadding">
                                asd
                            </div>
                            <div class="form-actions">
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewSeminars.aspx.cs" Inherits="Admin_Seminars_ViewSeminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i> Seminars List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
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
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>#</th>
                                    <th>Code</th>
                                    <th>Title</th>
                                    <th>Competency</th>
                                    <th>Units</th>
                                    <th>Speaker</th>
                                    <th>Fee</th>
                                    <th>Date</th>
                                    <th>Location</th>
                                    <th>Status</th>
                                    <th>Date Added</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvSeminars" runat="server"
                                        OnPagePropertiesChanging="lvSeminars_PagePropertiesChanging"
                                        OnDataBound="lvSeminars_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("SeminarID") %></td>
                                                <td><%# Eval("SeminarCode") %></td>
                                                <td><%# Eval("SeminarTitle") %></td>
                                                <td><%# Eval("SeminarArea") %></td>
                                                <td><%# Eval("SeminarUnits") %></td>
                                                <td><%# Eval("Speaker") %></td>
                                                <td><%# Eval("SeminarFee", "{0: ₱ #,###.00}") %></td>
                                                <td>
                                                    <%# Eval("SeminarDate").ToString() == "1/1/1900 12:00:00 AM" ?
                                                        "TBA" : Eval("SeminarDate") %> 
                                                </td>
                                                <td><%# Eval("SeminarLocation") %></td>
                                                <td>
                                                    <span class="label label-success"><%# Eval("SeminarStatus") %></span>
                                                </td>
                                                <td><%# Eval("DateAdded", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td><%# Eval("DateModified", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateSeminars.aspx?ID=<%# Eval("SeminarID") %>'>
                                                        <asp:Label runat="server" ToolTip="Show Info"><i class="fa fa-edit"></i></asp:Label></a>
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
                                        <asp:DataPager id="dpSeminars" runat="server" pageSize="10" PagedControlID="lvSeminars">
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
    </form>
</asp:Content>


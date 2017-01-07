<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="ViewSpeakers.aspx.cs" Inherits="Admin_Speakers_ViewSpeakers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<i class="fa fa-edit"></i> Update Speaker Information
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
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
                                    <th>Title</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Contact No.</th>
                                    <th>Email Address</th>
                                    <th>Status</th>
                                    <th>Date Added</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvSpeakers" runat="server"
                                        OnPagePropertiesChanging="lvSpeakers_PagePropertiesChanging"
                                        OnDataBound="lvSpeakers_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("SeminarSpeakerID") %></td>
                                                <td><%# Eval("SeminarSpeakerTitle") %></td>
                                                <td><%# Eval("SeminarSpeakerFN") %></td>
                                                <td><%# Eval("SeminarSpeakerLN") %></td>
                                                <td><%# Eval("SeminarSpeakerTel") %></td>
                                                <td><%# Eval("SeminarSpeakerEmail") %></td>
                                                <td><span class="label label-success"><%# Eval("SeminarSpeakerStatus") %></span</td>
                                                <td><%# Eval("DateAdded", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td><%# Eval("DateModified", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateSpeakers.aspx?ID=<%# Eval("SeminarSpeakerID") %>'>
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">
                                    <center>
                                        <asp:DataPager id="dpSpeakers" runat="server" pageSize="10" PagedControlID="lvSpeakers" QueryStringField="PageNumber">
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


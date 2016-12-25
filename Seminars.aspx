<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Seminars.aspx.cs" Inherits="Seminars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <h1>SEMINARS</h1>
    <style type="text/css">
        #spnSched {
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 2px;
        }
        .spnSchedSub {
            font-size: 20px;
            font-weight: 200;
            letter-spacing: 2px;
        }
        #lnkTopicDesc:hover {
            color: #337ab7;
            cursor: pointer; 
            cursor: hand;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-12">
                    <div class="col-lg-6">
                        <span id="spnSched">SCHEDULE FOR</span>
                        <span class="spnSchedSub">
                            <asp:Literal ID="ltMonth" runat="server" />
                        </span>
                        -
                        <span class="spnSchedSub">
                            <asp:Literal ID="ltMonth2" runat="server" />
                        </span>
                        </div>
                        <div class="col-lg-6">
                            <div class="pull-right">
                                <a href="#">My Account</a>
                            </div>
                        </div>
                </div>
                <div class="col-lg-12">
                    <hr />
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlTopic" class="form-control" runat="server" 
                            AutoPostback="true" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged" />
                    </div>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlSpeaker" class="form-control" runat="server" 
                            AutoPostback="true" OnSelectedIndexChanged="ddlSpeaker_SelectedIndexChanged" />
                    </div>
                    <div class="col-lg-2">
                        <asp:DropDownList ID="ddlDay" class="form-control" runat="server"
                            AutoPostback="true" OnSelectedIndexChanged="ddlDay_SelectedIndexChanged">
                            <asp:ListItem>All Days</asp:ListItem>
                            <asp:ListItem>Monday</asp:ListItem>
                            <asp:ListItem>Tuesday</asp:ListItem>
                            <asp:ListItem>Wednesday</asp:ListItem>
                            <asp:ListItem>Thursday</asp:ListItem>
                            <asp:ListItem>Friday</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-12">
                    <hr />
                    <div class="col-lg-8">
                        <center>
                            <asp:DataPager id="dpSeminars" runat="server" pageSize="10" PagedControlID="lvSeminars">
                                <Fields>
                                    <asp:NumericPagerField Buttontype="Button"
                                        NumericButtonCssClass="btn btn-primary"
                                        CurrentPageLabelCssClass="btn btn-primary"
                                        NextPreviousButtonCssClass ="btn btn-primary" />
                                </Fields>
                             </asp:DataPager>
                        </center>
                    </div>
                    <div class="col-lg-4">
                        <asp:TextBox ID="txtDate" class="form-control" TextMode="Date" runat="server"
                            AutoPostback="true" OnTextChanged="txtDate_TextChanged"/>
                    </div>
                </div>
                <div class="col-lg-12">
                    <br />
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>SCHEDULE</th>
                                <th>TOPIC TITLES</th>
                                <th>THEMATIC AREA</th>
                                <th>CREDIT UNITS</th>
                                <th>VENUE</th>
                                <th>SPEAKER</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:ListView ID="lvSeminars" runat="server" OnDataBound="lvSeminars_DataBound"
                                OnPagePropertiesChanging="lvSeminars_PagePropertiesChanging"
                                OnItemCommand="lvSeminars_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# DateTime.Parse(Eval("SeminarDate").ToString()).ToString("dddd - MMMM dd") %></td>
                                        <td>
                                            <asp:Button ID="btnModal" CommandName="topicDesc"
                                                class="btn btn-sm btn-primary" runat="server" Text='<%# Eval("SeminarTitle") %>' 
                                                OnSubmitBehavior="false"/>
                                            <asp:Literal ID="ltSeminarID" runat="server" Text='<%# Eval("SeminarID") %>' Visible="false" />
                                        </td>
                                        <td><%# Eval("SeminarArea") %></td>
                                        <td><%# Eval("SeminarUnits") %></td>
                                        <td><%# Eval("SeminarLocation") %></td>
                                        <td><%# Eval("Speaker") %></td>
                                        <td>
                                            <asp:Button ID="btnReserve" CommandName="reserveSeminar"
                                                class="btn btn-sm btn-success" runat="server" Text='Reserve Now'
                                                OnSubmitBehavior="false" />
                                            </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <tr>
                                        <td colspan="12">
                                            <h2 class="text-center">No Seminars found</h2>
                                        </td>
                                    </tr>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-12">
                    <hr />
                </div>

                <div id="topicDesc" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">
                                    <center><asp:Literal ID="ltModalTopic" runat="server" /></center>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <br />
                                <p><asp:Literal ID="ltModalDesc" runat="server" /></p>
                                <br />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="reserveSeminar" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">
                                    <center>SEMINAR RESERVATION</center>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <br />
                                <div class="col-lg-3"></div>
                                <div class="col-lg-6">
                                    <div class="mu-latest-course-single">
                                        <figure class="mu-latest-course-img">
                                            <a href="#">
                                                <img src="img/courses/1.jpg" alt="img"></a>
                                            <figcaption class="mu-latest-course-imgcaption">
                                                Drawing
                                                <span><i class="fa fa-clock-o"></i>90Days</span>
                                            </figcaption>
                                        </figure>
                                        <div class="mu-latest-course-single-content">
                                            <h4><a href="#">Lorem ipsum dolor sit amet.</a></h4>
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet quod nisi quisquam modi dolore, dicta obcaecati architecto quidem ullam quia.</p>
                                            <div class="mu-latest-course-single-contbottom">
                                                
                                                <span class="mu-course-price" href="#">₱ 1000.00</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3"></div>
                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>


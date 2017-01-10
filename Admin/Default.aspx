<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="row">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Timer ID="tmrDaily" runat="server" OnTick="tmrDaily_Tick" Interval="1000" />
                    <div id="pnlDaily" class="row" runat="server">
                        <div class="panel panel-midnightblue">
                            <div class="panel panel-heading">
                                <h4>Daily Stats</h4>
                            </div>
                            <div class="col-md-3 col-xs-12 col-sm-6">
                                <a class="info-tiles tiles-sky" href="../Admin/Reservations/ViewReservations.aspx">
                                    <div class="tiles-heading">Total Reservations</div>
                                    <div class="tiles-body-alt">
                                        <i class="fa fa-bar-chart-o"></i>
                                        <div class="text-center">
                                            <asp:Literal ID="ltDailyRCount" runat="server" />
                                        </div>
                                        <small>For today
                            <asp:Literal ID="ltToday" runat="server" />
                                        </small>
                                    </div>
                                    <div class="tiles-footer">go to reservations</div>
                                </a>
                            </div>
                            <div class="col-md-3 col-xs-12 col-sm-6">
                                <a class="info-tiles tiles-purple" href="../Admin/Reservations/ViewReservations.aspx">
                                    <div class="tiles-heading">Pending Reservations</div>
                                    <div class="tiles-body-alt">
                                        <i class="fa fa-check"></i>
                                        <div class="text-center">
                                            <asp:Literal ID="ltDailyPendingRCount" runat="server" />
                                        </div>
                                        <small>For today
                            <asp:Literal ID="ltToday2" runat="server" />
                                        </small>
                                    </div>
                                    <div class="tiles-footer">go to reservations</div>
                                </a>
                            </div>
                            <div class="col-md-3 col-xs-12 col-sm-6">
                                <a class="info-tiles tiles-brown" href="../Admin/Reservations/ViewReservations.aspx">
                                    <div class="tiles-heading">Total Unpaid Reservations</div>
                                    <div class="tiles-body-alt">
                                        <!--i class="fa fa-money"></i-->
                                        <div class="text-center">
                                            <span class="text-top"></span>
                                            <asp:Literal ID="ltDailyUnpaidRes" runat="server" />
                                        </div>
                                        <small>For today
                            <asp:Literal ID="ltToday3" runat="server" />
                                        </small>
                                    </div>
                                    <div class="tiles-footer">go to payments</div>
                                </a>
                            </div>
                            <div class="col-md-3 col-xs-12 col-sm-6">
                                <a class="info-tiles tiles-primary" href="../Admin/Users/ViewUsers.aspx">
                                    <div class="tiles-heading">New Members</div>
                                    <div class="tiles-body-alt">
                                        <i class="fa fa-group"></i>
                                        <div class="text-center">
                                            <asp:Literal ID="ltDailyUserCount" runat="server" />
                                        </div>
                                        <small>For today
                            <asp:Literal ID="ltToday4" runat="server" />
                                        </small>
                                    </div>
                                    <div class="tiles-footer">manage users</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                <asp:Timer ID="tmrTopReserved" runat="server" OnTick="tmrTopReserved_Tick" Interval="1000" />
                <div id="pnlTopSeminar" class="row" runat="server">
                <div class="panel panel-midnightblue">
                    <div class="panel panel-heading">
                        <h4>All Time Most Reserved Seminars</h4>
                    </div>
                    <asp:ListView ID="lvTopSales" runat="server">
                        <ItemTemplate>
                            <div class="col-md-3 col-xs-12 col-sm-6">
                                <a class="info-tiles tiles-toyo" href="">
                                    <div class="tiles-heading">
                                        <%# Eval("SeminarArea") %>
                                    </div>
                                    <div class="tiles-body-alt" style="height: 100px">
                                        <div class="text-center" style="font-weight: 400; font-size: 20px">
                                            <%# Eval("SeminarTitle") %>
                                        </div>
                                        <small>
                                            <br /><%# Eval("TotalCount") %> Reservation(s)
                                        </small>
                                    </div>
                                    <div class="tiles-footer"><%# Eval("SpeakerName") %></div>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div id="pnlMonthly" class="row" runat="server">
                <div class="panel panel-midnightblue">
                    <div class="panel panel-heading">
                        <h4>Monthly Stats</h4>
                    </div>
                    <div class="col-md-3 col-xs-12 col-sm-6">
                        <a class="info-tiles tiles-toyo" href="../Admin/Reservations/ViewReservations.aspx">
                            <div class="tiles-heading">Total Reservations</div>
                            <div class="tiles-body-alt">
                                <i class="fa fa-bar-chart-o"></i>
                                <div class="text-center">
                                    <asp:Literal ID="ltRCount" runat="server" />
                                </div>
                                <small>For the month of
                                    <asp:Literal ID="ltCurrentMonth" runat="server" /></small>
                            </div>
                            <div class="tiles-footer">go to reservations</div>
                        </a>
                    </div>
                    <div class="col-md-3 col-xs-12 col-sm-6">
                        <a class="info-tiles tiles-alizarin" href="../Admin/Reservations/ViewReservations.aspx">
                            <div class="tiles-heading">Pending Reservations</div>
                            <div class="tiles-body-alt">
                                <i class="fa fa-check"></i>
                                <div class="text-center">
                                    <asp:Literal ID="ltPendingRCount" runat="server" />
                                </div>
                                <small>For the month of
                                    <asp:Literal ID="ltCurrentMonth3" runat="server" /></small>
                            </div>
                            <div class="tiles-footer">go to reservations</div>
                        </a>
                    </div>
                    <div class="col-md-3 col-xs-12 col-sm-6">
                        <a class="info-tiles tiles-success" href="../Admin/Reservations/ViewReservations.aspx">
                            <div class="tiles-heading">Total Unpaid Reservations</div>
                            <div class="tiles-body-alt">
                                <!--i class="fa fa-money"></i-->
                                <div class="text-center">
                                    <span class="text-top"></span>
                                    <asp:Literal ID="ltUnpaidRes" runat="server" />
                                </div>
                                <small>For the month of
                                    <asp:Literal ID="ltCurrentMonth2" runat="server" /></small>
                            </div>
                            <div class="tiles-footer">go to payments</div>
                        </a>
                    </div>
                    <div class="col-md-3 col-xs-12 col-sm-6">
                        <a class="info-tiles tiles-orange" href="../Admin/Users/ViewUsers.aspx">
                            <div class="tiles-heading">New Members</div>
                            <div class="tiles-body-alt">
                                <i class="fa fa-group"></i>
                                <div class="text-center">
                                    <asp:Literal ID="ltUsers" runat="server" />
                                </div>
                                <small>For the month of
                            <asp:Literal ID="ltMonth4" runat="server" />
                                </small>
                            </div>
                            <div class="tiles-footer">manage users</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


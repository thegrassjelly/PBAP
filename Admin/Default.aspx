<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="row">
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-toyo" href="#">
                    <div class="tiles-heading">Total Reservations</div>
                    <div class="tiles-body-alt">
                        <!--i class="fa fa-bar-chart-o"></i-->
                        <div class="text-center">854</div>
                        <small>For the month of <asp:Literal ID="ltCurrentMonth" runat="server" /></small>
                    </div>
                    <div class="tiles-footer">go to reservations</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-alizarin" href="#">
                    <div class="tiles-heading">Pending Reservations</div>
                    <div class="tiles-body-alt">
                        <i class="fa fa-check"></i>
                        <div class="text-center">57</div>
                        <small>For the month of <asp:Literal ID="ltCurrentMonth3" runat="server" /></small>
                    </div>
                    <div class="tiles-footer">go to reservations</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-success" href="#">
                    <div class="tiles-heading">Total Unpaid Reservations</div>
                    <div class="tiles-body-alt">
                        <!--i class="fa fa-money"></i-->
                        <div class="text-center"><span class="text-top">₱</span>1252</div>
                        <small>For the month of <asp:Literal ID="ltCurrentMonth2" runat="server" /></small>
                    </div>
                    <div class="tiles-footer">go to payments</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-orange" href="#">
                    <div class="tiles-heading">New Members</div>
                    <div class="tiles-body-alt">
                        <i class="fa fa-group"></i>
                        <div class="text-center">109</div>
                        <small>For the month of
                            <asp:Literal ID="ltMonth4" runat="server" />
                        </small>
                    </div>
                    <div class="tiles-footer">manage users</div>
                </a>
            </div>
        </div>
    </form>
</asp:Content>


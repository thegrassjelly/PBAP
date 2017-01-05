<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="row">
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-toyo" href="#">
                    <div class="tiles-heading">Profit</div>
                    <div class="tiles-body-alt">
                        <!--i class="fa fa-bar-chart-o"></i-->
                        <div class="text-center"><span class="text-top">$</span>854</div>
                        <small>+8.7% from last period</small>
                    </div>
                    <div class="tiles-footer">more info</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-success" href="#">
                    <div class="tiles-heading">Revenue</div>
                    <div class="tiles-body-alt">
                        <!--i class="fa fa-money"></i-->
                        <div class="text-center"><span class="text-top">$</span>22.7<span class="text-smallcaps">k</span></div>
                        <small>-13.5% from last week</small>
                    </div>
                    <div class="tiles-footer">go to accounts</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-orange" href="#">
                    <div class="tiles-heading">Members</div>
                    <div class="tiles-body-alt">
                        <i class="fa fa-group"></i>
                        <div class="text-center">109</div>
                        <small>new users registered</small>
                    </div>
                    <div class="tiles-footer">manage members</div>
                </a>
            </div>
            <div class="col-md-3 col-xs-12 col-sm-6">
                <a class="info-tiles tiles-alizarin" href="#">
                    <div class="tiles-heading">Orders</div>
                    <div class="tiles-body-alt">
                        <i class="fa fa-shopping-cart"></i>
                        <div class="text-center">57</div>
                        <small>new orders received</small>
                    </div>
                    <div class="tiles-footer">manage orders</div>
                </a>
            </div>
        </div>
    </form>
</asp:Content>


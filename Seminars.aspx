<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Seminars.aspx.cs" Inherits="Seminars" %>

<%@ Register Assembly="BotDetect" Namespace="BotDetect.Web.UI" TagPrefix="BotDetect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <h1>SEMINARS</h1>
    <style type="text/css">
        .spnSched {
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 2px;
        }

        .spnSchedAccount {
            font-size: 15px;
            font-weight: 600;
            letter-spacing: 2px;
        }

        .spnSchedAccountSub {
            font-size: 15px;
            font-weight: 200;
            letter-spacing: 2px;
        }

        #spnRsvpHeader {
            font-size: 20px;
            font-weight: 400;
        }

        .spnRsvpHeader {
            font-size: 20px;
            font-weight: 400;
        }

        .spanRsvpWeight {
            font-weight: 600;
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

        code,
        kbd,
        pre,
        .img-rounded,
        .img-thumbnail,
        .img-circle,
        .form-control,
        .btn,
        .btn-link,
        .dropdown-menu,
        .input-group-addon,
        .input-group-btn,
        .nav-tabs a,
        .nav-pills a,
        .navbar,
        .navbar-toggle,
        .icon-bar,
        .breadcrumb,
        .pagination,
        .pager *,
        .label,
        .badge,
        .jumbotron,
        .thumbnail,
        .alert,
        .progress,
        .panel,
        .well,
        .modal-content,
        .tooltip-inner,
        .popover,
        .popover-title,
        .carousel-indicators li {
            border-radius: 0 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="container">
        <form class="form-horizontal" novalidate runat="server">
            <asp:ScriptManager runat="server" EnablePartialRendering="true" />
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-lg-12">
                        <div class="col-lg-6">
                            <span class="spnSched">SCHEDULE FOR</span>
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
                                <div id="pnlUser" class="spnSchedAccount" runat="server">
                                    HELLO!
                                <span class="spnSchedAccountSub">
                                    <asp:Literal ID="ltUserName" runat="server" /></span> |
                                <asp:LinkButton ID="lnkProfile" runat="server" OnClick="lnkProfile_Click">ACCOUNT</asp:LinkButton>
                                    |
                                <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click">LOGOUT</asp:LinkButton>
                                </div>
                                <div id="pnlGuest" class="spnSchedAccount" runat="server">
                                    <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click">LOGIN</asp:LinkButton>
                                    |
                                    <asp:LinkButton ID="lnkRegister" runat="server" OnClick="lnkRegister_Click">REGISTER</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <hr />
                        <div class="col-lg-5">
                            <asp:DropDownList ID="ddlTopic" class="form-control" runat="server"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlTopic_SelectedIndexChanged" />
                        </div>
                        <div class="col-lg-5">
                            <asp:DropDownList ID="ddlSpeaker" class="form-control" runat="server"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlSpeaker_SelectedIndexChanged" />
                        </div>
                        <div class="col-lg-2">
                            <asp:DropDownList ID="ddlDay" class="form-control" runat="server"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlDay_SelectedIndexChanged">
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
                                AutoPostBack="true" OnTextChanged="txtDate_TextChanged" />
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
                                                    OnSubmitBehavior="false" />
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
                                    <p>
                                        <asp:Literal ID="ltModalDesc" runat="server" />
                                    </p>
                                    <br />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div id="reserveSeminar" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg">
                    <asp:UpdateProgress ID="updateProgress" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                                <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="~/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">
                                        <center>SEMINAR RESERVATION</center>
                                    </h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="panel panel-default">
                                                <br />
                                                    <center>
                                                        <span id="spnRsvpHeader">
                                                            <asp:Literal ID="ltRsvpHeader" runat="server" />
                                                        </span>
                                                    </center>
                                                <hr />
                                                <div class="panel-body">
                                                    <span class="spanRsvpWeight">Date 
                                                    </span>
                                                    <asp:Literal ID="ltRsvpDate" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Thematic Area 
                                                    </span>
                                                    <asp:Literal ID="ltRsvpArea" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Units
                                                    </span>
                                                    <asp:Literal ID="ltRsvpUnits" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Speaker
                                                    </span>
                                                    <asp:Literal ID="ltRsvpSpeaker" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Venue
                                                    </span>
                                                    <asp:Literal ID="ltRsvpVenue" runat="server" />
                                                </div> 
                                                <hr />
                                            </div>
                                        </div>
                                        <div id="pnlAccount" class="col-lg-8" runat="server">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="col-lg-6">
                                                        <center><h4>Login</h4>
                                                        <span style="font-size: small;">Existing Users</span></center>
                                                        <hr />
                                                        <div id="loginerror" runat="server" class="alert alert-danger" visible="false">
                                                            Wrong Email/Password entered.
                                                        </div>
                                                        <div id="servererror2" runat="server" class="alert alert-warning" visible="false">
                                                            Server error. Please call us for reservation.
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtEmail" runat="server" class="form-control"
                                                                    Placeholder="Email Address" TextMode="Email" />
                                                                <asp:RegularExpressionValidator ID="emlVld" runat="server"
                                                                    ForeColor="red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtEmail"
                                                                    ErrorMessage="Please enter valid e-mail address"
                                                                    ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$" />

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtPassword" runat="server" class="form-control"
                                                                    Placeholder="Password" TextMode="Password" />
                                                            </div>
                                                        </div>
                                                        <hr />
                                                        <center>
                                                        <a style="font-size: small;" href="#">Forgot Password?</a><br /><br />
                                                        <asp:Button id="btnLogin" class="btn btn-primary"
                                                            Text="Login" OnClick="btnLogin_Click" runat="server" />
                                                    </center>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <center><h4>Create New Account</h4>
                                                        <span style="font-size: small;">New Users</span></center>
                                                        <hr />
                                                        <div id="emailerror" runat="server" class="alert alert-danger" visible="false">
                                                            Email address already exist.
                                                        </div>
                                                        <div id="servererror" runat="server" class="alert alert-warning" visible="false">
                                                            Server error. Please call us for reservation.
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtFN" runat="server" class="form-control"
                                                                    Placeholder="First Name" />
                                                                <asp:RegularExpressionValidator ID="nmVld" runat="server"
                                                                    ForeColor="red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtFN"
                                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                    Text="Enter a valid name" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtMN" runat="server" class="form-control"
                                                                    Placeholder="Middle Name" />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                                    ForeColor="red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtMN"
                                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                    Text="Enter a valid name" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtLN" runat="server" class="form-control"
                                                                    Placeholder="Last Name" />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                                    ForeColor="red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtLN"
                                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                    Text="Enter a valid name" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtBday" runat="server" class="form-control"
                                                                    TextMode="Date" title="Date of Birth" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtMobile" runat="server" class="form-control"
                                                                    Placeholder="Mobile Number" TextMode="Number" Max="11" />
                                                                <asp:RegularExpressionValidator ID="MblVld" runat="server"
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtMobile"
                                                                    ValidationExpression="^[0-9]{11}$"
                                                                    ErrorMessage="Enter a valid Mobile Number (11 digits)" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtAddress" runat="server" class="form-control"
                                                                    Placeholder="Address" TextMode="MultiLine"
                                                                    Style="max-width: 100%;" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtCompany" runat="server" class="form-control"
                                                                    Placeholder="Company" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtPosition" runat="server" class="form-control"
                                                                    Placeholder="Position" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtEmailReg" runat="server" class="form-control"
                                                                    Placeholder="Email Address" TextMode="Email"
                                                                    title="Enter a valid & working email address for confirmation." />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                                                    ForeColor="red"
                                                                    Display="Dynamic"
                                                                    ControlToValidate="txtEmailReg"
                                                                    ErrorMessage="Please enter valid e-mail address"
                                                                    ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtPasswordReg" runat="server" class="form-control"
                                                                    Placeholder="Password" TextMode="Password" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <asp:TextBox ID="txtPasswordReg2" runat="server" class="form-control"
                                                                    Placeholder="Repeat Password" TextMode="Password" />
                                                                <asp:CompareValidator ID="cmprPwd" runat="server"
                                                                    Display="Dynamic"
                                                                    ForeColor="Red"
                                                                    ControlToCompare="txtPasswordReg"
                                                                    ControlToValidate="txtPasswordReg2"
                                                                    ErrorMessage="Passwords do not match" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <BotDetect:WebFormsCaptcha ID="regCaptcha"
                                                                    ImageSize="220, 50" runat="server" />
                                                                <br />
                                                                <div id="captchaerror" runat="server" class="alert alert-danger" visible="false">
                                                                    Wrong captcha code, try again.
                                                                </div>
                                                                <asp:TextBox ID="txtCaptcha" class="form-control" runat="server"
                                                                    Placeholder="Enter code above" />
                                                            </div>
                                                        </div>
                                                        <hr />
                                                        <center>
                                                        <asp:Button id="btnRegister" class="btn btn-primary"
                                                            Text="Register" runat="server" OnClick="btnRegister_Click" />
                                                    </center>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="pnlReserve" class="col-lg-8" runat="server">
                                            <div class="panel panel-default">
                                                <div class="panel-body">

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div id="loginModal" class="modal fade" role="dialog">
                <div class="modal-dialog modal-sm">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">
                                        <center>LOGIN</center>
                                    </h4>
                                </div>
                                <div class="modal-body">
                                    <div id="loginerror2" runat="server" class="alert alert-danger" visible="false">
                                        Wrong Email/Password entered.
                                    </div>
                                    <div id="servererror3" runat="server" class="alert alert-warning" visible="false">
                                        Server error. Please call us for reservation.
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <asp:TextBox ID="txtModalEmail" runat="server" class="form-control"
                                                Placeholder="Email Address" TextMode="Email" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                                ForeColor="red"
                                                Display="Dynamic"
                                                ControlToValidate="txtModalEmail"
                                                ErrorMessage="Please enter valid e-mail address"
                                                ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$" />

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <asp:TextBox ID="txtModalPassword" runat="server" class="form-control"
                                                Placeholder="Password" TextMode="Password" />
                                        </div>
                                    </div>
                                    <hr />
                                    <center>
                                        <a style="font-size: small;" href="#">Forgot Password?</a><br /><br />
                                        <asp:Button id="btnModalLogin" class="btn btn-primary"
                                        Text="Login" OnClick="btnModalLogin_Click" runat="server" />
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div id="registerModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">
                                        <center>REGISTER</center>
                                    </h4>
                                </div>
                                <div class="modal-body">
                                    <div id="emailerror2" runat="server" class="alert alert-danger" visible="false">
                                        Email address already exist.
                                    </div>
                                    <div id="servererror4" runat="server" class="alert alert-warning" visible="false">
                                        Server error. Please call us for reservation.
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalFN" runat="server" class="form-control"
                                                    Placeholder="First Name" required />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                                                    ForeColor="red"
                                                    Display="Dynamic"
                                                    ControlToValidate="txtModalFN"
                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                    Text="Enter a valid name" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalMN" runat="server" class="form-control"
                                                    Placeholder="Middle Name" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server"
                                                    ForeColor="red"
                                                    Display="Dynamic"
                                                    ControlToValidate="txtModalMN"
                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                    Text="Enter a valid name" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalLN" runat="server" class="form-control"
                                                    Placeholder="Last Name" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server"
                                                    ForeColor="red"
                                                    Display="Dynamic"
                                                    ControlToValidate="txtModalLN"
                                                    ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                    Text="Enter a valid name" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalBday" runat="server" class="form-control"
                                                    TextMode="Date" title="Date of Birth" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalMobile" runat="server" class="form-control"
                                                    Placeholder="Mobile Number" TextMode="Number" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server"
                                                    ForeColor="Red"
                                                    Display="Dynamic"
                                                    ControlToValidate="txtModalMobile"
                                                    ValidationExpression="^[0-9]{11}$"
                                                    ErrorMessage="Enter a valid Mobile Number (11 digits)" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalAddr" runat="server" class="form-control"
                                                    Placeholder="Address" TextMode="MultiLine"
                                                    Style="max-width: 100%;" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalComp" runat="server" class="form-control"
                                                    Placeholder="Company" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalPos" runat="server" class="form-control"
                                                    Placeholder="Position" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalEmailReg" runat="server" class="form-control"
                                                    Placeholder="Email Address" TextMode="Email"
                                                    title="Enter a valid & working email address for confirmation." />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server"
                                                    ForeColor="red"
                                                    Display="Dynamic"
                                                    ControlToValidate="txtModalEmailReg"
                                                    ErrorMessage="Please enter valid e-mail address"
                                                    ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalPass" runat="server" class="form-control"
                                                    Placeholder="Password" TextMode="Password" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtModalPass2" runat="server" class="form-control"
                                                    Placeholder="Repeat Password" TextMode="Password" />
                                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                                    Display="Dynamic"
                                                    ForeColor="Red"
                                                    ControlToCompare="txtModalPass"
                                                    ControlToValidate="txtModalPass2"
                                                    ErrorMessage="Passwords do not match" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <BotDetect:WebFormsCaptcha ID="modalRegCaptcha"
                                                    ImageSize="220, 50" runat="server" />
                                                <br />
                                                <div id="captchaerror2" runat="server" class="alert alert-danger" visible="false">
                                                    Wrong captcha code, try again.
                                                </div>
                                                <asp:TextBox ID="txtModalCaptcha" class="form-control" runat="server"
                                                    Placeholder="Enter code above" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <hr />
                                    </div>
                                    <center>
                                        <asp:Button ID="btModalRegister" class="btn btn-primary"
                                        Text="Register" runat="server" OnClick="btModalRegister_Click" />
                                    </center>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div id="profileModal" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="row">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">
                                            <center>MY PROFILE</center>
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6">
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <center>
                                                        <h4>Personal Information</h4>
                                                    </center>
                                                        <hr />
                                                        <div id="uperror" runat="server" class="alert alert-danger" visible="false">
                                                            Email address already exist.
                                                        </div>
                                                        <div id="upserverror" runat="server" class="alert alert-warning" visible="false">
                                                            Server error. Try again later.
                                                        </div>
                                                        <div id="upsuccess" runat="server" class="alert alert-success" visible="false">
                                                            Personal Information Updated.
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpFN" runat="server" class="form-control"
                                                                        Placeholder="First Name" required />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                                                                        ForeColor="red"
                                                                        Display="Dynamic"
                                                                        ControlToValidate="txtUpFN"
                                                                        ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                        Text="Enter a valid name" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpMN" runat="server" class="form-control"
                                                                        Placeholder="Middle Name" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server"
                                                                        ForeColor="red"
                                                                        Display="Dynamic"
                                                                        ControlToValidate="txtUpMN"
                                                                        ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                        Text="Enter a valid name" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpLN" runat="server" class="form-control"
                                                                        Placeholder="Last Name" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                                                                        ForeColor="red"
                                                                        Display="Dynamic"
                                                                        ControlToValidate="txtUpLN"
                                                                        ValidationExpression="^[a-zA-Z'.\s]{1,50}"
                                                                        Text="Enter a valid name" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUPDb" runat="server" class="form-control"
                                                                        TextMode="Date" title="Date of Birth" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpMNo" runat="server" class="form-control"
                                                                        Placeholder="Mobile Number" TextMode="Number" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                                                                        ForeColor="Red"
                                                                        Display="Dynamic"
                                                                        ControlToValidate="txtUpMNo"
                                                                        ValidationExpression="^[0-9]{11}$"
                                                                        ErrorMessage="Enter a valid Mobile Number (11 digits)" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpAddr" runat="server" class="form-control"
                                                                        Placeholder="Address" TextMode="MultiLine"
                                                                        Style="max-width: 100%;" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpComp" runat="server" class="form-control"
                                                                        Placeholder="Company" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpPos" runat="server" class="form-control"
                                                                        Placeholder="Position" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpEAdd" runat="server" class="form-control"
                                                                        Placeholder="Email Address" TextMode="Email"
                                                                        title="Enter a valid & working email address for confirmation." />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server"
                                                                        ForeColor="red"
                                                                        Display="Dynamic"
                                                                        ControlToValidate="txtUpEAdd"
                                                                        ErrorMessage="Please enter valid e-mail address"
                                                                        ValidationExpression="^[\w\.\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]{1,})*(\.[a-zA-Z]{2,3}){1,2}$" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpPass" runat="server" class="form-control"
                                                                        Placeholder="Password" TextMode="Password" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-lg-12">
                                                                    <asp:TextBox ID="txtUpPass2" runat="server" class="form-control"
                                                                        Placeholder="Repeat Password" TextMode="Password" />
                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server"
                                                                        Display="Dynamic"
                                                                        ForeColor="Red"
                                                                        ControlToCompare="txtUpPass"
                                                                        ControlToValidate="txtUpPass2"
                                                                        ErrorMessage="Passwords do not match" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <hr />
                                                            <center>
                                                            <asp:Button id="btnUpdateInfo" class="btn btn-primary"
                                                                runat="server" Text="Update" OnClick="btnUpdateInfo_Click" />
                                                        </center>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </form>
    </div>
</asp:Content>


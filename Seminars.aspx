<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Seminars.aspx.cs" Inherits="Seminars" %>

<%@ Register Assembly="BotDetect" Namespace="BotDetect.Web.UI" TagPrefix="BotDetect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <h1>SEMINARS</h1>

    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

    <script type="text/javascript">
        $(document).ready(function () {
            SearchTopic();
            SearchSpeaker();
        });

        // if you use jQuery, you can load them when dom is read.
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_initializeRequest(InitializeRequest);
            prm.add_endRequest(EndRequest);

        });

        function InitializeRequest(sender, args) {
        }

        function EndRequest(sender, args) {
            // after update occur on UpdatePanel re-init the Autocomplete
            SearchTopic();
            SearchSpeaker();
        }

        function SearchTopic() {
            $(".autosuggest").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Seminars.aspx/GetTopics",
                        data: JSON.stringify({
                            prefixText: document.getElementById('<%=txtTopic.ClientID%>').value
                        }),
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            //alert("Error");
                        }
                    });
                }
            });
        }

        function SearchSpeaker() {
            $("#<%=txtSpeaker.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Seminars.aspx/GetSpeakers",
                        data: "{'prefixText':'" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('/vn/')[0],
                                    val: item.split('/vn/')[1]
                                }
                            }))
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hfSpeaker.ClientID %>").val(i.item.val);
                },
                minLength: 1
            });
            };
    </script>
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
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtTopic" class="form-control autosuggest" runat="server"
                                AutoPostBack="true" OnTextChanged="txtTopic_TextChanged" Placeholder="Filter Thematic Area" />
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtSpeaker" class="form-control" runat="server"
                                AutoPostBack="true" OnTextChanged="txtSpeaker_TextChanged" Placeholder="Filter Seminar Speaker" />
                            <asp:HiddenField ID="hfSpeaker" Value="0" runat="server" />
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
                                    <th>SEMINAR CODE</th>
                                    <th>TOPIC TITLES</th>
                                    <th>COMPETENCY</th>
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
                                            <td>
                                                <%# Eval("SeminarDate").ToString() == "1/1/1900 12:00:00 AM" ?
                                                        "TBA" : DateTime.Parse(Eval("SeminarDate").ToString()).ToString("dddd - MMMM dd") %> 
                                            </td>
                                            <td><%# Eval("SeminarCode") %></td>
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
                                                    <span class="spanRsvpWeight">Seminar Code 
                                                    </span>
                                                    <asp:Literal ID="ltCode" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Date 
                                                    </span>
                                                    <asp:Literal ID="ltRsvpDate" runat="server" />
                                                    <br />
                                                    <span class="spanRsvpWeight">Competency
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
                                                    <br />
                                                    <span class="spanRsvpWeight">Price
                                                    </span>
                                                    ₱ <asp:Literal ID="ltPrice" runat="server" />
                                                </div>
                                                <hr />
                                            </div>
                                        </div>
                                        <div id="pnlAccount" class="col-lg-8" runat="server">
                                            <div class="col-lg-6">
                                                <div class="panel panel-default">
                                                    <div class="panel-body">

                                                        <center><h4>Login</h4>
                                                        <span style="font-size: small;">Existing Users</span></center>
                                                        <hr />
                                                        <div id="loginerror" runat="server" class="alert alert-danger" visible="false">
                                                            Wrong Email/Password entered.
                                                        </div>
                                                        <div id="servererror" runat="server" class="alert alert-warning" visible="false">
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
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        <center><h4>Create New Account</h4>
                                                        <span style="font-size: small;">New Users</span></center>
                                                        <hr />
                                                        <div id="emailerror" runat="server" class="alert alert-danger" visible="false">
                                                            Email address already exist.
                                                        </div>
                                                        <div id="servererror2" runat="server" class="alert alert-warning" visible="false">
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
                                                    <div id="reservationsuccess" runat="server" class="alert alert-success" visible="false">
                                                        Reservation Successful. Please check your email for further anouncements and possible changes.
                                                    </div>
                                                    <ul class="nav nav-tabs">
                                                        <li class="active"><a href="#tab_a" data-toggle="tab"><b>Step 1 - Verify Information</b></a></li>
                                                        <li><a href="#tab_b" data-toggle="tab"><b>Step 2 - Confirm Reservation</b></a></li>
                                                    </ul>
                                                    <div class="tab-content">
                                                        <div class="tab-pane active" id="tab_a">
                                                            <br />
                                                            <center><p>
                                                            <u><asp:LinkButton ID="lnkUpdate2" runat="server" OnClick="lnkUpdate2_Click">Update Account Information</asp:LinkButton></u>
                                                            </p></center>
                                                            <hr />
                                                            <div class="col-lg-6">
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtFN2" runat="server" class="form-control"
                                                                            Placeholder="First Name" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtMN2" runat="server" class="form-control"
                                                                            Placeholder="Middle Name" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtLN2" runat="server" class="form-control"
                                                                            Placeholder="Last Name" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtBday2" runat="server" class="form-control"
                                                                            TextMode="Date" title="Date of Birth" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtMNo2" runat="server" class="form-control"
                                                                            Placeholder="Mobile Number" TextMode="Number" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtAddr2" runat="server" class="form-control"
                                                                            Placeholder="Address" TextMode="MultiLine"
                                                                            Style="max-width: 100%;" disabled />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtComp2" runat="server" class="form-control"
                                                                            Placeholder="Company" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtPos2" runat="server" class="form-control"
                                                                            Placeholder="Position" disabled />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-12">
                                                                        <asp:TextBox ID="txtEadd2" runat="server" class="form-control"
                                                                            Placeholder="Email Address" TextMode="Email"
                                                                            disabled />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <br />
                                                        </div>
                                                        <div class="tab-pane" id="tab_b">
                                                            <br />
                                                            <asp:HiddenField id="hfSeminarID" runat="server" Value="0" />
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Seminar Code</label>
                                                                <div class="col-lg-3">
                                                                    <asp:TextBox ID="txtConfirmCode" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Dates</label>
                                                                <div class="col-lg-4">
                                                                    <asp:TextBox ID="txtConfirmDate" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Title</label>
                                                                <div class="col-lg-5">
                                                                    <asp:TextBox ID="txtConfirmTitle" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Competency</label>
                                                                <div class="col-lg-5">
                                                                    <asp:TextBox ID="txtConfirmCompt" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Units</label>
                                                                <div class="col-lg-2">
                                                                    <asp:TextBox ID="txtConfirmUnit" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Speaker</label>
                                                                <div class="col-lg-5">
                                                                    <asp:TextBox ID="txtConfirmSpeaker" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Venue</label>
                                                                <div class="col-lg-5">
                                                                    <asp:TextBox ID="txtConfirmVenue" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Fee</label>
                                                                <div class="col-lg-3">
                                                                    <asp:TextBox ID="txtConfirmFee" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                             <div class="form-group">
                                                                <label class="control-label col-lg-3">Payment Method</label>
                                                                <div class="col-lg-4">
                                                                    <asp:DropDownList ID="ddlPaymentMethod" class="form-control" runat="server">
                                                                        <asp:ListItem>Cash</asp:ListItem>
                                                                        <asp:ListItem>Bank Deposit</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-lg-3">Promo Code</label>
                                                                <div class="col-lg-3">
                                                                    <asp:TextBox ID="txtVoucher" class="form-control" runat="server" disabled />
                                                                </div>
                                                            </div>
                                                            <hr />
                                                            <div class="form-group">
                                                                <label class="col-xs-3 control-label">Terms of use</label>
                                                                <div class="col-xs-9">
                                                                    <div style="border: 1px solid #e5e5e5; height: 200px; overflow: auto; padding: 10px;">
                                                                        <p>1. Introduction</p>
                                                                        <p>These Website Standard Terms and Conditions written on this webpage shall manage your use of this website. 
                                                                            These Terms will be applied fully and affect to your use of this Website. 
                                                                            By using this Website, you agreed to accept all terms and conditions written in here. 
                                                                            You must not use this Website if you disagree with any of these Website Standard Terms and Conditions.</p><br />
                                                                        <p>2. Intellectual Property Rights</p>
                                                                        <p>Other than the content you own, under these Terms, Professional Bookeepers of the Philippines and/or its licensors 
                                                                            own all the intellectual property rights and materials contained in this Website.</p><br />
                                                                        <p>You are granted limited license only for purposes of viewing the material contained on this Website.</p>
                                                                        <br />
                                                                        <p>3. Restrictions</p>
                                                                        <p>You are specifically restricted from all of the following</p>
                                                                        <p>publishing any Website material in any other media;</p>
                                                                        <p>selling, sublicensing and/or otherwise commercializing any Website material;</p>
                                                                        <p>publicly performing and/or showing any Website material;</p>
                                                                        <p>using this Website in any way that is or may be damaging to this Website;</p>
                                                                        <p>using this Website in any way that impacts user access to this Website;</p>
                                                                        <p>using this Website contrary to applicable laws and regulations, or in any way may cause 
                                                                            harm to the Website, or to any person or business entity;</p>
                                                                        <p>engaging in any data mining, data harvesting, data extracting or any other similar activity in relation to this Website;</p>
                                                                        <p>using this Website to engage in any advertising or marketing.</p>
                                                                        <p>Certain areas of this Website are restricted from being access by you and Professional Bookeepers of the Philippines may further restrict access by you to any areas of this Website, at any time, in absolute discretion. Any user ID and password you may have for this Website are confidential and you must maintain confidentiality as well.</p>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-xs-9 col-xs-offset-3">
                                                                                                                           
                                                            <asp:LinkButton ID="lnkConfirmReservation" runat="server"
                                                                OnClick="lnkConfirmReservation_Click"
                                                                OnClientClick='return confirm("By confirming, you accept the terms and agreements stated above. Continue?");' 
                                                                ToolTip="Refresh Item">
                                                                <i class="fa fa-check"></i> Confirm Reservation</asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
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
                    <div class="modal-content">
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
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
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
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnUpdateInfo" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#tab_rh" data-toggle="tab"><b>Reservation History</b></a></li>
                                                <li><a href="#tab_ph" data-toggle="tab"><b>Payment History</b></a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="tab_rh">
                                                    <hr />
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:ListView ID="lvReservations" runat="server"
                                                                OnPagePropertiesChanging="lvReservations_PagePropertiesChanging"
                                                                OnDataBound="lvReservations_DataBound">
                                                                <ItemTemplate>
                                                                    <p><b>Seminar Code</b> <%# Eval("SeminarCode") %></p>
                                                                    <p><b>Title</b> <%# Eval("SeminarTitle") %></p>
                                                                    <p>
                                                                        <b>Date</b> <%# Eval("SeminarDate").ToString() == "1/1/1900 12:00:00 AM" ?
                                                                                    "TBA" : Eval("SeminarDate") %>
                                                                    </p>
                                                                    <p><b>Competence</b> <%# Eval("SeminarArea") %></p>
                                                                    <p><b>Units</b> <%# Eval("SeminarUnits") %></p>
                                                                    <p><b>Fee</b> <%# Eval("SeminarFee", "{0:₱ #,###.00}") %></p>
                                                                    <p><b>Location</b> <%# Eval("SeminarLocation") %></p>
                                                                    <p><b>Speaker</b> <%# Eval("Speaker") %></p>
                                                                    <hr />
                                                                    <p><b>Date Reserved</b> <%# Eval("RDate") %></p>
                                                                    <p>
                                                                        <b>Reservation Status</b>
                                                                        <span class='<%# Eval("ReservationStatus").ToString() == "Pending" ? "label label-danger" : "label label-success"%>'>
                                                                            <%# Eval("ReservationStatus") %>
                                                                        </span>
                                                                    </p>
                                                                    <hr />
                                                                </ItemTemplate>
                                                                <EmptyDataTemplate>
                                                                    <h2 class="text-center">No records found.</h2>
                                                                </EmptyDataTemplate>
                                                            </asp:ListView>
                                                            <center>
                                                                        <asp:DataPager id="dpReservations" runat="server" pageSize="1" PagedControlID="lvReservations">
                                                                            <Fields>
                                                                                <asp:NumericPagerField Buttontype="Button"
                                                                                    NumericButtonCssClass="btn btn-default"
                                                                                    CurrentPageLabelCssClass="btn btn-success"
                                                                                    NextPreviousButtonCssClass ="btn btn-default" 
                                                                                    ButtonCount="5" />
                                                                            </Fields>
                                                                        </asp:DataPager>
                                                                    </center>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="lvReservations" EventName="PagePropertiesChanging" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div class="tab-pane" id="tab_ph">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:ListView ID="lvPayments" runat="server"
                                                                OnPagePropertiesChanging="lvPayments_PagePropertiesChanging"
                                                                OnDataBound="lvPayments_DataBound">
                                                                <ItemTemplate>
                                                                    <hr />
                                                                    <p><b>Fee</b> <%# Eval("PaymentAmount", "{0:₱ #,###.00}") %></p>
                                                                    <p><b>Payment Type</b> <%# Eval("PaymentType") %></p>
                                                                    <p><b>Payment Date</b> <%# Eval("PaymentDate") %></p>
                                                                    <p><b>Voucher Code</b> <%# Eval("VoucherCode") %></p>
                                                                    <p><b>Date Reserved</b> <%# Eval("RDate") %></p>
                                                                    <p>
                                                                        <b>Payment Status</b>
                                                                        <span class='<%# Eval("PaymentStatus").ToString() == "Unpaid" ? "label label-danger" : "label label-success"%>'>
                                                                            <%# Eval("PaymentStatus") %>
                                                                                    </span>
                                                                    </p>
                                                                    <hr />
                                                                    <p><b>Seminar Code</b> <%# Eval("SeminarCode") %></p>
                                                                    <p><b>Title</b> <%# Eval("SeminarTitle") %></p>
                                                                    <p>
                                                                        <b>Date</b> <%# Eval("SeminarDate").ToString() == "1/1/1900 12:00:00 AM" ?
                                                                                    "TBA" : Eval("SeminarDate") %>
                                                                    </p>
                                                                    <hr />
                                                                </ItemTemplate>
                                                                <EmptyDataTemplate>
                                                                    <h2 class="text-center">No records found.</h2>
                                                                </EmptyDataTemplate>
                                                            </asp:ListView>
                                                            <center>
                                                                        <asp:DataPager id="dpPayments" runat="server" pageSize="1" PagedControlID="lvPayments">
                                                                            <Fields>
                                                                                <asp:NumericPagerField Buttontype="Button"
                                                                                    NumericButtonCssClass="btn btn-default"
                                                                                    CurrentPageLabelCssClass="btn btn-success"
                                                                                    NextPreviousButtonCssClass ="btn btn-default" 
                                                                                    ButtonCount="5" />
                                                                            </Fields>
                                                                        </asp:DataPager>
                                                                    </center>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="lvPayments" EventName="PagePropertiesChanging" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</asp:Content>


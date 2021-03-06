﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seminars : System.Web.UI.Page
{
    private string _Topic;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetSeminars();
            GetCurrentMonth();
            GetAccountInfo();
        }
    }

    #region Method
    [WebMethod]
    public static List<string> GetTopics(string prefixText)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarArea FROM Seminars WHERE SeminarArea LIKE
                @keyword ORDER BY SeminarArea ASC";
            cmd.Parameters.AddWithValue("@keyword", "%" + prefixText + "%");
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    result.Add(dr["SeminarArea"].ToString());
                }
            }

        }

        return result;
    }

    [WebMethod]
    public static List<string> GetSpeakers(string prefixText)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarSpeakerTitle, SeminarSpeakerFN, SeminarSpeakerLN, SeminarSpeakerID FROM SeminarSpeakers
                        WHERE (SeminarSpeakerLN LIKE @SearchText OR SeminarSpeakerFN LIKE @SearchText) 
                        ORDER BY SeminarSpeakerLN ASC";
            cmd.Parameters.AddWithValue("@SearchText", '%' + prefixText + '%');
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    string myString = dr["SeminarSpeakerTitle"] + " " + dr["SeminarSpeakerLN"].ToString() + ", " + dr["SeminarSpeakerFN"].ToString()
                        + "/vn/" + dr["SeminarSpeakerID"].ToString();
                    result.Add(myString);
                }
            }

        }

        return result;
    }

    private void GetAccountInfo()
    {
        if (Session["userid"] != null)
        {
            pnlUser.Visible = true;
            pnlGuest.Visible = false;

            using (SqlConnection con = new SqlConnection(Helper.GetCon()))
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT UserFirstName FROM Users WHERE UserID = @id";
                cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            ltUserName.Text = dr["UserFirstName"].ToString().ToUpper();
                        }
                    }
                }
            }
        }
        else
        {
            pnlUser.Visible = false;
            pnlGuest.Visible = true;
        }
    }

    private void GetCurrentMonth()
    {
        DateTime now = Helper.PHTime();
        var startDate = new DateTime(now.Year, now.Month, 1);
        var endDate = startDate.AddMonths(1).AddDays(-1);

        ltMonth.Text = startDate.ToString("M", CultureInfo.InvariantCulture);
        ltMonth2.Text = endDate.ToString("M", CultureInfo.InvariantCulture);
    }

    private void GetSeminars()
    {
        DateTime now = Helper.PHTime();
        var startDate = new DateTime(now.Year, now.Month, 1);
        var endDate = startDate.AddMonths(1).AddDays(-1);

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (!string.IsNullOrEmpty(txtTopic.Text) && string.IsNullOrEmpty(txtSpeaker.Text))
            {
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits, SeminarCode,
                    SeminarLocation, SeminarDate, 
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Seminars
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                    WHERE SeminarArea = @topic AND Seminars.DateAdded BETWEEN @dateone AND @datetwo
                    ORDER BY SeminarDate ASC";

            }
            else if (string.IsNullOrEmpty(txtTopic.Text) && !string.IsNullOrEmpty(txtSpeaker.Text))
            {
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits, SeminarCode,
                    SeminarLocation, SeminarDate, 
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Seminars
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                    WHERE SeminarSpeaker = @speaker AND Seminars.DateAdded BETWEEN @dateone AND @datetwo
                    ORDER BY SeminarDate ASC";
            }
            else if (!string.IsNullOrEmpty(txtTopic.Text) && !string.IsNullOrEmpty(txtSpeaker.Text))
            {
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits, SeminarCode,
                    SeminarLocation, SeminarDate, 
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Seminars
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                    WHERE SeminarSpeaker = @speaker AND 
                          SeminarArea = @topic AND Seminars.DateAdded BETWEEN @dateone AND @datetwo
                    ORDER BY SeminarDate ASC";
            }
            else
            {
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits, SeminarCode,
                    SeminarLocation, SeminarDate, 
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Seminars
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                    WHERE Seminars.DateAdded BETWEEN @dateone AND @datetwo
                    ORDER BY SeminarDate ASC";
            }

            cmd.Parameters.AddWithValue("@topic", txtTopic.Text);
            cmd.Parameters.AddWithValue("@speaker", hfSpeaker.Value);
            cmd.Parameters.AddWithValue("@dateone", startDate);
            cmd.Parameters.AddWithValue("@datetwo", endDate);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Seminars");
            lvSeminars.DataSource = ds;
            lvSeminars.DataBind();
        }
    }

    void ReservationModalHides()
    {
        if (Session["userid"] == null)
        {
            pnlAccount.Visible = true;
            pnlReserve.Visible = false;

        }
        else
        {
            pnlAccount.Visible = false;
            pnlReserve.Visible = true;
        }
    }

    void OpenReservationModal()
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "reserveSeminar", "$('#reserveSeminar').modal();", true);
    }

    private void GetSeminarDate()
    {
        var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
        var friday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Friday);

        if (!string.IsNullOrEmpty(txtDate.Text))
        {
            using (SqlConnection con = new SqlConnection(Helper.GetCon()))
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits,
                SeminarLocation, SeminarDate, 
                (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                FROM Seminars
                INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID 
                WHERE SeminarDate = @date
                ORDER BY SeminarDate ASC";
                cmd.Parameters.AddWithValue("@date", txtDate.Text);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "Seminars");
                lvSeminars.DataSource = ds;
                lvSeminars.DataBind();
            }
        }
        else
        {
            GetSeminars();
        }
    }

    public static string GetUserIP()
    {
        string VisitorsIPAddr = string.Empty;
        if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
        {
            VisitorsIPAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
        }
        else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
        {
            VisitorsIPAddr = HttpContext.Current.Request.UserHostAddress;
        }
        if (VisitorsIPAddr == "::1")
            VisitorsIPAddr = "127.0.0.1";
        return VisitorsIPAddr;
    }

    private void GetPaymentHistory()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarCode, SeminarTitle, SeminarDate, Reservations.DateAdded AS RDate, 
                    ReservationStatus, PaymentAmount, PaymentDate, PaymentStatus, PaymentType, VoucherCode 
                    FROM Payments
					INNER JOIN Reservations ON Payments.PaymentID = Reservations.PaymentID
					INNER JOIN Seminars ON Reservations.SeminarID = Seminars.SeminarID
					LEFT JOIN Vouchers ON Reservations.VoucherID = Vouchers.VoucherCode
					WHERE Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Payments");
            lvPayments.DataSource = ds;
            lvPayments.DataBind();
        }
    }

    private void GetReservationHistory()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarCode, SeminarTitle, SeminarArea, SeminarUnits,
                    SeminarLocation, SeminarDate, SeminarFee, Reservations.DateAdded AS RDate, ReservationStatus,
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Reservations
                    INNER JOIN Seminars ON Reservations.SeminarID = Seminars.SeminarID
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID 
                    WHERE Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Reservations");
            lvReservations.DataSource = ds;
            lvReservations.DataBind();
        }
    }

    private void GetAccountModalInfo()
    {
        upsuccess.Visible = false;
        uperror.Visible = false;
        upserverror.Visible = false;

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT UserFirstName, UserMidName, UserLastName,
                UserCompany, UserPosition, UserEmail, UserMobileNo, UserAddress,
                UserBday FROM Users WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtUpFN.Text = dr["UserFirstName"].ToString();
                        txtUpMN.Text = dr["UserMidName"].ToString();
                        txtUpLN.Text = dr["UserLastName"].ToString();
                        txtUpComp.Text = dr["UserCompany"].ToString();
                        txtUpPos.Text = dr["UserPosition"].ToString();
                        txtUpEAdd.Text = dr["UserEmail"].ToString();
                        txtUpMNo.Text = dr["UserMobileNo"].ToString();
                        txtUpAddr.Text = dr["UserAddress"].ToString();
                        DateTime bDay = DateTime.Parse(dr["UserBday"].ToString());
                        txtUPDb.Text = bDay.ToString("yyyy-MM-dd");

                        txtFN2.Text = dr["UserFirstName"].ToString();
                        txtMN2.Text = dr["UserMidName"].ToString();
                        txtLN2.Text = dr["UserLastName"].ToString();
                        txtComp2.Text = dr["UserCompany"].ToString();
                        txtPos2.Text = dr["UserPosition"].ToString();
                        txtEadd2.Text = dr["UserEmail"].ToString();
                        txtMNo2.Text = dr["UserMobileNo"].ToString();
                        txtAddr2.Text = dr["UserAddress"].ToString();
                        txtBday2.Text = bDay.ToString("yyyy-MM-dd");
                    }
                }
            }
        }
    }
    #endregion

    #region Bool
    private bool isExist()
    {
        bool existing = false;

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT UserEmail FROM Users WHERE UserEmail = @Email";
            cmd.Parameters.AddWithValue("@Email", txtEmailReg.Text);
            SqlDataReader data = cmd.ExecuteReader();
            if (data.HasRows)
                existing = true;
        }

        return existing;
    }

    private bool isExistModal()
    {
        bool existing = false;

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT UserEmail FROM Users WHERE UserEmail = @Email";
            cmd.Parameters.AddWithValue("@Email", txtModalEmailReg.Text);
            SqlDataReader data = cmd.ExecuteReader();
            if (data.HasRows)
                existing = true;
        }

        return existing;
    }

    bool CheckCaptcha()
    {
        bool isHuman = regCaptcha.Validate(txtCaptcha.Text);

        txtCaptcha.Text = null;

        return isHuman;
    }

    bool CheckModalCaptcha()
    {
        bool isHuman = modalRegCaptcha.Validate(txtModalCaptcha.Text);

        txtModalCaptcha.Text = null;

        return isHuman;
    }

    private bool isExistUpdate()
    {
        bool existing = false;

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT UserEmail FROM Users WHERE UserEmail = @Email AND UserID != @id";
            cmd.Parameters.AddWithValue("@Email", txtUpEAdd.Text);
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            SqlDataReader data = cmd.ExecuteReader();
            if (data.HasRows)
                existing = true;
        }

        return existing;
    }

    #endregion

    #region Button
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            try
            {
                servererror2.Visible = false;

                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT UserID, UserType FROM Users WHERE UserEmail = @Email AND " +
                    "UserPassword = @Password";
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", Helper.CreateSHAHash(txtPassword.Text));
                using (SqlDataReader data = cmd.ExecuteReader())
                {
                    if (data.HasRows)
                    {
                        while (data.Read())
                        {
                            Session["userid"] = data["UserID"].ToString();
                            Session["typeid"] = data["UserType"].ToString();
                        }

                        ReservationModalHides();
                        GetAccountInfo();
                        Helper.Log("User Login", GetUserIP(), "Login", Session["userid"].ToString());
                    }
                    else
                    {
                        loginerror.Visible = true;
                    }
                }
            }
            catch
            {
                servererror2.Visible = true;
            }
        }
    }

    protected void btnModalLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            try
            {
                servererror3.Visible = false;

                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT UserID, UserType FROM Users WHERE UserEmail = @Email AND " +
                    "UserPassword = @Password";
                cmd.Parameters.AddWithValue("@Email", txtModalEmail.Text);
                cmd.Parameters.AddWithValue("@Password", Helper.CreateSHAHash(txtModalPassword.Text));
                using (SqlDataReader data = cmd.ExecuteReader())
                {
                    if (data.HasRows)
                    {
                        while (data.Read())
                        {
                            Session["userid"] = data["UserID"].ToString();
                            Session["typeid"] = data["UserType"].ToString();
                        }

                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "loginModal", "$('#loginModal').modal('hide');", true);
                        GetAccountInfo();
                        Helper.Log("User Login", GetUserIP(), "Login", Session["userid"].ToString());
                    }
                    else
                    {
                        loginerror2.Visible = true;
                    }
                }
            }
            catch
            {
                servererror3.Visible = true;
            }
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        GetAccountInfo();
    }

    protected void lnkProfile_Click(object sender, EventArgs e)
    {
        GetAccountModalInfo();
        GetReservationHistory();
        GetPaymentHistory();

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "profileModal", "$('#profileModal').modal();", true);
    }

    protected void lnkLogin_Click(object sender, EventArgs e)
    {
        servererror3.Visible = false;
        loginerror2.Visible = false;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "loginModal", "$('#loginModal').modal();", true);
    }

    protected void lnkRegister_Click(object sender, EventArgs e)
    {
        servererror4.Visible = false;
        emailerror2.Visible = false;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "registerModal", "$('#registerModal').modal();", true);
    }

    protected void lnkUpdate2_Click(object sender, EventArgs e)
    {
        GetAccountModalInfo();

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "reserveSeminar", "$('#reserveSeminar').modal('hide');", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "profileModal", "$('#profileModal').modal();", true);
    }

    protected void lvSeminars_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        reservationsuccess.Visible = false;
        emailerror.Visible = false;
        loginerror.Visible = false;
        servererror.Visible = false;
        servererror2.Visible = false;

        Literal ltSeminarID = (Literal)e.Item.FindControl("ltSeminarID");

        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            ReservationModalHides();

            if (e.CommandName == "topicDesc")
            {
                cmd.CommandText = @"SELECT SeminarTitle, SeminarDescription FROM Seminars WHERE SeminarID = @id";
                cmd.Parameters.AddWithValue("@id", ltSeminarID.Text);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltModalTopic.Text = dr["SeminarTitle"].ToString();
                        ltModalDesc.Text = dr["SeminarDescription"].ToString();
                    }
                }

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "topicDesc", "$('#topicDesc').modal();", true);
            }
            else
            {
                cmd.CommandText = @"SELECT SeminarID, SeminarCode, SeminarTitle, SeminarArea, SeminarUnits,
                    SeminarLocation, SeminarDate, SeminarFee,
                    (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker 
                    FROM Seminars
                    INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID 
                    WHERE SeminarID = @id";
                cmd.Parameters.AddWithValue("@id", ltSeminarID.Text);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        DateTime SeminarDate = DateTime.Parse(dr["SeminarDate"].ToString());

                        hfSeminarID.Value = dr["SeminarID"].ToString();
                        ltCode.Text = dr["SeminarCode"].ToString();
                        ltRsvpHeader.Text = dr["SeminarTitle"].ToString();
                        ltRsvpArea.Text = dr["SeminarArea"].ToString();

                        if (dr["SeminarDate"].ToString() == "1/1/1900 12:00:00 AM")
                        {
                            ltRsvpDate.Text = "TBA";
                        }
                        else
                        {
                            ltRsvpDate.Text = SeminarDate.ToString("MMMM dd yyyy");
                        }

                        ltRsvpUnits.Text = dr["SeminarUnits"].ToString();
                        ltRsvpSpeaker.Text = dr["Speaker"].ToString();
                        ltRsvpVenue.Text = dr["SeminarLocation"].ToString();
                        ltPrice.Text = dr["SeminarFee"].ToString();

                        txtConfirmCode.Text = dr["SeminarCode"].ToString();
                        txtConfirmTitle.Text = dr["SeminarTitle"].ToString();
                        txtConfirmCompt.Text = dr["SeminarArea"].ToString();

                        if (dr["SeminarDate"].ToString() == "1/1/1900 12:00:00 AM")
                        {
                            txtConfirmDate.Text = "TBA";
                        }
                        else
                        {
                            txtConfirmDate.Text = SeminarDate.ToString("MMMM dd yyyy");
                        }

                        txtConfirmUnit.Text = dr["SeminarUnits"].ToString();
                        txtConfirmSpeaker.Text = dr["Speaker"].ToString();
                        txtConfirmVenue.Text = dr["SeminarLocation"].ToString();
                        txtConfirmFee.Text = dr["SeminarFee"].ToString();
                    }
                }

                OpenReservationModal();
            }
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (CheckCaptcha())
        {
            captchaerror.Visible = false;

            if (!isExist())
            {
                emailerror.Visible = false;

                using (SqlConnection con = new SqlConnection(Helper.GetCon()))
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        servererror.Visible = false;

                        con.Open();
                        cmd.Connection = con;

                        cmd.CommandText = @"INSERT INTO Users
                            (UserFirstName, UserLastName, UserMidName, UserBday, UserCompany, UserPosition, UserEmail,
                            UserMobileNo, UserAddress, UserPassword, UserStatus, UserType, DateAdded, UserIP) VALUES
                            (@fn, @ln, @mn, @bday, @comp, @pos, @email, @mobile, @addr, @pass, @status, @type, @dadded, @ip);
                            SELECT TOP 1 UserID FROM Users ORDER BY UserID DESC";
                        cmd.Parameters.AddWithValue("@fn", txtFN.Text);
                        cmd.Parameters.AddWithValue("@mn", txtMN.Text);
                        cmd.Parameters.AddWithValue("@ln", txtLN.Text);
                        cmd.Parameters.AddWithValue("@bday", txtBday.Text);
                        cmd.Parameters.AddWithValue("@comp", txtCompany.Text);
                        cmd.Parameters.AddWithValue("@pos", txtPosition.Text);
                        cmd.Parameters.AddWithValue("@email", txtEmailReg.Text);
                        cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
                        cmd.Parameters.AddWithValue("@addr", txtAddress.Text);
                        cmd.Parameters.AddWithValue("@pass", Helper.CreateSHAHash(txtPasswordReg.Text));
                        cmd.Parameters.AddWithValue("@status", "Active");
                        cmd.Parameters.AddWithValue("@type", "User");
                        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
                        cmd.Parameters.AddWithValue("@ip", GetUserIP());
                        int userid = (int)cmd.ExecuteScalar();

                        cmd.CommandText = "SELECT UserID, UserType FROM Users WHERE UserEmail = @email AND " +
                            "UserID = @id";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@email", txtEmailReg.Text);
                        cmd.Parameters.AddWithValue("@id", userid);
                        using (SqlDataReader data = cmd.ExecuteReader())
                        {
                            if (data.HasRows)
                            {
                                while (data.Read())
                                {
                                    Session["userid"] = data["UserID"].ToString();
                                    Session["typeid"] = data["UserType"].ToString();
                                }

                                Helper.Log("User Login", GetUserIP(), "Login", Session["userid"].ToString());
                            }
                        }

                        GetAccountInfo();
                        ReservationModalHides();
                    }
                    catch
                    {
                        servererror.Visible = true;
                    }
                }
            }
            else
            {
                emailerror.Visible = true;
            }
        }
        else
        {
            captchaerror.Visible = true;
        }

    }

    protected void btModalRegister_Click(object sender, EventArgs e)
    {
        if (CheckModalCaptcha())
        {
            captchaerror2.Visible = false;

            if (!isExistModal())
            {
                emailerror2.Visible = false;

                using (SqlConnection con = new SqlConnection(Helper.GetCon()))
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        servererror4.Visible = false;

                        con.Open();
                        cmd.Connection = con;

                        cmd.CommandText = @"INSERT INTO Users
                            (UserFirstName, UserLastName, UserMidName, UserBday, UserCompany, UserPosition, UserEmail,
                            UserMobileNo, UserAddress, UserPassword, UserStatus, UserType, DateAdded, UserIP) VALUES
                            (@fn, @ln, @mn, @bday, @comp, @pos, @email, @mobile, @addr, @pass, @status, @type, @dadded, @ip);
                            SELECT TOP 1 UserID FROM Users ORDER BY UserID DESC";
                        cmd.Parameters.AddWithValue("@fn", txtModalFN.Text);
                        cmd.Parameters.AddWithValue("@mn", txtModalMN.Text);
                        cmd.Parameters.AddWithValue("@ln", txtModalLN.Text);
                        cmd.Parameters.AddWithValue("@bday", txtModalBday.Text);
                        cmd.Parameters.AddWithValue("@comp", txtModalComp.Text);
                        cmd.Parameters.AddWithValue("@pos", txtModalPos.Text);
                        cmd.Parameters.AddWithValue("@email", txtModalEmailReg.Text);
                        cmd.Parameters.AddWithValue("@mobile", txtModalMobile.Text);
                        cmd.Parameters.AddWithValue("@addr", txtModalAddr.Text);
                        cmd.Parameters.AddWithValue("@pass", Helper.CreateSHAHash(txtModalPass.Text));
                        cmd.Parameters.AddWithValue("@status", "Active");
                        cmd.Parameters.AddWithValue("@type", "User");
                        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
                        cmd.Parameters.AddWithValue("@ip", GetUserIP());
                        int userid = (int)cmd.ExecuteScalar();

                        cmd.CommandText = "SELECT UserID, UserType FROM Users WHERE UserEmail = @email AND " +
                            "UserID = @id";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@email", txtModalEmailReg.Text);
                        cmd.Parameters.AddWithValue("@id", userid);
                        using (SqlDataReader data = cmd.ExecuteReader())
                        {
                            if (data.HasRows)
                            {
                                while (data.Read())
                                {
                                    Session["userid"] = data["UserID"].ToString();
                                    Session["typeid"] = data["UserType"].ToString();
                                }

                            }
                        }

                        GetAccountInfo();
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "registerModal", "$('#registerModal').modal('hide');", true);
                    }
                    catch
                    {
                        servererror4.Visible = true;
                    }
                }
            }
            else
            {
                emailerror2.Visible = true;
            }
        }
        else
        {
            captchaerror2.Visible = true;
        }

    }

    protected void btnUpdateInfo_Click(object sender, EventArgs e)
    {
        if (!isExistUpdate())
        {
            uperror.Visible = false;

            using (SqlConnection con = new SqlConnection(Helper.GetCon()))
            using (SqlCommand cmd = new SqlCommand())
            {
                try
                {
                    upserverror.Visible = false;

                    con.Open();
                    cmd.Connection = con;

                    if (string.IsNullOrEmpty(txtUpPass.Text))
                    {
                        cmd.CommandText = @"UPDATE Users SET UserFirstName = @fn, UserMidName = @mn,
                        UserLastName = @ln, UserBday = @bday, UserCompany = @comp, UserPosition = @pos, UserEmail = @email,
                        UserMobileNo = @mobno, UserAddress = @addr, DateModified = @dmod WHERE UserID = @id";
                    }
                    else
                    {
                        cmd.CommandText = @"UPDATE Users SET UserFirstName = @fn, UserMidName = @mn,
                        UserLastName = @ln, UserBday = @bday, UserCompany = @comp, UserPosition = @pos, UserEmail = @email,
                        UserMobileNo = @mobno, UserAddress = @addr, UserPassword = @pass, DateModified = @dmod WHERE UserID = @id";
                    }
                    cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
                    cmd.Parameters.AddWithValue("fn", txtUpFN.Text);
                    cmd.Parameters.AddWithValue("@mn", txtUpMN.Text);
                    cmd.Parameters.AddWithValue("@ln", txtUpLN.Text);
                    cmd.Parameters.AddWithValue("@bday", txtUPDb.Text);
                    cmd.Parameters.AddWithValue("@comp", txtUpComp.Text);
                    cmd.Parameters.AddWithValue("@pos", txtUpPos.Text);
                    cmd.Parameters.AddWithValue("@email", txtUpEAdd.Text);
                    cmd.Parameters.AddWithValue("@mobno", txtUpMNo.Text);
                    cmd.Parameters.AddWithValue("@addr", txtUpAddr.Text);
                    cmd.Parameters.AddWithValue("@pass", Helper.CreateSHAHash(txtUpPass.Text));
                    cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
                    cmd.ExecuteNonQuery();

                    upsuccess.Visible = true;
                }
                catch
                {
                    upserverror.Visible = true;
                }
            }
        }

        else
        {
            uperror.Visible = true;
        }
    }

    protected void lnkConfirmReservation_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            cmd.CommandText = @"INSERT INTO Payments
                (PaymentAmount, PaymentStatus, PaymentType, UserID)
                VALUES (@amount, @status, @type, @id); SELECT TOP 1 PaymentID
                FROM Payments WHERE UserID = @id ORDER BY PaymentID DESC";
            cmd.Parameters.AddWithValue("id", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@amount", txtConfirmFee.Text);
            cmd.Parameters.AddWithValue("@status", "Unpaid");
            cmd.Parameters.AddWithValue("@type", ddlPaymentMethod.SelectedValue);
            int payID = (int)cmd.ExecuteScalar();

            cmd.CommandText = @"INSERT INTO Reservations
                (SeminarID, UserID, PaymentID, VoucherID, ReservationStatus, DateAdded)
                VALUES
                (@semid, @userid, @payid, @vouchid, @restatus, @dadd)";
            cmd.Parameters.AddWithValue("@semid", hfSeminarID.Value);
            cmd.Parameters.AddWithValue("@userid", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@payid", payID);
            cmd.Parameters.AddWithValue("@vouchid", "");
            cmd.Parameters.AddWithValue("@restatus", "Pending");
            cmd.Parameters.AddWithValue("@dadd", Helper.PHTime());
            cmd.ExecuteNonQuery();
        }

        reservationsuccess.Visible = true;
    }
    #endregion

    #region Events
    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        GetSeminarDate();
    }

    protected void lvSeminars_DataBound(object sender, EventArgs e)
    {
        dpSeminars.Visible = dpSeminars.PageSize < dpSeminars.TotalRowCount;
    }

    protected void lvSeminars_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpSeminars.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetSeminars();
    }

    protected void txtTopic_TextChanged(object sender, EventArgs e)
    {
        GetSeminars();
    }

    protected void txtSpeaker_TextChanged(object sender, EventArgs e)
    {
        GetSeminars();
    }

    protected void lvReservations_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpReservations.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetReservationHistory();
    }

    protected void lvReservations_DataBound(object sender, EventArgs e)
    {
        dpReservations.Visible = dpReservations.PageSize < dpReservations.TotalRowCount;
    }

    protected void lvPayments_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpPayments.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetPaymentHistory();
    }

    protected void lvPayments_DataBound(object sender, EventArgs e)
    {
        dpPayments.Visible = dpPayments.PageSize < dpPayments.TotalRowCount;
    }
    #endregion
}
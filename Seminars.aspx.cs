﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seminars : System.Web.UI.Page
{
    private string _Topic;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetSpeakers();
            GetTopics();
            GetSeminars();
            GetCurrentWeek();
            GetAccountInfo();
        }
    }

    #region Method
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

    private void GetTopics()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT DISTINCT SeminarArea FROM Seminars";
            SqlDataReader dr = cmd.ExecuteReader();
            ddlTopic.DataSource = dr;
            ddlTopic.DataTextField = "SeminarArea";
            ddlTopic.DataValueField = "SeminarArea";
            ddlTopic.DataBind();

            ddlTopic.Items.Insert(0, "All Thematic Area");
        }
    }

    private void GetSpeakers()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT DISTINCT SeminarSpeakerID,
                (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker FROM SeminarSpeakers";
            SqlDataReader dr = cmd.ExecuteReader();
            ddlSpeaker.DataSource = dr;
            ddlSpeaker.DataTextField = "Speaker";
            ddlSpeaker.DataValueField = "SeminarSpeakerID";
            ddlSpeaker.DataBind();

            ddlSpeaker.Items.Insert(0, "All Speakers");
        }
    }

    private void GetCurrentWeek()
    {
        var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
        var friday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Friday);

        ltMonth.Text = monday.ToString("M", CultureInfo.InvariantCulture);
        ltMonth2.Text = friday.ToString("M", CultureInfo.InvariantCulture);
    }

    private void GetSeminars()
    {
        var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
        var friday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Friday);

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
                ORDER BY SeminarDate ASC";
            cmd.Parameters.AddWithValue("@day", ddlDay.SelectedValue);
            cmd.Parameters.AddWithValue("@topic", ddlTopic.SelectedValue);
            cmd.Parameters.AddWithValue("@speaker", ddlSpeaker.SelectedValue);
            cmd.Parameters.AddWithValue("@dateone", monday);
            cmd.Parameters.AddWithValue("@datetwo", friday);
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

    protected void lvSeminars_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
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
                cmd.CommandText = @"SELECT SeminarID, SeminarTitle, SeminarArea, SeminarUnits,
                    SeminarLocation, SeminarDate, 
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
                        ltRsvpHeader.Text = dr["SeminarTitle"].ToString();
                        ltRsvpArea.Text = dr["SeminarArea"].ToString();
                        ltRsvpDate.Text = dr["SeminarDate"].ToString();
                        ltRsvpUnits.Text = dr["SeminarUnits"].ToString();
                        ltRsvpSpeaker.Text = dr["Speaker"].ToString();
                        ltRsvpVenue.Text = dr["SeminarLocation"].ToString();
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
                            (UserFirstName, UserLastName, UserMidName, UserCompany, UserPosition, UserEmail,
                            UserMobileNo, UserAddress, UserPassword, UserStatus, UserType, DateAdded, UserIP) VALUES
                            (@fn, @mn, @ln, @comp, @pos, @email, @mobile, @addr, @pass, @status, @type, @dadded, @ip);
                            SELECT TOP 1 UserID FROM Users ORDER BY UserID DESC";
                        cmd.Parameters.AddWithValue("@fn", txtFN.Text);
                        cmd.Parameters.AddWithValue("@mn", txtMN.Text);
                        cmd.Parameters.AddWithValue("@ln", txtLN.Text);
                        cmd.Parameters.AddWithValue("@comp", txtCompany.Text);
                        cmd.Parameters.AddWithValue("@pos", txtPosition.Text);
                        cmd.Parameters.AddWithValue("@email", txtEmailReg.Text);
                        cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
                        cmd.Parameters.AddWithValue("@addr", txtAddress.Text);
                        cmd.Parameters.AddWithValue("@pass", Helper.CreateSHAHash(txtPasswordReg.Text));
                        cmd.Parameters.AddWithValue("@status", "Active");
                        cmd.Parameters.AddWithValue("@type", "User");
                        cmd.Parameters.AddWithValue("@dadded", DateTime.Now);
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
                            (UserFirstName, UserLastName, UserMidName, UserCompany, UserPosition, UserEmail,
                            UserMobileNo, UserAddress, UserPassword, UserStatus, UserType, DateAdded, UserIP) VALUES
                            (@fn, @mn, @ln, @comp, @pos, @email, @mobile, @addr, @pass, @status, @type, @dadded, @ip);
                            SELECT TOP 1 UserID FROM Users ORDER BY UserID DESC";
                        cmd.Parameters.AddWithValue("@fn", txtModalFN.Text);
                        cmd.Parameters.AddWithValue("@mn", txtModalMN.Text);
                        cmd.Parameters.AddWithValue("@ln", txtModalLN.Text);
                        cmd.Parameters.AddWithValue("@comp", txtModalComp.Text);
                        cmd.Parameters.AddWithValue("@pos", txtModalPos.Text);
                        cmd.Parameters.AddWithValue("@email", txtModalEmailReg.Text);
                        cmd.Parameters.AddWithValue("@mobile", txtModalMobile.Text);
                        cmd.Parameters.AddWithValue("@addr", txtModalAddr.Text);
                        cmd.Parameters.AddWithValue("@pass", Helper.CreateSHAHash(txtModalPass.Text));
                        cmd.Parameters.AddWithValue("@status", "Active");
                        cmd.Parameters.AddWithValue("@type", "User");
                        cmd.Parameters.AddWithValue("@dadded", DateTime.Now);
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
    #endregion

    #region Events
    protected void ddlTopic_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSeminars();
    }

    protected void ddlSpeaker_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSeminars();
    }

    protected void ddlDay_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSeminars();
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        GetSeminarDate();
    }

    protected void lvSeminars_DataBound(object sender, EventArgs e)
    {

    }

    protected void lvSeminars_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {

    }
    #endregion
}
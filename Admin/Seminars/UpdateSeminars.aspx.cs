using System;
using System.Data.SqlClient;

public partial class Admin_Seminars_UpdateSeminars : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Helper.ValidateAdmin();

        int seminarID = 0;
        bool validSeminar = int.TryParse(Request.QueryString["ID"], out seminarID);

        if (validSeminar)
        {
            if (!IsPostBack)
            {
                GetSpeakers();
                GetSeminars(seminarID);
            }
        }
    }

    private void GetSpeakers()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarSpeakerID, SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + 
                SeminarSpeakerLN AS SpeakerName
                FROM SeminarSpeakers";
            SqlDataReader dr = cmd.ExecuteReader();
            ddlSpeaker.DataSource = dr;
            ddlSpeaker.DataTextField = "SpeakerName";
            ddlSpeaker.DataValueField = "SeminarSpeakerID";
            ddlSpeaker.DataBind();
        }
    }

    private void GetSeminars(int seminarID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarID, SeminarCode, SeminarTitle, SeminarArea,
                            SeminarUnits, SeminarFee, SeminarLocation, SeminarDate, SeminarSpeaker,
                            SeminarStatus FROM Seminars
                            WHERE SeminarID = @id";
            cmd.Parameters.AddWithValue("@id", seminarID);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtID.Text = dr["SeminarID"].ToString();
                        txtCode.Text = dr["SeminarCode"].ToString();
                        txtTitle.Text = dr["SeminarTitle"].ToString();
                        txtCompetency.Text = dr["SeminarArea"].ToString();
                        txtUnits.Text = dr["SeminarUnits"].ToString();
                        txtPrice.Text = dr["SeminarFee"].ToString();
                        txtLocation.Text = dr["SeminarLocation"].ToString();
                        DateTime SeminarDate = DateTime.Parse(dr["SeminarDate"].ToString());
                        txtDate.Text = SeminarDate.ToString("yyyy-MM-dd");
                        ddlSpeaker.SelectedValue = dr["SeminarSpeaker"].ToString();
                        ddlStatus.SelectedValue = dr["SeminarStatus"].ToString();
                    }
                }
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Seminars SET SeminarCode = @code, SeminarTitle = @title,
                SeminarArea = @compt, SeminarUnits = @units, SeminarFee = @fee,
                SeminarLocation = @loc, SeminarDate = @date, SeminarSpeaker = @speaker,
                SeminarStatus = @status, DateModified = @dmod WHERE SeminarID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"].ToString());
            cmd.Parameters.AddWithValue("@code", txtCode.Text);
            cmd.Parameters.AddWithValue("@title", txtTitle.Text);
            cmd.Parameters.AddWithValue("@compt", txtCompetency.Text);
            cmd.Parameters.AddWithValue("@loc", txtLocation.Text);
            cmd.Parameters.AddWithValue("@date", txtDate.Text);
            cmd.Parameters.AddWithValue("@units", txtUnits.Text);
            cmd.Parameters.AddWithValue("@fee", txtPrice.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@speaker", ddlSpeaker.SelectedValue);
            cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Response.Redirect("ViewSeminars.aspx");
        }
    }
}
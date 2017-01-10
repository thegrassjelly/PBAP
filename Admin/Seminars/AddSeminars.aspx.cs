using System;
using System.Data.SqlClient;

public partial class Admin_Seminars_AddSeminars : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetSpeakes();
        }
    }

    private void GetSpeakes()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarSpeakerID, SeminarSpeakerTitle + ' ' + SeminarSpeakerLN + ' ' + 
                SeminarSpeakerFN AS SpeakerName
                FROM SeminarSpeakers";
            SqlDataReader dr = cmd.ExecuteReader();
            ddlSpeaker.DataSource = dr;
            ddlSpeaker.DataTextField = "SpeakerName";
            ddlSpeaker.DataValueField = "SeminarSpeakerID";
            ddlSpeaker.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Seminars
                (SeminarCode, SeminarTitle, SeminarArea, SeminarUnits, SeminarDescription, SeminarFee, SeminarLocation,
                SeminarDate, SeminarSpeaker, SeminarStatus, DateAdded, DateModified) VALUES
                (@code, @title, @area, @units, @desc, @fee, @loc, @date, @speaker, @status, @dadd, @dmod)";
            cmd.Parameters.AddWithValue("@code", txtCode.Text);
            cmd.Parameters.AddWithValue("@title", txtTitle.Text);
            cmd.Parameters.AddWithValue("@area", txtCompetency.Text);
            cmd.Parameters.AddWithValue("@units", txtUnits.Text);
            cmd.Parameters.AddWithValue("@desc", txtDesc.Text);
            cmd.Parameters.AddWithValue("@fee", decimal.Parse(txtPrice.Text));
            cmd.Parameters.AddWithValue("@loc", txtLocation.Text);
            cmd.Parameters.AddWithValue("@date", txtDate.Text);
            cmd.Parameters.AddWithValue("@speaker", ddlSpeaker.SelectedValue);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@dadd", Helper.PHTime());
            cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Response.Redirect("ViewSeminars.aspx");
        }
    }
}
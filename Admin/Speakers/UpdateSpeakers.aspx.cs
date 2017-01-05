using System;
using System.Data.SqlClient;
public partial class Admin_Speakers_UpdateSpeakers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Helper.ValidateAdmin();

        int speakerID = 0;
        bool validSpeaker = int.TryParse(Request.QueryString["ID"], out speakerID);

        if (validSpeaker)
        {
            if (!IsPostBack)
            {
                GetSpeakers(speakerID);
            }
        }
    }

    private void GetSpeakers(int speakerID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarSpeakerID, SeminarSpeakerTitle, SeminarSpeakerFN,
                            SeminarSpeakerLN, SeminarSpeakerTel, SeminarSpeakerEmail, SeminarSpeakerStatus
                            FROM SeminarSpeakers WHERE SeminarSpeakerID = @id";
            cmd.Parameters.AddWithValue("@id", speakerID);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtID.Text = dr["SeminarSpeakerID"].ToString();
                        ddlTitle.SelectedValue = dr["SeminarSpeakerTitle"].ToString();
                        txtFN.Text = dr["SeminarSpeakerFN"].ToString();
                        txtLN.Text = dr["SeminarSpeakerLN"].ToString();
                        txtMN.Text = dr["SeminarSpeakerTel"].ToString();
                        txtEAdd.Text = dr["SeminarSpeakerEmail"].ToString();
                        ddlStatus.SelectedValue = dr["SeminarSpeakerStatus"].ToString();
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
            cmd.CommandText = @"UPDATE SeminarSpeakers SET SeminarSpeakerTitle = @title, SeminarSpeakerFN = @fn,
                SeminarSpeakerLN = @ln, SeminarSpeakerTel = @mn, SeminarSpeakerEmail = @email,
                SeminarSpeakerStatus = @status, DateModified = @dmod WHERE SeminarSpeakerID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"].ToString());
            cmd.Parameters.AddWithValue("@title", ddlTitle.SelectedValue);
            cmd.Parameters.AddWithValue("@fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@mn", txtMN.Text);
            cmd.Parameters.AddWithValue("@email", txtEAdd.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@dmod", DateTime.Now);
            cmd.ExecuteNonQuery();

            Response.Redirect("ViewSpeakers.aspx");
        }
    }
}
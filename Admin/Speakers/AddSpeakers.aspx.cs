using System;
using System.Data.SqlClient;

public partial class Admin_Speakers_AddSpeakers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Helper.ValidateAdmin();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO SeminarSpeakers
                (SeminarSpeakerTitle, SeminarSpeakerFN, SeminarSpeakerLN, SeminarSpeakerTel, SeminarSpeakerEmail, SeminarSpeakerStatus, DateAdded, DateModified)
                VALUES
                (@title, @fn, @ln, @tel, @email, @status, @dadd, @dmod)";
            cmd.Parameters.AddWithValue("@title",ddlTitle.SelectedValue);
            cmd.Parameters.AddWithValue("@fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@tel", txtMN.Text);
            cmd.Parameters.AddWithValue("@email", txtEAdd.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@dadd", DateTime.Now);
            cmd.Parameters.AddWithValue("@dmod", DateTime.Now);
            cmd.ExecuteNonQuery();

            Response.Redirect("ViewSpeakers.aspx");
        }
    }
}
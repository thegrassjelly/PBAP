using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seminars : System.Web.UI.Page
{
    private string _Topic;

    protected void Page_Load(object sender, EventArgs e)
    {
        //Helper.ValidateUser();

        if (!IsPostBack)
        {
            GetSpeakers();
            GetTopics();
            GetSeminars();
            GetCurrentWeek();
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

    protected void lvSeminars_DataBound(object sender, EventArgs e)
    {
        
    }

    protected void lvSeminars_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {

    }

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

    protected void lvSeminars_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "topicDesc")
        {
            Literal ltSeminarID = (Literal)e.Item.FindControl("ltSeminarID");

            using (SqlConnection con = new SqlConnection(Helper.GetCon()))
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
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
            }

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "topicDesc", "$('#topicDesc').modal();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "reserveSeminar", "$('#reserveSeminar').modal();", true);
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        GetSeminarDate();
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
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Speakers_ViewSpeakers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetSpeakers(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;

    }

    private void GetSpeakers(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarSpeakerID, SeminarSpeakerTitle, SeminarSpeakerFN, SeminarSpeakerLN,
                            SeminarSpeakerTel, SeminarSpeakerEmail, SeminarSpeakerStatus, DateAdded, DateModified FROM SeminarSpeakers
                            WHERE (SeminarSpeakerID LIKE @keyword OR 
                            SeminarSpeakerTitle LIKE @keyword OR 
                            SeminarSpeakerFN LIKE @keyword OR 
                            SeminarSpeakerLN LIKE @keyword) AND SeminarSpeakerStatus = @status ORDER BY SeminarSpeakerID ASC";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "SeminarSpeakers");
            lvSpeakers.DataSource = ds;
            lvSpeakers.DataBind();
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSpeakers(txtSearch.Text);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetSpeakers(txtSearch.Text);
    }

    protected void lvSpeakers_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpSpeakers.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetSpeakers(txtSearch.Text);
    }

    protected void lvSpeakers_DataBound(object sender, EventArgs e)
    {
        dpSpeakers.Visible = dpSpeakers.PageSize < dpSpeakers.TotalRowCount;

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetSpeakers(txtSearch.Text);
    }
}
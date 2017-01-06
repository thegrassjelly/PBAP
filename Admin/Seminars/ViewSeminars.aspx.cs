using System;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Seminars_ViewSeminars : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetSeminars(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetSeminars(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SeminarID, SeminarCode, SeminarTitle, SeminarArea,
                            SeminarUnits, SeminarFee, SeminarLocation, SeminarDate, 
                            (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS Speaker,
                            SeminarStatus, Seminars.DateAdded, Seminars.DateModified FROM Seminars
                            INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                            WHERE (SeminarID LIKE @keyword OR 
                            SeminarCode LIKE @keyword OR 
                            SeminarTitle LIKE @keyword OR 
                            SeminarArea LIKE @keyword OR 
                            SeminarLocation LIKE @keyword OR
                            SeminarDate LIKE @keyword) AND SeminarStatus = @status ORDER BY DateAdded DESC";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Seminars");
            lvSeminars.DataSource = ds;
            lvSeminars.DataBind();
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSeminars(txtSearch.Text);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetSeminars(txtSearch.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetSeminars(txtSearch.Text);
    }


    protected void lvSeminars_PagePropertiesChanging(object sender, System.Web.UI.WebControls.PagePropertiesChangingEventArgs e)
    {
        dpSeminars.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetSeminars(txtSearch.Text);
    }

    protected void lvSeminars_DataBound(object sender, EventArgs e)
    {
        dpSeminars.Visible = dpSeminars.PageSize < dpSeminars.TotalRowCount;
    }
}
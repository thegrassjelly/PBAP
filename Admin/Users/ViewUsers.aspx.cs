using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Admin_Users_ViewUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetUsers(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetUsers(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con; 
            cmd.CommandText = @"SELECT UserID, UserLastName + ', ' + UserFirstName + ' ' + UserMidName AS UserName, 
                            UserCompany, UserPosition, UserEmail, UserMobileNo, UserStatus, UserType, DateAdded, DateModified
                            FROM Users
                            WHERE (UserID LIKE @keyword OR 
                            UserLastName LIKE @keyword OR 
                            UserFirstName LIKE @keyword OR 
                            UserMidName LIKE @keyword OR 
                            UserCompany LIKE @keyword OR
                            UserPosition LIKE @keyword) AND UserStatus = @status AND UserType = @type ORDER BY UserID ASC";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Users");
            lvUsers.DataSource = ds;
            lvUsers.DataBind();
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetUsers(txtSearch.Text);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetUsers(txtSearch.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetUsers(txtSearch.Text);
    }

    protected void lvUsers_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpUsers.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetUsers(txtSearch.Text);
    }

    protected void lvUsers_DataBound(object sender, EventArgs e)
    {
        dpUsers.Visible = dpUsers.PageSize < dpUsers.TotalRowCount;
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetUsers(txtSearch.Text);
    }
}
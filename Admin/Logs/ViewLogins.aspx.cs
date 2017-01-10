using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Logs_ViewLogins : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetUserLogs();
        }
    }

    private void GetUserLogs()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT LogID, Users.UserID, UserFirstName + ' ' + UserLastName AS UserName, LogTitle,
                LogContent, LogType, LogDate FROM Logs
                INNER JOIN Users ON Logs.UserID = Users.UserID";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Logs");
            lvLoginLogs.DataSource = ds;
            lvLoginLogs.DataBind();
        }
    }

    protected void lvLoginLogs_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpLogs.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetUserLogs();
    }

    protected void lvLoginLogs_DataBound(object sender, EventArgs e)
    {
        dpLogs.Visible = dpLogs.PageSize < dpLogs.TotalRowCount;
    }

    protected void lvLoginLogs_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Literal ltUserID = (Literal)e.Item.FindControl("ltUserID");

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT Users.UserID, UserFirstName, UserMidName, UserLastName,
                UserCompany, UserPosition, UserEmail, UserFaxNo, UserTelNo, UserMobileNo, UserAddress,
                UserBday, UserStatus, UserType FROM Users
                WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", ltUserID.Text);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtID.Text = dr["UserID"].ToString();
                        txtFN.Text = dr["UserFirstName"].ToString();
                        txtMN.Text = dr["UserMidName"].ToString();
                        txtLN.Text = dr["UserLastName"].ToString();
                        DateTime bDay = DateTime.Parse(dr["UserBday"].ToString());
                        txtBday.Text = bDay.ToString("yyyy-MM-dd");
                        txtCompany.Text = dr["UserCompany"].ToString();
                        txtPosition.Text = dr["UserPosition"].ToString();
                        txtEmail.Text = dr["UserEmail"].ToString();
                        txtFax.Text = dr["UserFaxNo"].ToString();
                        txtLNo.Text = dr["UserTelNo"].ToString();
                        txtAddr.Text = dr["UserAddress"].ToString();
                        txtMNo.Text = dr["UserMobileNo"].ToString();
                        ddlStatus.SelectedValue = dr["UserStatus"].ToString();
                        ddlType.SelectedValue = dr["UserType"].ToString();
                    }
                }
            }
        }

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "userInfo", "$('#userInfo').modal();", true);
    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            try
            {
                servererror.Visible = false;

                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT UserID, UserType FROM Users WHERE UserEmail = @Email AND " +
                    "UserPassword = @Password AND UserType = 'Admin'";
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

                        Response.Redirect("~/Admin/Default.aspx");
                    }
                    else
                    {
                        loginerror.Visible = true;
                    }
                }
            }
            catch
            {
                servererror.Visible = true;
            }
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtEmail.Text = string.Empty;
        txtPassword.Text = string.Empty;
        loginerror.Visible = false;
        servererror.Visible = false;
    }
}
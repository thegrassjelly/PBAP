using System;
using System.Data.SqlClient;

public partial class Admin_Users_AddUsers : System.Web.UI.Page
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
            cmd.CommandText = @"INSERT INTO Users
                            (UserFirstName, UserLastName, UserMidName, UserBday, UserCompany, UserPosition, UserEmail,
                            UserFaxNo, UserTelNo, UserMobileNo, UserAddress, UserStatus, UserType, DateAdded) VALUES
                            (@fn, @ln, @mn, @bday, @comp, @pos, @email, @fax, @tel, @mobile, @addr, @status, @type, @dadded)";
            cmd.Parameters.AddWithValue("@fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@mn", txtMN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@bday", txtBday.Text);
            cmd.Parameters.AddWithValue("@comp", txtCompany.Text);
            cmd.Parameters.AddWithValue("@pos", txtPosition.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@fax", txtFax.Text);
            cmd.Parameters.AddWithValue("@tel", txtLNo.Text);
            cmd.Parameters.AddWithValue("@mobile", txtMNo.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
            cmd.Parameters.AddWithValue("@dadded", DateTime.Now);

            Response.Redirect("ViewUsers.aspx");
        }
    }
}
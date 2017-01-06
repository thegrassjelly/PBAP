using System;
using System.Data.SqlClient;

public partial class Admin_Users_UpdateUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int userID = 0;
        bool validUser = int.TryParse(Request.QueryString["ID"], out userID);

        if (validUser)
        {
            if (!IsPostBack)
            {
                GetUser(userID);
            }
        }
        else if (Request.QueryString["Profile"] == "1")
        {
            if (!IsPostBack)
            {
                GetUser(int.Parse(Session["userid"].ToString()));
            }
        }
    }

    private void GetUser(int userID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT UserID, UserFirstName, UserMidName, UserLastName,
                UserCompany, UserPosition, UserEmail, UserFaxNo, UserTelNo, UserMobileNo, UserAddress,
                UserBday, UserStatus, UserType FROM Users WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", userID);
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
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Users SET UserFirstName = @fn, UserMidName = @mn,
                        UserLastName = @ln, UserBday = @bday, UserCompany = @comp, UserPosition = @pos, UserEmail = @email,
                        UserFaxNo = @fax, UserTelNo = @tel, UserMobileNo = @mobno, UserAddress = @addr, UserStatus = @status,
                        UserType = @type, DateModified = @dmod WHERE UserID = @id";

            if (Request.QueryString["Profile"] == "1")
            {
                cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"].ToString());
            }

            cmd.Parameters.AddWithValue("fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@mn", txtMN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@bday", txtBday.Text);
            cmd.Parameters.AddWithValue("@comp", txtCompany.Text);
            cmd.Parameters.AddWithValue("@pos", txtPosition.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@fax", txtFax.Text);
            cmd.Parameters.AddWithValue("@tel", txtLNo.Text);
            cmd.Parameters.AddWithValue("@mobno", txtMNo.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddr.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
            cmd.Parameters.AddWithValue("@dmod", DateTime.Now);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("ViewUsers.aspx");
    }
}
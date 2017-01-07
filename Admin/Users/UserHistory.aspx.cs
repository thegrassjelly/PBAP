using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Users_UserHistory : System.Web.UI.Page
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
                GetReservations(txtSearch.Text);
                GetUserInfo(userID);
            }
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetUserInfo(int userID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT UserFirstName + ' ' + UserLastName AS Name FROM Users
                WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", userID);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        ltName.Text = dr["Name"].ToString();
                    }
                }
            }
        }
    }

    private void GetReservations(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (ddlStatus.SelectedValue == "All Reservations")
            {
                if (ddlPaymentStatus.SelectedValue == "All Payments")
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus, PaymentType,
                            PaymentStatus, PaymentDate,
                            (UserFirstName + ' ' + UserLastName) AS AttendeeName, Reservations.DateAdded, Reservations.DateModified 
                            FROM Reservations
                            INNER JOIN Seminars ON Seminars.SeminarID = Reservations.SeminarID
                            INNER JOIN Payments ON Payments.PaymentID = Reservations.PaymentID
                            INNER JOIN Users ON Users.UserID = Reservations.UserID
                            WHERE (
                            SeminarCode LIKE @keyword OR 
                            SeminarTitle LIKE @keyword OR 
                            ReservationStatus LIKE @keyword OR 
                            PaymentStatus LIKE @keyword OR
                            UserFirstName LIKE @keyword OR
                            UserLastName LIKE @keyword) AND Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";
                }
                else
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus, PaymentType, PaymentDate,
                            (UserFirstName + ' ' + UserLastName) AS AttendeeName, Reservations.DateAdded, Reservations.DateModified 
                            FROM Reservations
                            INNER JOIN Seminars ON Seminars.SeminarID = Reservations.SeminarID
                            INNER JOIN Payments ON Payments.PaymentID = Reservations.PaymentID
                            INNER JOIN Users ON Users.UserID = Reservations.UserID
                            WHERE (
                            SeminarCode LIKE @keyword OR 
                            SeminarTitle LIKE @keyword OR 
                            ReservationStatus LIKE @keyword OR 
                            PaymentStatus LIKE @keyword OR
                            UserFirstName LIKE @keyword OR
                            UserLastName LIKE @keyword) AND PaymentStatus = @pstatus AND Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";
                }
            }
            else
            {
                if (ddlPaymentStatus.SelectedValue == "All Payments")
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus, PaymentType, PaymentDate,
                            (UserFirstName + ' ' + UserLastName) AS AttendeeName, Reservations.DateAdded, Reservations.DateModified 
                            FROM Reservations
                            INNER JOIN Seminars ON Seminars.SeminarID = Reservations.SeminarID
                            INNER JOIN Payments ON Payments.PaymentID = Reservations.PaymentID
                            INNER JOIN Users ON Users.UserID = Reservations.UserID
                            WHERE (
                            SeminarCode LIKE @keyword OR 
                            SeminarTitle LIKE @keyword OR 
                            ReservationStatus LIKE @keyword OR 
                            PaymentStatus LIKE @keyword OR
                            UserFirstName LIKE @keyword OR
                            UserLastName LIKE @keyword) AND ReservationStatus = @rstatus AND Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";

                }
                else
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus, PaymentType, PaymentDate,
                            (UserFirstName + ' ' + UserLastName) AS AttendeeName, Reservations.DateAdded, Reservations.DateModified 
                            FROM Reservations
                            INNER JOIN Seminars ON Seminars.SeminarID = Reservations.SeminarID
                            INNER JOIN Payments ON Payments.PaymentID = Reservations.PaymentID
                            INNER JOIN Users ON Users.UserID = Reservations.UserID
                            WHERE (
                            SeminarCode LIKE @keyword OR 
                            SeminarTitle LIKE @keyword OR 
                            ReservationStatus LIKE @keyword OR 
                            PaymentStatus LIKE @keyword OR
                            UserFirstName LIKE @keyword OR
                            UserLastName LIKE @keyword) AND ReservationStatus = @rstatus AND PaymentStatus = @pstatus 
                            AND Reservations.UserID = @id ORDER BY Reservations.DateAdded DESC";

                }
            }
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@rstatus", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@pstatus", ddlPaymentStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Reservations");
            lvReservations.DataSource = ds;
            lvReservations.DataBind();
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetReservations(txtSearch.Text);
    }

    protected void ddlPaymentStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetReservations(txtSearch.Text);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetReservations(txtSearch.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetReservations(txtSearch.Text);
    }

    protected void lvReservations_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpReservations.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetReservations(txtSearch.Text);
    }

    protected void lvReservations_DataBound(object sender, EventArgs e)
    {
        dpReservations.Visible = dpReservations.PageSize < dpReservations.TotalRowCount;
    }
}
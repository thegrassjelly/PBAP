using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Admin_Reservations_ViewReservations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetReservations(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
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
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus,
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
                            UserLastName LIKE @keyword) ORDER BY Reservations.DateAdded DESC";
                }
                else
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus,
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
                            UserLastName LIKE @keyword) AND PaymentStatus = @pstatus ORDER BY Reservations.DateAdded DESC";
                }
            }
            else
            {
                if (ddlPaymentStatus.SelectedValue == "All Payments")
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus,
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
                            UserLastName LIKE @keyword) AND ReservationStatus = @rstatus ORDER BY Reservations.DateAdded DESC";

                }
                else
                {
                    cmd.CommandText = @"SELECT ReservationID, SeminarCode, SeminarTitle, ReservationStatus,
                            PaymentStatus,
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
                            ORDER BY Reservations.DateAdded DESC";

                }
            }

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

    protected void ddlPaymentStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetReservations(txtSearch.Text);
    }
}
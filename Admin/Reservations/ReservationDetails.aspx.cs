using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Reservations_ReservationDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int reservationID = 0;
        bool validReservation = int.TryParse(Request.QueryString["ID"], out reservationID);

        if (validReservation)
        {
            if (!IsPostBack)
            {
                GetUserInfo(reservationID);
                GetReservationInfo(reservationID);
                GetPaymentInfo(reservationID);
            }
        }
    }

    private void GetPaymentInfo(int reservationID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT Reservations.PaymentID, SubscriptionID, PaymentAmount,
                PaymentDate, PaymentStatus, PaymentType FROM Reservations
                INNER JOIN Payments ON Reservations.PaymentID = Payments.PaymentID
                WHERE ReservationID = @id";
            cmd.Parameters.AddWithValue("@id", reservationID);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtPayID.Text = dr["PaymentID"].ToString();
                        txtSID.Text = dr["SubscriptionID"].ToString();
                        txtPaymentAmount.Text = dr["PaymentAmount"].ToString();
                        ddlPayStatus.SelectedValue = dr["PaymentStatus"].ToString();

                        if (dr["PaymentStatus"].ToString() == "Paid")
                        {
                            DateTime PayDate = DateTime.Parse(dr["PaymentDate"].ToString());
                            txtPaymentDate.Text = PayDate.ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            DateTime PayDate = DateTime.Now;
                            txtPaymentDate.Text = PayDate.ToString("yyyy-MM-dd");
                        }

                        ddlPayType.SelectedValue = dr["PaymentType"].ToString();
                    }
                }
            }
        }
    }

    private void GetReservationInfo(int reservationID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT Reservations.SeminarID, SeminarCode, SeminarTitle, SeminarArea,
                            SeminarUnits, SeminarFee, SeminarLocation, SeminarDate, SeminarSpeaker,
                            SeminarDescription,
                            SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN AS SpeakerName,
                            ReservationStatus, Reservations.DateAdded AS RDate, Seminars.DateAdded FROM Reservations
                            INNER JOIN Seminars ON Seminars.SeminarID = Reservations.SeminarID
                            INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                            WHERE ReservationID= @id";
            cmd.Parameters.AddWithValue("@id", reservationID);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtID.Text = dr["SeminarID"].ToString();
                        txtCode.Text = dr["SeminarCode"].ToString();
                        txtTitle.Text = dr["SeminarTitle"].ToString();
                        txtDesc.Text = dr["SeminarDescription"].ToString();
                        txtSpeaker.Text = dr["SpeakerName"].ToString();
                        txtCompt.Text = dr["SeminarArea"].ToString();
                        txtUnits.Text = dr["SeminarUnits"].ToString();
                        txtFee.Text = dr["SeminarFee"].ToString();
                        txtLocation.Text = dr["SeminarLocation"].ToString();
                        DateTime SeminarDate = DateTime.Parse(dr["SeminarDate"].ToString());
                        txtDate.Text = SeminarDate.ToString("yyyy-MM-dd");
                        DateTime DAdded = DateTime.Parse(dr["DateAdded"].ToString());
                        txtDAdded.Text = DAdded.ToString("yyyy-MM-dd");
                        DateTime RDate = DateTime.Parse(dr["RDate"].ToString());
                        txtRDate.Text = RDate.ToString("yyyy-MM-dd");
                        ddlRStatus.SelectedValue = dr["ReservationStatus"].ToString();
                    }
                }
            }
        }
    }

    void GetUserInfo(int reservationID)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT Users.UserID, UserFirstName, UserMidName, UserLastName,
                UserCompany, UserPosition, UserEmail, UserFaxNo, UserTelNo, UserMobileNo, UserAddress,
                UserBday, UserStatus, UserType FROM Reservations
                INNER JOIN Users ON Users.UserID = Reservations.UserID                
                WHERE ReservationID = @id";
            cmd.Parameters.AddWithValue("@id", reservationID);
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

    protected void btnUpdateRStatus_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Reservations SET ReservationStatus = @status
                WHERE ReservationID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@status", ddlRStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        GetUserInfo(int.Parse(Request.QueryString["ID"]));
        GetReservationInfo(int.Parse(Request.QueryString["ID"]));
        GetPaymentInfo(int.Parse(Request.QueryString["ID"]));
        upsuccess.Visible = true;
    }

    protected void btnUpdatePayStatus_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Payments SET PaymentStatus = @status, PaymentDate = @date
                FROM Payments INNER JOIN Reservations ON Payments.PaymentID = Reservations.PaymentID
                WHERE ReservationID = @id";
            cmd.Parameters.AddWithValue("@date", txtPaymentDate.Text);
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@status", ddlPayStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        GetUserInfo(int.Parse(Request.QueryString["ID"]));
        GetReservationInfo(int.Parse(Request.QueryString["ID"]));
        GetPaymentInfo(int.Parse(Request.QueryString["ID"]));
        paysuccess.Visible = true;
    }
}
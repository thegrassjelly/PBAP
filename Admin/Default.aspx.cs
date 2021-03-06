﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

public partial class Admin_Default : System.Web.UI.Page
{
    static DateTime _sDate;
    static DateTime _eDate;
    static string _dSDate;
    static string _dEDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();
        if (!IsPostBack)
        {
            GetMonthly();
            GetDaily();

            GetReservationsCount();
            GetPendingReservationsCount();
            GetUnpaidReservations();
            GetTotalUsers();

            GetDReservationsCount();
            GetDPendingReservationsCount();
            GetDUnpaidReservations();
            GetDTotalUsers();

            GetTopReserved();
        }
    }

    private void GetTopReserved()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT DISTINCT TOP 4 COUNT(Reservations.SeminarID) AS TotalCount, SeminarTitle, SeminarArea,
                (SeminarSpeakerTitle + ' ' + SeminarSpeakerFN + ' ' + SeminarSpeakerLN) AS SpeakerName 
                FROM Reservations
                INNER JOIN Seminars ON Reservations.SeminarID = Seminars.SeminarID
                INNER JOIN SeminarSpeakers ON Seminars.SeminarSpeaker = SeminarSpeakers.SeminarSpeakerID
                GROUP BY SeminarTitle, SeminarArea, SeminarSpeakerTitle, SeminarSpeakerFN, SeminarSpeakerLN
                ORDER BY TotalCount DESC";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "InventoryMovement");
            lvTopSales.DataSource = ds;
            lvTopSales.DataBind();
        }
    }

    private void GetDaily()
    {
        DateTime now = Helper.PHTime();
        var startDate = new DateTime(now.Year, now.Month, now.Day);
        var endDate = startDate.AddDays(1).AddMinutes(-1);
         
         _dSDate = startDate.ToString();
         _dEDate = endDate.ToString();

        ltToday.Text = startDate.ToString("MMMM dd", CultureInfo.InvariantCulture);
        ltToday2.Text = startDate.ToString("MMMM dd", CultureInfo.InvariantCulture);
        ltToday3.Text = startDate.ToString("MMMM dd", CultureInfo.InvariantCulture);
        ltToday4.Text = startDate.ToString("MMMM dd", CultureInfo.InvariantCulture);
    }

    private void GetMonthly()
    {
        DateTime now = Helper.PHTime();
        var startDate = new DateTime(now.Year, now.Month, 1);
        var endDate = startDate.AddMonths(1).AddDays(-1);

        _sDate = startDate;
        _eDate = endDate;

        ltCurrentMonth.Text = startDate.ToString("MMMM", CultureInfo.InvariantCulture);
        ltCurrentMonth2.Text = startDate.ToString("MMMM", CultureInfo.InvariantCulture);
        ltCurrentMonth3.Text = startDate.ToString("MMMM", CultureInfo.InvariantCulture);
        ltMonth4.Text = startDate.ToString("MMMM", CultureInfo.InvariantCulture);
    }

    private void GetUnpaidReservations()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SUM(PaymentAmount) AS TotalAmnt FROM
                Payments 
                INNER JOIN Reservations ON Payments.PaymentID = Reservations.PaymentID
                WHERE DateAdded BETWEEN @sdate AND @edate AND
                PaymentStatus = 'Unpaid'";
            cmd.Parameters.AddWithValue("@sdate", _sDate);
            cmd.Parameters.AddWithValue("@edate", _eDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltUnpaidRes.Text = string.Format("{0: ₱ #,###.00}", dr["TotalAmnt"]);
                    }
                }
            }
        }
    }

    private void GetPendingReservationsCount()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(ReservationID) AS RCount FROM
                Reservations WHERE DateAdded BETWEEN @sdate AND @edate AND
                ReservationStatus = 'Pending'";
            cmd.Parameters.AddWithValue("@sdate", _sDate);
            cmd.Parameters.AddWithValue("@edate", _eDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltPendingRCount.Text = dr["RCount"].ToString();
                    }
                }
            }
        }
    }

    private void GetReservationsCount()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(ReservationID) AS RCount FROM
                Reservations WHERE DateAdded BETWEEN @sdate AND @edate";
            cmd.Parameters.AddWithValue("@sdate", _sDate);
            cmd.Parameters.AddWithValue("@edate", _eDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltRCount.Text = dr["RCount"].ToString();
                    }
                }
            }
        }
    }

    private void GetTotalUsers()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(UserID) AS UserCount FROM Users
                WHERE UserType = 'User' AND DateAdded BETWEEN @sdate AND @edate";
            cmd.Parameters.AddWithValue("@sdate", _sDate);
            cmd.Parameters.AddWithValue("@edate", _eDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltUsers.Text = dr["UserCount"].ToString();
                    }
                }
            }
        }
    }

    private void GetDUnpaidReservations()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ISNULL(SUM(PaymentAmount), 0) AS TotalAmnt FROM
                Payments 
                INNER JOIN Reservations ON Payments.PaymentID = Reservations.PaymentID
                WHERE DateAdded BETWEEN @sdate AND @edate AND
                PaymentStatus = 'Unpaid'";
            cmd.Parameters.AddWithValue("@sdate", _dSDate);
            cmd.Parameters.AddWithValue("@edate", _dEDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltDailyUnpaidRes.Text = string.Format("{0: ₱ #,###.00}", dr["TotalAmnt"]);
                    }
                }
            }
        }
    }

    private void GetDPendingReservationsCount()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(ReservationID) AS RCount FROM
                Reservations WHERE DateAdded BETWEEN @sdate AND @edate AND
                ReservationStatus = 'Pending'";
            cmd.Parameters.AddWithValue("@sdate", _dSDate);
            cmd.Parameters.AddWithValue("@edate", _dEDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltDailyPendingRCount.Text = dr["RCount"].ToString();
                    }
                }
            }
        }
    }

    private void GetDReservationsCount()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(ReservationID) AS RCount FROM
                Reservations WHERE DateAdded BETWEEN @sdate AND @edate";
            cmd.Parameters.AddWithValue("@sdate", _dSDate);
            cmd.Parameters.AddWithValue("@edate", _dEDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltDailyRCount.Text = dr["RCount"].ToString();
                    }
                }
            }
        }
    }

    private void GetDTotalUsers()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT COUNT(UserID) AS UserCount FROM Users
                WHERE UserType = 'User' AND DateAdded BETWEEN @sdate AND @edate";
            cmd.Parameters.AddWithValue("@sdate", _dSDate);
            cmd.Parameters.AddWithValue("@edate", _dEDate);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        ltDailyUserCount.Text = dr["UserCount"].ToString();
                    }
                }
            }
        }
    }

    protected void tmrDaily_Tick(object sender, EventArgs e)
    {
        GetDReservationsCount();
        GetDPendingReservationsCount();
        GetDUnpaidReservations();
        GetDTotalUsers();
    }

    protected void tmrTopReserved_Tick(object sender, EventArgs e)
    {
        GetTopReserved();
    }
}
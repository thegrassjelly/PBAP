using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
    public Helper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetCon()
    {
        return ConfigurationManager.ConnectionStrings["MyCon"].ConnectionString;
    }

    public static string CreateSHAHash(string Phrase)
    {
        SHA512Managed HashTool = new SHA512Managed();
        Byte[] PhraseAsByte = System.Text.Encoding.UTF8.GetBytes(string.Concat(Phrase));
        Byte[] EncryptedBytes = HashTool.ComputeHash(PhraseAsByte);
        HashTool.Clear();
        return Convert.ToBase64String(EncryptedBytes);
    }

    public static void ValidateAdmin()
    {
        //user not logged in
        if (HttpContext.Current.Session["userid"] == null)
        {
            HttpContext.Current.Response.Redirect("~/Admin/Login.aspx");
        }
    }

    public static void ValidateUser()
    {
        //user not logged in
        if (HttpContext.Current.Session["userid"] == null)
        {
            HttpContext.Current.Response.Redirect("~/User/Login.aspx");
        }
    }
}
using System;
using Entities;
using System.IO;
using System.Net;
using System.Web;
using System.Text;
using System.Net.Mail;

namespace Tools
{
    public class Mailing
    {

        public static string CreateBody(string[] parameters, string[] paramvalues)
        {
            string body = string.Empty;
            for (int i = 0; i < parameters.Length; i++)
            {
                string padding = "padding: 0px 20px"; if (i == 0) { padding = "padding: 10px 20px 0px 20px"; }
                body +=  "<tr>" +
                   "<td style=\"" + padding + "\">" +
                       "<p style=\"line-height:30px;padding: 0;margin: 0 0 10px 0;\">" +
                           "<span style=\"font-size: 15px; font-family:Gotham Light;color:#0d0d0d;font-weight:bold;\">" + parameters[i].ToString() + "</span>" +
                           "<span style=\"font-size: 15px; font-family:Gotham Light;color:#0d0d0d\"><br/>" + paramvalues[i].ToString() + "</span>" +
                        "</p>" +
                    "</td>" +
                "</tr>";
            }
            return body;
        }
        //---------------------------------------------------------

        public static string CreateTemplate(string PageTitle, string Content)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/raven/assets/standart.html"))) { body = reader.ReadToEnd(); }
            body = body.Replace("{PageTitle}", PageTitle);
            body = body.Replace("{CompanyName}", Entities.StaticList.Settings.CompanyName);
            body = body.Replace("{Content}", Content);
            return body;
        }
        //---------------------------------------------------------

        public static string CreateCustomerTemplate(string PageTitle, string Content)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/assets/mailing/standart.html"))) { body = reader.ReadToEnd(); }
            body = body.Replace("{PageTitle}", PageTitle);
            body = body.Replace("{CompanyName}", Entities.StaticList.Settings.CompanyName);
            body = body.Replace("{Content}", Content);
            return body;
        }
        //---------------------------------------------------------

        public static string MailStyle(string className, string styleName, string styleProp)
        {
            string geridonenveri = "<style type=\"text/css\">";
            geridonenveri += className + "{" + styleName + ": " + styleProp + ";\n}";
            return geridonenveri + "</style>";
        }
        //---------------------------------------------------------

        public static bool SendbySMTP(string alici, string konu, string icerik)
        {
            try
            {
                MailMessage msg = new MailMessage();
                bool geridonenveri = true;
                //---------------------------------------------------------
                msg.To.Add(alici.ToString());
                msg.From = new MailAddress(StaticList.Settings.EmailSenderName + "<" + StaticList.Settings.EmailUsername + ">");
                msg.Subject = konu;
                //---------------------------------------------------------
                string shtml = "";
                shtml += MailStyle("body", "font-size", "12px");
                shtml += MailStyle("table", "font-size", "12px");
                shtml += MailStyle("a", "color", "#1567ba");
                shtml += MailStyle("a:hover", "color", "#87c2ff");
                //---------------------------------------------------------
                msg.Body = (shtml + icerik + "<p>" + StaticList.Settings.EmailSign) + "</p>";
                msg.IsBodyHtml = true;
                msg.BodyEncoding = Encoding.GetEncoding(1254);
                //---------------------------------------------------------
                SmtpClient client = new SmtpClient(StaticList.Settings.EmailSmtpHost, Convert.ToInt32(StaticList.Settings.EmailSmtpPort));
                client.Credentials = new NetworkCredential(StaticList.Settings.EmailUsername, StaticList.Settings.EmailPassword);
                client.EnableSsl = true;
                client.Send(msg);
                //---------------------------------------------------------
                return geridonenveri;
            }
            catch { return false; }
        }
        //---------------------------------------------------------

    }
}

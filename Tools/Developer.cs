using System;
using System.Web;
using Utility;
using System.Collections;
using System.Collections.Generic;
using Entities;
using System.Linq;
using Entities.Items;

namespace Tools
{
    public class Developer
    {
        #region Login

        public static Entities.Items.TokenID UserToken(string TokenID)
        {
            Entities.Items.TokenID data = new Entities.Items.TokenID { UserID = 0 };
            try
            {

                if (String.IsNullOrEmpty(TokenID))
                {
                    HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
                    if (RavenCookies != null)
                        TokenID = RavenCookies.Values["RavenID"];
                }
                //---------------------------------------------------------
                ArrayList myAl = Helper.SplitedList("~", StringCipher.Decrypt(TokenID));
                if (myAl.Count > 0)
                {
                    data.UserID = Convert.ToInt32(myAl[0].ToString());
                    data.Statu = Convert.ToInt32(myAl[1].ToString());
                    data._Statu = Bll.zUsersStatu.Select(Convert.ToInt32(myAl[1].ToString()), "")[0].Title;
                    data.Email = myAl[2].ToString();
                    data.Password = myAl[3].ToString();
                    data.CreatedDate = DateTime.Now;
                }
                //---------------------------------------------------------
                List<Entities.zUsers> dList = Bll.zUsers.Select(0, " AND Email='" + data.Email + "' AND Password='" + StringCipher.MD5Encrypt(data.Password) + "'");
                //---------------------------------------------------------
                if (dList.Count < 1) { data.UserID = 0; }
                //---------------------------------------------------------
                return data;
            }
            catch { return data; }
        }
        //--------------------------------------------------------- giriş yapılan token bilgisi doğru mu 

        public static Entities.zUsers LoggedUser()
        {
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies == null)
            {
                HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                return new Entities.zUsers { id = 0, CatID = 0 };
            }
            else
            {
                Entities.Items.TokenID Token = UserToken(RavenCookies.Values["RavenID"].ToString());
                List<Entities.zUsers> dList = Bll.zUsers.Select(0, " AND Statu<5 AND id=" + Token.UserID + " AND Approved=1");
                if (dList.Count > 0)
                    return dList[0];
                else
                {
                    HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                    return new Entities.zUsers { id = 0, CatID = 0 };
                }
            }
        }
        //--------------------------------------------------------- giriş yapan kullanıcı bilgisi

        public static Entities.zUsers LoggedPartner(bool redirect = true)
        {
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies == null)
            {
                if (redirect)
                {
                    HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                    return new Entities.zUsers { id = 0, CatID = 0 };
                }
                else
                    return new Entities.zUsers { id = 0, CatID = 0 };
            }
            else
            {
                Entities.Items.TokenID Token = UserToken(RavenCookies.Values["RavenID"].ToString());
                List<Entities.zUsers> dList = Bll.zUsers.Select(0, " AND Statu=5 AND id=" + Token.UserID + " AND Approved=1");
                if (dList.Count > 0)
                    return dList[0];
                else
                {
                    if (redirect)
                    {
                        HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                        return new Entities.zUsers { id = 0, CatID = 0 };
                    }
                    else
                        return new Entities.zUsers { id = 0, CatID = 0 };
                }
            }
        }
        //--------------------------------------------------------- giriş yapan acenta bilgisi

        public static bool CheckLogin(string Auth, int PageID)
        {
            bool result = false;
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies == null)
            {
                HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                result = false;
            }
            //---------------------------------------------------------
            else
            {
                Entities.Items.TokenID Token = UserToken(RavenCookies.Values["RavenID"].ToString());
                List<Entities.zUsers> dList = Bll.zUsers.Select(0, " AND id=" + Token.UserID + " AND Approved=1");
                if (dList.Count > 0)
                    if (CheckUserAuth(Token.Statu, Auth, PageID) == false)
                        HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                    else
                        return true;
                else
                {
                    HttpContext.Current.Response.Redirect(ConstantUrl("logout"));
                    return false;
                }
            }
            return result;
        }
        //--------------------------------------------------------- id ve dil kodu verilen bilginin karşılığını databaseden getirir.

        protected static bool CheckUserAuth(int Statu, string Auth, int PageID)
        {
            bool returningValue = false;
            Entities.Items.UserAccess canAccess = GetUserStatu(Statu);
            //---------------------------------------------------------
            List<Entities.zMenus> dList = Bll.zMenus.Select(0, " AND id=" + PageID + " AND Approved=1");
            foreach (var item in dList)
            {
                switch (Auth)
                {
                    case "Developer":
                        if (Convert.ToBoolean(item.canDeveloper))
                            if (Convert.ToBoolean(canAccess.Developer))
                                returningValue = true;
                        break;
                    case "Admin":
                        if (Convert.ToBoolean(item.canAdmin))
                            if (Convert.ToBoolean(canAccess.Admin))
                                returningValue = true;
                        break;
                    case "Editor":
                        if (Convert.ToBoolean(item.canEditor))
                            if (Convert.ToBoolean(canAccess.Editor))
                                returningValue = true;
                        break;
                    case "Sales":
                        if (Convert.ToBoolean(item.canSales))
                            if (Convert.ToBoolean(canAccess.Sales))
                                returningValue = true;
                        break;
                    case "Agency":
                        if (Convert.ToBoolean(item.canAgency))
                            if (Convert.ToBoolean(canAccess.Agency))
                                returningValue = true;
                        break;
                    default:
                        returningValue = true;
                        break;
                }
            }
            //---------------------------------------------------------
            return returningValue;
        }
        //--------------------------------------------------------- kullanıcı ilgili panel/sayfaya erişebilir mi?

        protected static Entities.Items.UserAccess GetUserStatu(int AuthID)
        {
            Entities.Items.UserAccess data = new Entities.Items.UserAccess { Developer = false, Admin = false, Sales = false, Editor = false };
            //---------------------------------------------------------
            List<Entities.zUsersStatu> dList = Bll.zUsersStatu.Select(0, " AND id=" + AuthID + " AND Approved=1");
            foreach (var item in dList)
            {
                data.Developer = Convert.ToBoolean(item.Developer);
                data.Admin = Convert.ToBoolean(item.Admin);
                data.Editor = Convert.ToBoolean(item.Editor);
                data.Sales = Convert.ToBoolean(item.Sales);
                data.Agency = Convert.ToBoolean(item.Agency);
            }
            return data;
        }
        //--------------------------------------------------------- id bilgisi verilen kullanıcının istenilen statu karşılığını databaseden getirir.

        #endregion

        #region Listing HTML

        public static string DeleteFileButton(string path, string field, string filename)
        { return "<a href='javascript:;' title='Sil' class='btn btn-delete-file btn-secondary btn-sm' data-path='" + path + "' data-field='" + field + "' data-value='" + filename + "'>" + Language.GetFixed("DosyaSil") + "</a>"; }
        //---------------------------------------------------------

        public static string ShowAgencyImage(string filename) { return "<a href=\"" + Feature.AgencyFolder + filename + "\" data-fancybox><img src=\"" + Feature.AgencyFolder + filename + "\" style=\"padding:2px;width: 50px;border-radius: 8px;\" border=\"0\"></a>"; }
        //---------------------------------------------------------

        public static string ShowAgencyFile(string filename) { return "<a href=\"" + Feature.AgencyFolder + filename + "\" target=\"_blank\">" + Language.GetFixed("DosyayiGor") + "</a>"; }
        //---------------------------------------------------------

        public static string ShowImage(string filename) { return "<a href=\"" + Feature.ImageFolder + filename + "\" data-fancybox><img src=\"" + Feature.ImageFolder + filename + "\" style=\"padding:2px;width: 50px;border-radius: 8px;\" border=\"0\"></a>"; }
        //---------------------------------------------------------

        public static string ShowFile(string filename) { return "<a href=\"" + Feature.FileFolder + filename + "\" target=\"_blank\">" + Language.GetFixed("DosyayiGor") + "</a>"; }
        //---------------------------------------------------------

        public static string ShowReportFile(string filename) { return "<a href=\"" + Feature.ReportFileFolder + filename + "\" target=\"_blank\">" + Language.GetFixed("DosyayiGor") + "</a>"; }
        //---------------------------------------------------------

        public static string ShowLink(string filename) { return "<a href=\"" + filename + "\" target=\"_blank\">" + Language.GetFixed("DosyayiGor") + "</a>"; }
        //---------------------------------------------------------

        public static string ShowVideos(string video, string image)
        {
            return "<a href=\"" + video + "\" data-fancybox><img src=\"" + Feature.ImageFolder + image + "\" style=\"padding:2px;width: 50px;border-radius: 8px;\" border=\"0\"></a>";
        }
        //---------------------------------------------------------


        #endregion

        #region General 

        public static int CalcuatePercantage(int x, int y)
        {
            try
            {
                return Convert.ToInt32((Convert.ToDouble(x) / Convert.ToDouble(y)) * 100);
            }
            catch { return 0; }
        }
        //---------------------------------------------------------

        public static bool HasSubMenu(int CategoryID)
        {
            List<Entities.GeneralCategories> dList = StaticList.Categories.Where(x => (x.CatID == CategoryID)).ToList();
            if (dList.Count > 0) { return true; } else { return false; }
        }
        //--------------------------------------------------------- kategoriye ait alt kategori var mı?

        public static string ConstantUrl(string incomingStatu)
        {
            switch (incomingStatu)
            {
                case "login":
                    return "/raven/";
                case "logout":
                    return "/raven/logout";
                case "dashboard":
                    return "/raven/dashboard";
                case "category":
                    return "/raven/category-management";
                case "content":
                    return "/raven/content-management";
                case "gallery":
                    return "/raven/content-gallery";
                case "files":
                    return "/raven/content-files";
                case "videos":
                    return "/raven/content-videos";
                case "features":
                    return "/raven/content-features";
                case "plans":
                    return "/raven/content-plans";
                case "cat-languages":
                    return "/raven/category-languages";
                case "con-languages":
                    return "/raven/content-languages";
                case "inbox":
                    return "/raven/inbox";
                case "defines":
                    return "/raven/defines";
                case "doptions":
                    return "/raven/define-options";
                case "agency":
                    return "/raven/agency-list";
                case "brokers":
                    return "/raven/brokers";
                case "callback":
                    return "/raven/agency-callbacks";
                case "inspections":
                    return "/raven/inspection-list";
                case "attendees":
                    return "/raven/attendees";
                case "preview":
                    return "/raven/preview";
                case "customers":
                    return "/raven/customer-list";
                case "summaries":
                    return "/raven/summaries";
                case "leads":
                    return "/raven/leads";
                case "cfiles":
                    return "/raven/customer-files";
                case "reservations":
                    return "/raven/reservations";
                case "rfeatures":
                    return "/raven/reservation-features";
                case "rfiles":
                    return "/raven/reservation-files";
                case "sales":
                    return "/raven/sale-transactions";
                case "resreports":
                    return "/raven/reservation-reports";
                case "partner":
                    return "/partner";
                case "pagency":
                    return "/partner/agencies";
                case "pprojects":
                    return "/partner/projects";
                case "pstatus":
                    return "/partner/projects-status";
                case "pinspection":
                    return "/partner/inspections?type=0";
                case "ppview":
                    return "/partner/property-views?type=1";
                case "pcustomers":
                    return "/partner/customers";
                case "pmarket":
                    return "/partner/market-insights";
                case "pcalendar":
                    return "/partner/agency-calendar";
                case "passignments":
                    return "/partner/assignments";
                case "preservations":
                    return "/partner/agency-reservations";
                case "pdaily":
                    return "/partner/daily";
                case "ppresentation":
                    return "/partner/presentation";
                case "pdocuments":
                    return "/partner/documents";
                case "pannouncements":
                    return "/partner/announcements";
                case "psummaries":
                    return "/partner/agency-summaries";
                case "pprofile":
                    return "/partner/my-profile";
                case "pleads":
                    return "/partner/agency-leads";
                default:
                    return "";
            }
        }
        //---------------------------------------------------------

        public static bool isChecked(object value)
        {
            bool geriDon; int deger = Convert.ToInt32(value);
            if (deger == 1) { geriDon = true; }
            else { geriDon = false; }
            return geriDon;
        }
        //---------------------------------------------------------

        #endregion

        #region AuditLog

        public static void WriteLog(int type, string message, string datalist, int userID)
        {
            List<Entities.LogRecords> dList = new List<Entities.LogRecords>  {
                new Entities.LogRecords
                {
                    TypeID = type,
                    Description = message,
                    Datastring = StringCipher.Encrypt(datalist),
                    IPNumber = HttpContext.Current.Request.ServerVariables["remote_addr"].ToString(),
                    CreatedUser = Convert.ToInt32(userID),
                    CreatedDate = DateTime.Now
                }
            };
            //---------------------------------------------------------
            foreach (var item in dList) { item.Save(); }
        }
        //---------------------------------------------------------

        public static string LogType(int TypeID)
        {
            switch (TypeID)
            {
                case 1:
                    return "Login";
                case 2:
                    return "Logout";
                case 3:
                    return "Insert";
                case 4:
                    return "Update";
                case 5:
                    return "Delete";
                case 6:
                    return "Delete File";
                case 7:
                    return "List Update";
                default:
                    return "Other";
            }
        }
        //---------------------------------------------------------

        public static string LogColor(int TypeID)
        {
            switch (TypeID)
            {
                case 1:
                    return "default";
                case 2:
                    return "default";
                case 3:
                    return "success";
                case 4:
                    return "warning";
                case 5:
                    return "danger";
                case 6:
                    return "danger";
                case 7:
                    return "warning";
                default:
                    return "secondary";
            }
        }
        //---------------------------------------------------------

        public static string LogDescription(int TypeID)
        {
            switch (TypeID)
            {
                case 1:
                    return "Kullanıcı giriş yapıldı.";
                case 2:
                    return "Kullanıcı çıkışı yapıldı.";
                case 3:
                    return "Yeni kayıt eklendi.";
                case 4:
                    return "İlgili kayıt güncellendi.";
                case 5:
                    return "İlgili kayıt silindi.";
                case 6:
                    return "Liste verileri güncellendi.";
                default:
                    return "Diğer";
            }
        }
        //---------------------------------------------------------

        #endregion
    }
}
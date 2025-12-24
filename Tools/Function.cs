using System;
using Utility;
using Entities;
using System.Data;
using Newtonsoft.Json;
using System.Collections;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Tools
{
    public class Function
    {
        #region Crop Detail

        static string SetCropSQL(int i, int PageTypeID, int CatID, int RecordID)
        {
            string sqlCommant = "";
            switch (i)
            {
                case 0:
                    sqlCommant = " AND PageTypeID=" + PageTypeID + " AND CatID=" + CatID + " AND RecordID=" + RecordID + "";
                    break;
                case 1:
                    sqlCommant = " AND PageTypeID=" + PageTypeID + " AND CatID=" + CatID + "";
                    break;
                case 2:
                    sqlCommant = " AND PageTypeID=" + PageTypeID + "";
                    break;
                default:
                    sqlCommant = " AND id=1";
                    break;
            }
            return sqlCommant;
        }
        //--------------------------------------------------------- resim croplamak için uygun sql'i getiren fonksiyon

        public static string CroppingDetail(string field, int PageTypeID, int CatID, int RecordID)
        {
            string returningValue = "";
            for (int i = 0; i < 4; i++)
            {
                DataTable dt = Bll.zPhotoSettings.GetDataTable("SELECT " + field + " FROM " + Entities.zPhotoSettings.tableName + " WHERE Approved=1" + SetCropSQL(i, PageTypeID, CatID, RecordID), CommandType.Text, null, null);
                //-----------------------------------------------
                if (dt.Rows.Count > 0) { returningValue = dt.Rows[0][field].ToString(); }
                //-----------------------------------------------
            }
            return returningValue;
        }
        //--------------------------------------------------------- croplamak için ilgili kayıtın crop boyutunu getiren fonksiyon

        #endregion

        #region String Replace

        public static int ClearUploadSql(string incomingData)
        {
            int isDataOK = 0;
            if (incomingData != null)
            {
                incomingData = incomingData.ToLowerInvariant();
                if (incomingData.IndexOf("asp") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("aspx") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("php") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("css") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("js") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("html") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("cgi") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("xml") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("jsp") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("exe") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf("cer") != -1)
                    isDataOK = 1;
                else if (incomingData.IndexOf(";") != -1)
                    isDataOK = 1;
                //---------------------------------------------------------
                if (Convert.ToInt32(incomingData.ToString().Split('.').Length) > 2)
                    isDataOK = 1;
            }
            return isDataOK;
        }
        //---------------------------------------------------------

        public static string SeoReplace(string incomingData)
        {
            if (incomingData != null)
            {
                incomingData = incomingData.Trim();
                string gvCopy = incomingData.ToLowerInvariant().Trim();
                string[,] arr = new string[,]
                {
                { ".", "-" },{ "_", "-" },{ ",", "-" },{ "'", "-" },{ ":", "" },{ "%27", "" },{ "?", "" },{ "*", "" },{ "&#199;", "o" },{ "&#246;", "o" },{ "&#214;", "o" },{ "&#252;", "u" },{ "&#220;", "u" },{ "&#231;", "c" },{ "&#174;", "®" },{ "&amp;", "-" },{ "&nbsp;", "-" },{ " ", "-" },{ ";", "-" },{ "%20", "-" },{ "/", "-" },{ ".", "" },{ "ç", "c" },{ "Ç", "c" },{ "ğ", "g" },{ "Ğ", "g" },{ "İ", "i" },{ "I", "i" },{ "ı", "i" },{ "ö", "o" },{ "Ö", "o" },{ "ş", "s" },{ "Ş", "s" },{ "ü", "u" },{ "Ü", "u" },{ ".", "" },{ "’", "" },{ "'", "" },{ "(", "-" },{ ")", "-" },{ "/", "-" },{ "<", "-" },{ ">", "-" },{ "\"", "-" },{ "\\", "-" },{ "{", "-" },{ "}", "-" },{ "%", "-" },{ "&", "-" },{ "+", "-" },{ "//", "-" },{ "--", "-" },{ "³", "-" },{ "²", "2" },{ "“", null },{ "”", null },{ "’", null },{ "”", null },{ "&", "-" },{ "[^\\w]", "-" },{ "----", "-" },{ "---", "-" },{ "--", "-" },{ "[", "-" },{ "]", "-" },{ "½", "-" },{ "^", "-" },{ "~", "-" },{ "|", "-" },{ "*", "-" },{ "#", "-" },{ "%", "-" },{ "union", "" },{ "select", "" },{ "update", "" },{ "insert", "" },{ "delete", "" },{ "drop", "" },{ "into", "" },{ "where", "" },{ "order", "" },{ "chr", "" },{ "isnull", "" },{ "xtype", "" },{ "sysobject", "" },{ "syscolumns", "" },{ "convert", "" },{ "db_name", "" },{ "@@", "-" },{ "@var", "-" },{ "declare", "" },{ "execute", "" },{ "having", "" },{ "1=1", "-" },{ "exec", "" },{ "cmdshell", "" },{ "master", "" },{ "cmd", "-" },{ "xp_", "-" },{ "?", "" },{ "!", "" },{ ".", "" },{ "--", "-" }
                };
                int abc = -1;
                for (int i = 0; i < arr.Length / 2; i++)
                {
                    abc = gvCopy.IndexOf(arr[i, 0]);
                    if (abc > -1)
                    {
                    again:
                        incomingData = incomingData.Substring(0, abc) + arr[i, 1] + incomingData.Substring(abc + arr[i, 0].Length, incomingData.Length - abc - arr[i, 0].Length);
                        gvCopy = gvCopy.Substring(0, abc) + arr[i, 1] + gvCopy.Substring(abc + arr[i, 0].Length, gvCopy.Length - abc - arr[i, 0].Length);
                        abc = gvCopy.IndexOf(arr[i, 0]);
                        if (abc > -1) goto again;
                    }
                }
            }
            return incomingData.ToLowerInvariant().Trim();
        }
        //---------------------------------------------------------

        public static string ImageSeoReplace(string incomingData)
        {
            if (incomingData != null)
            {
                incomingData = incomingData.Trim();
                string gvCopy = incomingData.ToLowerInvariant().Trim();
                string[,] arr = new string[,]
                {
                { ".", "-" },{ "_", "-" },{ ",", "-" },{ "'", "-" },{ ":", "" },{ "%27", "" },{ "?", "" },{ "*", "" },{ "&#199;", "o" },{ "&#246;", "o" },{ "&#214;", "o" },{ "&#252;", "u" },{ "&#220;", "u" },{ "&#231;", "c" },{ "&#174;", "®" },{ "&amp;", "-" },{ "&nbsp;", "-" },{ " ", "-" },{ ";", "-" },{ "%20", "-" },{ "/", "-" },{ ".", "" },{ "ç", "c" },{ "Ç", "c" },{ "ğ", "g" },{ "Ğ", "g" },{ "İ", "i" },{ "I", "i" },{ "ı", "i" },{ "ö", "o" },{ "Ö", "o" },{ "ş", "s" },{ "Ş", "s" },{ "ü", "u" },{ "Ü", "u" },{ ".", "" },{ "’", "" },{ "'", "" },{ "(", "-" },{ ")", "-" },{ "/", "-" },{ "<", "-" },{ ">", "-" },{ "\"", "-" },{ "\\", "-" },{ "{", "-" },{ "}", "-" },{ "%", "-" },{ "&", "-" },{ "+", "-" },{ "//", "-" },{ "--", "-" },{ "³", "-" },{ "²", "2" },{ "“", null },{ "”", null },{ "’", null },{ "”", null },{ "&", "-" },{ "[^\\w]", "-" },{ "----", "-" },{ "---", "-" },{ "--", "-" },{ "[", "-" },{ "]", "-" },{ "½", "-" },{ "^", "-" },{ "~", "-" },{ "|", "-" },{ "*", "-" },{ "#", "-" },{ "%", "-" },{ "union", "" },{ "select", "" },{ "update", "" },{ "insert", "" },{ "delete", "" },{ "drop", "" },{ "into", "" },{ "where", "" },{ "order", "" },{ "chr", "" },{ "isnull", "" },{ "xtype", "" },{ "sysobject", "" },{ "syscolumns", "" },{ "convert", "" },{ "db_name", "" },{ "@@", "-" },{ "@var", "-" },{ "declare", "" },{ "execute", "" },{ "having", "" },{ "1=1", "-" },{ "exec", "" },{ "cmdshell", "" },{ "master", "" },{ "cmd", "-" },{ "xp_", "-" },{ "--", "-" }
                };
                int abc = -1;
                for (int i = 0; i < arr.Length / 2; i++)
                {
                    abc = gvCopy.IndexOf(arr[i, 0]);
                    if (abc > -1)
                    {
                    bastan:
                        incomingData = incomingData.Substring(0, abc) + arr[i, 1] + incomingData.Substring(abc + arr[i, 0].Length, incomingData.Length - abc - arr[i, 0].Length);
                        gvCopy = gvCopy.Substring(0, abc) + arr[i, 1] + gvCopy.Substring(abc + arr[i, 0].Length, gvCopy.Length - abc - arr[i, 0].Length);
                        abc = gvCopy.IndexOf(arr[i, 0]);
                        if (abc > -1) goto bastan;
                    }
                }
            }
            return incomingData.ToLowerInvariant().Trim();
        }
        //---------------------------------------------------------

        public static string RevertSeoString(string incomingData)
        {
            Regex reg = new Regex("[*'\",_&#^@]");
            return Utility.Helper.FirstLetterUppercase(reg.Replace(incomingData, " ")).Replace("-", " ");
        }
        //---------------------------------------------------------

        public static string TimeAgo(DateTime dateTime, string lang)
        {
            string result = "";
            var timeSpan = DateTime.Now.Subtract(dateTime);
            if (lang == "EN")
            {
                if (timeSpan <= TimeSpan.FromSeconds(60))
                { result = string.Format("{0} second ago", timeSpan.Seconds); }
                else if (timeSpan <= TimeSpan.FromMinutes(60))
                { result = timeSpan.Minutes > 1 ? String.Format("about {0} minute ago", timeSpan.Minutes) : "about a minute ago"; }
                else if (timeSpan <= TimeSpan.FromHours(24))
                { result = timeSpan.Hours > 1 ? String.Format("about {0} hour ago", timeSpan.Hours) : "about an hour ago"; }
                else if (timeSpan <= TimeSpan.FromDays(30))
                { result = timeSpan.Days > 1 ? String.Format("about {0} day ago", timeSpan.Days) : "yesterday"; }
                else if (timeSpan <= TimeSpan.FromDays(365))
                { result = timeSpan.Days > 30 ? String.Format("about {0} month ago", timeSpan.Days / 30) : "about a month ago"; }
                else
                { result = timeSpan.Days > 365 ? String.Format("about {0} year ago", timeSpan.Days / 365) : "about a year ago"; }
            }
            else if (lang == "TR")
            {
                if (timeSpan <= TimeSpan.FromSeconds(60))
                { result = string.Format("{0} saniye önce", timeSpan.Seconds); }
                else if (timeSpan <= TimeSpan.FromMinutes(60))
                { result = timeSpan.Minutes > 1 ? String.Format("yaklaşık {0} dakika önce", timeSpan.Minutes) : "yaklaşık bir dakika önce"; }
                else if (timeSpan <= TimeSpan.FromHours(24))
                { result = timeSpan.Hours > 1 ? String.Format("yaklaşık {0} saat önce", timeSpan.Hours) : "yaklaşık bir saat önce"; }
                else if (timeSpan <= TimeSpan.FromDays(30))
                { result = timeSpan.Days > 1 ? String.Format("{0} gün önce", timeSpan.Days) : "dün"; }
                else if (timeSpan <= TimeSpan.FromDays(365))
                { result = timeSpan.Days > 30 ? String.Format("{0} ay önce", timeSpan.Days / 30) : "bir ay önce"; }
                else
                { result = timeSpan.Days > 365 ? String.Format("{0} yıl önce", timeSpan.Days / 365) : "bir yıl önce"; }
            }
            else
            {
                if (timeSpan <= TimeSpan.FromSeconds(60))
                { result = string.Format("{0} saniye önce", timeSpan.Seconds); }
                else if (timeSpan <= TimeSpan.FromMinutes(60))
                { result = timeSpan.Minutes > 1 ? String.Format("yaklaşık {0} dakika önce", timeSpan.Minutes) : "yaklaşık bir dakika önce"; }
                else if (timeSpan <= TimeSpan.FromHours(24))
                { result = timeSpan.Hours > 1 ? String.Format("yaklaşık {0} saat önce", timeSpan.Hours) : "yaklaşık bir saat önce"; }
                else if (timeSpan <= TimeSpan.FromDays(30))
                { result = timeSpan.Days > 1 ? String.Format("yaklaşık {0} gün önce", timeSpan.Days) : "dün"; }
                else if (timeSpan <= TimeSpan.FromDays(365))
                { result = timeSpan.Days > 30 ? String.Format("yaklaşık {0} ay önce", timeSpan.Days / 30) : "yaklaşık bir ay önce"; }
                else
                { result = timeSpan.Days > 365 ? String.Format("yaklaşık {0} yıl önce", timeSpan.Days / 365) : "yaklaşık bir yıl önce"; }
            }

            return result;
        }
        //---------------------------------------------------------

        #endregion

        #region Random 

        public static string RandomNumber
        {
            get { return new Random().Next(100000, 999999).ToString(); }
        }
        //---------------------------------------------------------

        public static string Random()
        { return DateTime.Now.Day.ToString() + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Second + DateTime.Now.Minute + DateTime.Now.Millisecond; }
        //---------------------------------------------------------

        public static string RandomPassword()
        {
            string returningData = ""; string password = "";
            Random rnd = new Random();
            //---------------------------------------------------------
            int number = rnd.Next(1000, 9999);
            //---------------------------------------------------------
            for (int i = 0; i < 3; i++)
            {
                int ascii = rnd.Next(65, 91);
                char ch = Convert.ToChar(ascii);
                if (i % 2 == 0) { password += Utility.Helper.AllLetterLowercase(Convert.ToString(ch)); }
                else { password += Convert.ToString(ch); }
            }
            //---------------------------------------------------------
            returningData = Convert.ToString(password + "" + number);
            return returningData.ToLower();
        }
        //---------------------------------------------------------

        #endregion

        #region Return Messages 

        public static string ResultMessage(object list, int count, int rowCount, int currentpage, bool result, string message)
        {
            Entities.Items.ResultMessage data = new Entities.Items.ResultMessage();
            data.items = list;
            data.count = count;
            if (rowCount > 0) { data.hasPaging = true; } else { data.hasPaging = false; }
            data.currentPage = currentpage;
            data.rowCount = rowCount;
            data.message = message;
            data.result = result;
            return JsonConvert.SerializeObject(data);
        }
        //---------------------------------------------------------

        public static Entities.Items.ResultMessage ApiResultMessage(object list, int count, int rowCount, int currentpage, bool result, string message)
        {
            Entities.Items.ResultMessage data = new Entities.Items.ResultMessage();
            data.items = list;
            data.count = count;
            if (rowCount > 0) { data.hasPaging = true; } else { data.hasPaging = false; }
            data.currentPage = currentpage;
            data.rowCount = rowCount;
            data.message = message;
            data.result = result;
            return data;
        }
        //---------------------------------------------------------

        #endregion

        #region Generate

        public static string GeneratePNR(string Prefix)
        {
            string PnrNumber = Prefix + RandomNumber;
            switch (Prefix)
            {
                case "ISP":
                    if (Convert.ToInt32(Bll.Inspections.RowCount(" AND PNRCode='" + PnrNumber + "'", Entities.Inspections.tableName)) > 0)
                        GeneratePNR(Prefix);
                    break;
                case "PRV":
                    if (Convert.ToInt32(Bll.Inspections.RowCount(" AND PNRCode='" + PnrNumber + "'", Entities.Inspections.tableName)) > 0)
                        GeneratePNR(Prefix);
                    break;
                case "SUM":
                    if (Convert.ToInt32(Bll.InspectionSummaries.RowCount(" AND PNRCode='" + PnrNumber + "'", Entities.InspectionSummaries.tableName)) > 0)
                        GeneratePNR(Prefix);
                    break;
                case "RES":
                    if (Convert.ToInt32(Bll.Reservations.RowCount(" AND ReservationNumber='" + PnrNumber + "'", Entities.Reservations.tableName)) > 0)
                        GeneratePNR(Prefix);
                    break;
                case "SAL":
                    if (Convert.ToInt32(Bll.Reservations.RowCount(" AND SaleNumber='" + PnrNumber + "'", Entities.Reservations.tableName)) > 0)
                        GeneratePNR(Prefix);
                    break;
            }
            return PnrNumber;
        }
        //--------------------------------------------------------- uniq inspectin numarası oluştur

        #endregion

        #region Sisteme Özel Fonksiyonlar


        public static string GetReservationStatu(int Statu)
        {
            EnumValidate.Reservation status = (EnumValidate.Reservation)Statu;
            switch (status)
            {
                case EnumValidate.Reservation.pending:
                    return "Onay Bekliyor";
                case EnumValidate.Reservation.approved:
                    return "Onaylandı";
                case EnumValidate.Reservation.active:
                    return "Aktif";
                case EnumValidate.Reservation.done:
                    return "Tamamlandı";
                case EnumValidate.Reservation.cancelled:
                    return "İptal Edildi";
                default:
                    return "Ödeme Bekleniyor";
            }
        }
        //--------------------------------------------------------- reservasyon durumlarını getir

        public static string GetReservationStatuColor(int Statu)
        {
            EnumValidate.Reservation status = (EnumValidate.Reservation)Statu;
            switch (status)
            {
                case EnumValidate.Reservation.pending:
                    return "secondary";
                case EnumValidate.Reservation.approved:
                    return "primary";
                case EnumValidate.Reservation.active:
                    return "primary";
                case EnumValidate.Reservation.done:
                    return "success";
                case EnumValidate.Reservation.cancelled:
                    return "danger";
                default:
                    return "warning";
            }
        }
        //--------------------------------------------------------- reservasyon durumlarını getir

        public static bool IsValidAndOver21Years(string inputDate)
        {
            if (DateTime.TryParseExact(inputDate, "dd.MM.yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime date))
            {
                DateTime currentDate = DateTime.Now;
                int age = currentDate.Year - date.Year;
                if (currentDate.Month < date.Month || (currentDate.Month == date.Month && currentDate.Day < date.Day))
                    age--;
                //---------------------------------------------------------
                return age > 21;
            }
            return false;
        }
        //---------------------------------------------------------

        public static bool inList(ArrayList myList, int item)
        {
            bool hasItem = false;
            for (int i = 0; i < myList.Count; i++)
            {
                if (item == Convert.ToInt32(myList[i]))
                    hasItem = true;
            }
            return hasItem;
        }
        //--------------------------------------------------------- is option inside a list

        public static string PageLinks(int incomingStatu)
        {
            switch (incomingStatu)
            {
                case 1:
                    return "/bilgilerim";
                case 2:
                    return "/siparislerim";
                case 3:
                    return "/adreslerim";
                case 4:
                    return "/tercihlerim";
                case 5:
                    return "/cikis";
                default:
                    return "";
            }
        }
        //---------------------------------------------------------

        #endregion

        #region Ekstra işlemler

        public static void UpdateCallbackCount(string AgencyID)
        {
            List<Entities.Agencies> agencyList = Bll.Agencies.Select(0, filter: " AND id='" + AgencyID + "'");
            foreach (var item in agencyList)
            {
                item.CallbackCount = (item.CallbackCount + 1);
                item.Save();
            }
        }
        //---------------------------------------------------------

        public static void Update3DViewStatu(string PropertyID, string Status)
        {
            DataRow drItem = Connection.GetDataRow("SELECT * FROM item WHERE key2='" + PropertyID + "'");
            if (drItem != null)
            {
                string JSONString = drItem["object"].ToString();
                var jsonObject = JsonConvert.DeserializeObject<JObject>(JSONString);

                if (jsonObject.TryGetValue("status", out JToken statusToken))
                    jsonObject["status"] = Status;

                string NewJsonString = jsonObject.ToString();
                Connection.ExecuteQuery("UPDATE item SET object='" + NewJsonString + "' WHERE key2='" + PropertyID + "'");
            }
        }
        //---------------------------------------------------------

        public static void UpdateClients(string PNRCode, string Clients, string Budgets)
        {
            ArrayList myClients = Helper.SplitedList(",", Clients);
            ArrayList myBudgets = Helper.SplitedList(",", Budgets);
            ArrayList myAttends = new ArrayList();
            List<Entities.Inspections> insList = Bll.Inspections.Select(0, filter: " AND PNRCode='" + PNRCode + "'");

            #region add to Attendees
            for (int i = 0; i < myClients.Count; i++)
            {
                List<Entities.Attendees> newList = new List<Entities.Attendees>  {
                        new Entities.Attendees  {
                            InspectionNumber = PNRCode,
                            Fullname = myClients[i].ToString(),
                            Budget = myBudgets[i].ToString()
                        }
                    };
                foreach (var item in newList)
                {
                    object NewAttendID = item.Save();
                    myAttends.Add(NewAttendID.ToString());
                }
            }
            #endregion

            #region update inspection
            string myAttendees = "";
            for (int i = 0; i < myAttends.Count; i++)
            {
                myAttendees += myAttends[i].ToString() + ",";
            }
            myAttendees = Helper.DeleteLastChar(myAttendees);

            foreach (var item in insList)
            {
                item.Clients = myAttendees;
                item.ClientsBudget = myAttendees;
                item.Save();
            }
            #endregion
        }
        //---------------------------------------------------------

        public static void AttentToCustomer(string ClientID, string SummaryID)
        {
            object newCustomerID = "";

            #region attent to customer
            List<Entities.Attendees> dataList = Bll.Attendees.Select(Convert.ToInt32(ClientID), filter: "");
            foreach (var item in dataList)
            {
                List<Entities.Customers> newList = new List<Entities.Customers>  {
                    new Entities.Customers  {
                        AgencyID = Convert.ToInt32(item._AgencyID),
                        Name = item.Fullname,
                        ShortContent = item.Budget
                    }
                };
                foreach (var cus in newList)
                {
                    newCustomerID = cus.Save();
                }
            }
            #endregion

            #region update summary
            List<Entities.InspectionSummaries> sumList = Bll.InspectionSummaries.Select(Convert.ToInt32(SummaryID), filter: "");
            foreach (var item in sumList)
            {
                item.CustomerID = Convert.ToInt32(newCustomerID);
                item.Save();
            }
            #endregion
        }
        //---------------------------------------------------------

        public static string PropertyStatuBadge(string Statu)
        {
            switch (Statu)
            {
                case "available":
                    return "<span class='label label-lg label-light-success label-inline'>" + Statu + "</span>";
                case "reserved":
                    return "<span class='label label-lg label-light-warning label-inline'>" + Statu + "</span>";
                case "unavailable":
                    return "<span class='label label-lg label-light-danger label-inline'>" + Statu + "</span>";
                default: //"sold":
                    return "<span class='label label-lg label-light-danger label-inline'>" + Statu + "</span>";
            }
        }
        //---------------------------------------------------------

        public static string AgencyStatuBadge(string Statu)
        {
            switch (Statu)
            {
                case "Inprocess":
                    return "<span class='label label-lg label-light-warning label-inline'>" + Statu + "</span>";
                case "Active":
                    return "<span class='label label-lg label-light-success label-inline'>" + Statu + "</span>";
                default: //"Expired":
                    return "<span class='label label-lg label-light-danger label-inline'>" + Statu + "</span>";
            }
        }
        //---------------------------------------------------------

        #endregion

    }
}
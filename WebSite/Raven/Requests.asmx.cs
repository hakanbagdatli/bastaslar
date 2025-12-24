using Tools;
using System;
using Utility;
using Entities;
using System.IO;
using System.Web;
using System.Linq;
using Newtonsoft.Json;
using ExcelDataReader;
using Xceed.Words.NET;
using System.Collections;
using System.Web.Services;
using Newtonsoft.Json.Linq;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Collections.Generic;

namespace WebSite.Raven
{
    [System.Web.Script.Services.ScriptService]
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

    public class Requests : System.Web.Services.WebService
    {
        public string DateNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");

        #region selected chagens

        [WebMethod]
        public List<ListItem> GetPlans(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.GeneralPlans> dataList = Bll.GeneralPlans.Select(0, filter: " AND CatID=" + value + " AND Approved=1", sorting: " Sorting ASC, id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.Title.ToString()
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- projeye ait planları getir

        [WebMethod]
        public List<ListItem> GetListPrice(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.GeneralPlans> dataList = Bll.GeneralPlans.Select(0, filter: " AND id=" + value + " AND Approved=1", sorting: " Sorting ASC, id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.PropertyPrice.ToString(),
                    Text = item.PropertyPrice.ToString()
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- projeye ait planları getir

        [WebMethod]
        public List<ListItem> GetCustomers(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.Customers> dataList = Bll.Customers.Select(0, filter: " AND AgencyID=" + value + " AND Approved=1", sorting: " id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.id + " - " + item.Name + " " + item.Surname
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- acentaya ait müşterileri getir

        [WebMethod]
        public List<ListItem> GetAttendees(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.Attendees> dataList = Bll.Attendees.Select(0, filter: " AND InspectionNumber='" + value + "'", sorting: " id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.Fullname
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- inspection ait katılımcıları getir

        [WebMethod]
        public List<ListItem> GetBudget(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.Attendees> dataList = Bll.Attendees.Select(0, filter: " AND id='" + value + "'", sorting: " id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.Budget,
                    Text = item.Budget
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- katılımcıya ait budget getir

        [WebMethod]
        public List<ListItem> GetModels(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.zDefineDetails> dataList = Entities.StaticList.Defines.Where(x => (x.DefineID == Convert.ToInt32(value))).OrderBy(o => o.Title).ToList();
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.Title.ToString()
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- markaya ait modelleri getir

        [WebMethod]
        public List<ListItem> GetSaleExecutiveAgency(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.Agencies> dataList = Bll.Agencies.Select(0, filter: " AND RelevantID=" + value + " AND Approved=1", sorting: " Title ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.Title
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- acentaya ait müşterileri getir

        [WebMethod]
        public List<ListItem> GetDailyQuestions(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.zDefineDetails> dataList = Entities.StaticList.Defines.Where(x => (x.CatID == 6) && (x.DefineID == Convert.ToInt32(value))).ToList();
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.id.ToString(),
                    Text = item.Title
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- günlük raporlara ait soruları getir

        [WebMethod]
        public List<ListItem> GetDailyQuestionsAnswer(object value)
        {
            List<ListItem> returninglist = new List<ListItem>();
            List<Entities.DailyReports> dataList = Bll.DailyReports.Select(0, filter: " AND id=" + value.ToString() + " AND Approved=1", sorting: " id ASC");
            //------------------------------------------
            foreach (var item in dataList)
            {
                returninglist.Add(new ListItem
                {
                    Value = item.Questions.ToString(),
                    Text = item.Answers.ToString()
                });
            }
            return returninglist;
        }
        //--------------------------------------------------------- günlük raporlara ait soruları getir

        #endregion

        #region langugages

        [WebMethod]
        public void SetLanguage(object value) { 
            Feature.ActiveLanguage = value.ToString();
            Handler.SetLanguage();
        }
        //---------------------------------------------------------

        [WebMethod]
        public void SetCRMLanguage(object value)
        {
            Feature.CRMLanguage = value.ToString();
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
            {
                RavenCookies.Values["RavenLang"] = value.ToString();
                RavenCookies.Expires = DateTime.Now.AddDays(10);
                HttpContext.Current.Response.Cookies.Add(RavenCookies);
            }
        }
        //---------------------------------------------------------

        [WebMethod]
        public void SetPartnerLang(object value)
        {
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
            {
                RavenCookies.Values["RavenLang"] = value.ToString();
                RavenCookies.Expires = DateTime.Now.AddDays(10);
                HttpContext.Current.Response.Cookies.Add(RavenCookies);
            }
        }
        //---------------------------------------------------------

        [WebMethod]
        public string GetPartnerLang() 
        {
            string Language = "EN";
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
            {
                Language = StaticList.LanguageCodes.
                    Where(x => x.id == Convert.ToInt32(RavenCookies.Values["RavenLang"])).
                    FirstOrDefault().Code.ToUpper();
            }
            //---------------------------------------------------------
            return Language;
        }
        //---------------------------------------------------------

        #endregion

        #region common

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string Login(object value)
        {
            try
            {
                var dataString = JsonConvert.SerializeObject(value).Replace("[", "").Replace("]", "");
                Entities.Items.Login data = JsonConvert.DeserializeObject<Entities.Items.Login>(dataString);
                //---------------------------------------------------------
                if (value != null)
                {
                    string TokenID = "";
                    Dictionary<string, object> _dic = new Dictionary<string, object>();
                    _dic.Add("email", data.Email);
                    _dic.Add("password", StringCipher.MD5Encrypt(data.Password));
                    string whereClause = " AND Email=@email AND Password=@password";
                    //---------------------------------------------------------
                    List<Entities.zUsers> dlist = Bll.zUsers.Select(0, whereClause, sorting: "", _parmsVals: _dic);
                    //---------------------------------------------------------
                    if (dlist.Count > 0)
                    {
                        foreach (var items in dlist)
                        {
                            if (Convert.ToBoolean(items.Approved))
                            {
                                TokenID = StringCipher.Encrypt(items.id + "~" + items.Statu + "~" + items.Email + "~" + data.Password + "~" + data.DeviceRegistirationID + "~" + data.DeviceType);
                                HttpCookie RavenCookies = new HttpCookie("RavenData");
                                RavenCookies.Values["RavenID"] = TokenID;
                                RavenCookies.Values["RavenLang"] = items.Language.ToString();
                                RavenCookies.Expires = DateTime.Now.AddDays(10);
                                HttpContext.Current.Response.Cookies.Add(RavenCookies);
                                Developer.WriteLog(1, Developer.LogDescription(1), dataString.ToString(), items.id);
                            }
                            else
                                return Function.ResultMessage("", 0, 0, 0, false, "This account is suspended and cannot be used.");
                        }
                    }
                    //---------------------------------------------------------
                    if (!String.IsNullOrEmpty(TokenID))
                        return Function.ResultMessage(new JObject(new JProperty("TokenID", TokenID)), 1, 0, 0, true, "Login successful.");
                    else
                    {
                        Developer.WriteLog(101, "Hatalı kullanıcı girişi", dataString.ToString(), 0);
                        return Function.ResultMessage("", 0, 0, 0, false, "Kullanıcı adı veya şifre hatalı.");
                    }
                    //---------------------------------------------------------
                }
                else
                    return Function.ResultMessage("", 0, 0, 0, false, "Please check your parameters. Body cannot be sent empty.");
            }
            catch (Exception ex) { return Function.ResultMessage("", 0, 0, 0, false, ex.Message.ToString()); }
        }
        //--------------------------------------------------------- kullanıcı girişi

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string Connect(object value)
        {
            try
            {
                bool isInsert = false;
                object returnValue = "0"; string message = "Please log in as a user.";
                var dataString = JsonConvert.SerializeObject(value);
                dataString = Helper.DeleteFirstChar(Helper.DeleteLastChar(dataString));
                Entities.Items.RootData data = JsonConvert.DeserializeObject<Entities.Items.RootData>(dataString);
                //---------------------------------------------------------
                string TokenID = "";
                HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
                if (RavenCookies != null)
                    TokenID = RavenCookies.Values["RavenID"];
                //---------------------------------------------------------
                if (!String.IsNullOrEmpty(TokenID))
                {
                    string RecordID = "", Title = "", SeoURL = "", Property3ID = "", PropertyStatus = "", PNRCode = "", Clients = "", ClientsBudget = "", CustomerID = "", AgencyID = "", ExcelFile = "";

                    foreach (var item in data.properties)
                    {
                        switch (item.type)
                        {
                            case "password":
                                if (!String.IsNullOrEmpty(item.value))
                                    item.value = StringCipher.MD5Encrypt(item.value);
                                else
                                    data.properties.Remove(item);
                                break;
                            case "file":
                                if (item.value == "false")
                                    data.properties.Remove(item);
                                break;
                        }

                        #region for categories and records
                        if (data.id == 4 || data.id == 9 || data.id == 11 || data.id == 13)
                        {
                            //---------------------------------------------------------
                            if (item.name == "id")
                                RecordID = item.value;
                            //---------------------------------------------------------
                            if (item.name == "Title")
                            {
                                if (data.type == 3)
                                    item.value = Helper.FirstLetterUppercase(item.value);
                                Title = item.value;
                            }
                            //---------------------------------------------------------
                            if (item.name == "PageTypeID" && item.value == "0")
                                return Function.ResultMessage("", 0, 0, 0, false, "Lütfen sayfa türünü seçiniz.");
                            //---------------------------------------------------------
                            if (item.name == "AdditionalTitle" && String.IsNullOrEmpty(item.value))
                                item.value = Title;
                            //---------------------------------------------------------
                            if (item.name == "MetaTitle" && String.IsNullOrEmpty(item.value))
                                item.value = Title;
                            //---------------------------------------------------------
                            if (item.name == "Description" && String.IsNullOrEmpty(item.value))
                                item.value = Title;
                            //---------------------------------------------------------
                            if (item.name == "Keywords" && String.IsNullOrEmpty(item.value))
                                item.value = Title;
                            //---------------------------------------------------------
                            if (item.name == "RecordDate" && String.IsNullOrEmpty(item.value))
                                item.value = DateTime.Now.ToString("dd.MM.yyyy");

                            #region check url
                            if (item.name == "MetaUrl")
                            {
                                if (String.IsNullOrEmpty(item.value))
                                    SeoURL = Function.SeoReplace(Title);
                                else
                                    SeoURL = Function.SeoReplace(item.value);
                                //---------------------------------------------------------
                                if (data.id == 4)
                                {
                                    if (StaticList.Categories.Where(x => (x.MetaUrl == SeoURL)).ToList().Count > 0)
                                    {
                                        if (RecordID == StaticList.Categories.Where(x => (x.MetaUrl == SeoURL)).FirstOrDefault().id.ToString())
                                            item.value = SeoURL;
                                        else
                                            return Function.ResultMessage("", 0, 0, 0, false, "Bu URL sistemde kayıtlı, lütfen uygun yeni bir URL girip tekrar deneyiniz.");
                                    }
                                    else
                                        item.value = SeoURL;
                                }
                                else if (data.id == 11)
                                {
                                    if (Bll.LangCategories.RowCount(" AND MetaUrl='" + SeoURL + "'", Entities.LangCategories.tableName) > 0)
                                    {
                                        if (RecordID == Bll.LangCategories.Select(0, " AND MetaUrl='" + SeoURL + "'")[0].id.ToString())
                                            item.value = SeoURL;
                                        else
                                            return Function.ResultMessage("", 0, 0, 0, false, "Bu URL sistemde kayıtlı, lütfen uygun yeni bir URL girip tekrar deneyiniz.");
                                    }
                                    else
                                        item.value = SeoURL;
                                }
                                else if (data.id == 13)
                                {
                                    if (Bll.LangRecords.RowCount(" AND MetaUrl='" + SeoURL + "'", Entities.LangRecords.tableName) > 0)
                                    {
                                        if (RecordID == Bll.LangRecords.Select(0, " AND MetaUrl='" + SeoURL + "'")[0].id.ToString())
                                            item.value = SeoURL;
                                        else
                                            return Function.ResultMessage("", 0, 0, 0, false, "Bu URL sistemde kayıtlı, lütfen uygun yeni bir URL girip tekrar deneyiniz.");
                                    }
                                    else
                                        item.value = SeoURL;
                                }
                                else
                                {
                                    if (StaticList.Records.Where(x => (x.MetaUrl == SeoURL)).ToList().Count > 0)
                                    {
                                        if (RecordID == StaticList.Records.Where(x => (x.MetaUrl == SeoURL)).FirstOrDefault().id.ToString())
                                            item.value = SeoURL;
                                        else
                                            return Function.ResultMessage("", 0, 0, 0, false, "Bu URL sistemde kayıtlı, lütfen uygun yeni bir URL girip tekrar deneyiniz.");
                                    }
                                    else
                                        item.value = SeoURL;
                                }
                            }
                            #endregion
                        }
                        #endregion

                        #region for property 3d view

                        if (data.id == 27)
                        {
                            if (item.name == "Property3ID" && !String.IsNullOrEmpty(item.value))
                                Property3ID = item.value;
                            if (item.name == "PropertyStatus" && !String.IsNullOrEmpty(item.value))
                                PropertyStatus = item.value;
                        }

                        #endregion

                        #region for attendees

                        if (data.id == 32)
                        {
                            if (item.name == "PNRCode" && !String.IsNullOrEmpty(item.value))
                                PNRCode = item.value;
                            if (item.name == "Clients" && !String.IsNullOrEmpty(item.value))
                                Clients = item.value;
                            if (item.name == "ClientsBudget" && !String.IsNullOrEmpty(item.value))
                                ClientsBudget = item.value;
                        }

                        #endregion

                        #region for summaries

                        if (data.id == 29)
                        {
                            if (item.name == "CustomerID" && !String.IsNullOrEmpty(item.value))
                                CustomerID = item.value;
                        }

                        #endregion

                        #region for callbacks

                        if (data.id == 40)
                        {
                            if (item.name == "AgencyID" && !String.IsNullOrEmpty(item.value))
                                AgencyID = item.value;
                        }

                        #endregion

                        #region for leads
                        if (data.id == 41)
                        {
                            if (item.name == "ExcelList")
                                ExcelFile = item.value;
                        }
                        #endregion

                    }

                    if (!String.IsNullOrEmpty(ExcelFile))
                        NewExcelList(ExcelFile, Developer.UserToken(TokenID).UserID);
                    else
                    {
                        #region set user
                        if (data.type == 3)
                        {
                            isInsert = true;
                            data.properties.Add(new Entities.Items.Property { name = "CreatedUser", value = Developer.UserToken(TokenID).UserID.ToString() });
                            data.properties.Add(new Entities.Items.Property { name = "CreatedDate", value = DateNow });
                        }
                        else
                        {
                            data.properties.Add(new Entities.Items.Property { name = "UpdatedUser", value = Developer.UserToken(TokenID).UserID.ToString() });
                            data.properties.Add(new Entities.Items.Property { name = "UpdatedDate", value = DateNow });
                        }
                        #endregion

                        returnValue = Bll.Base.DirectSave(EntityTable(data.id), isInsert, data);

                        #region change 3DViewStatu
                        if (data.id == 27 && !String.IsNullOrEmpty(Property3ID) && !String.IsNullOrEmpty(PropertyStatus))
                            Function.Update3DViewStatu(Property3ID, PropertyStatus);
                        #endregion

                        #region update attendees
                        if (data.id == 32 && isInsert)
                            Function.UpdateClients(PNRCode, Clients, ClientsBudget);
                        #endregion

                        #region update callback count
                        if (data.id == 40 && isInsert)
                            Function.UpdateCallbackCount(AgencyID);
                        #endregion

                        #region update summaries
                        if (data.id == 29 && isInsert)
                            Function.AttentToCustomer(CustomerID, returnValue.ToString());
                        #endregion

                        #region clear static lists
                        StaticList.GlobalReWriteLink = "ClearIT";
                        //---------------------------------------------------------
                        StaticList.Settings = Bll.zSettings.Select(1, filter: "")[0];
                        Feature.ActiveLanguage = StaticList.Settings.DefaultLanguage.ToString();
                        StaticList.LanguageCodes = Bll.zLangCodes.Select(0, filter: " AND Approved=1");
                        StaticList.ActiveSite = StaticList.LanguageCodes.Where(x => x.id == Convert.ToInt32(Feature.ActiveLanguage)).ToList()[0];
                        StaticList.SiteLangConstants = Bll.LangFixed.Select(0, filter: "");
                        //---------------------------------------------------------
                        StaticList.Contact = Bll.GeneralContacts.Select(1, filter: "");
                        StaticList.PageTypes = Bll.zPageTypes.Select(0, filter: "");
                        StaticList.Defines = Bll.zDefineDetails.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id DESC");
                        StaticList.Categories = Bll.GeneralCategories.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
                        StaticList.Records = Bll.GeneralRecords.Select(0, filter: "", sorting: " Sorting ASC, id ASC");
                        #endregion

                        #region set message
                        if (Convert.ToInt32(returnValue) > 0)
                        {
                            if (isInsert)
                                message = "The record was created successfully.";
                            else
                                message = "The record has been updated successfully.";
                        }
                        else
                            if (isInsert)
                            message = "Failed to create record, please try again.";
                        else
                            message = "Failed to update record, please try again.";
                        #endregion

                        Developer.WriteLog(data.type, Developer.LogDescription(data.type), dataString.ToString(), Developer.UserToken(TokenID).UserID);
                        Entities.StaticList.GlobalReWriteLink = "ClearIT";
                    }

                    return Function.ResultMessage("", 0, 0, 0, true, message);
                }
                else
                    return Function.ResultMessage("", 0, 0, 0, false, message);
            }
            catch (Exception ex)
            {
                return Function.ResultMessage("", 0, 0, 0, false, ex.Message);
            }
        }
        //---------------------------------------------------------

        #endregion

        #region for files

        [WebMethod]
        public string SaveFile()
        {
            try
            {
                string filename = "false";
                //---------------------------------------------------------
                int Table = Convert.ToInt32(HttpContext.Current.Request.Form["Table"].ToString());
                string FileTitle = HttpContext.Current.Request.Form["Title"].ToString();
                string Path = SavingPath(HttpContext.Current.Request.Form["SavingPath"].ToString());
                int PageTypeID = Convert.ToInt32(HttpContext.Current.Request.Form["PageType"].ToString());
                int CatID = Convert.ToInt32(HttpContext.Current.Request.Form["CatID"].ToString());
                int RecordID = Convert.ToInt32(HttpContext.Current.Request.Form["RecordID"].ToString());
                bool canCrop = Convert.ToBoolean(HttpContext.Current.Request.Form["Crop"].ToString());
                //---------------------------------------------------------
                if (Table == 20)
                    FileTitle = Entities.StaticList.Settings.CompanyName + "-" + FileTitle;
                //---------------------------------------------------------
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                if (httpPostedFile != null)
                {
                    if (Convert.ToBoolean(Entities.StaticList.Settings.canCrop) == true && canCrop == true)
                    {
                        string thumbnailWidth = Function.CroppingDetail("ThumbnailWidth", PageTypeID, CatID, RecordID);
                        string imageWidth = Function.CroppingDetail("BigImageWidth", PageTypeID, CatID, RecordID);
                        //---------------------------------------------------------
                        filename = Uploads.ImageFile(httpPostedFile, Path, Convert.ToInt32(thumbnailWidth), Convert.ToInt32(imageWidth), FileTitle);
                    }
                    else
                        filename = Uploads.FileWithoutResizing(httpPostedFile, Path, FileTitle);
                }
                return filename;
            }
            catch (Exception ex) { return ex.Message; }
        }
        //---------------------------------------------------------

        [WebMethod]
        public string EditorSaveFile()
        {
            try
            {
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                if (httpPostedFile != null)
                    return Uploads.FileWithoutResizing(httpPostedFile, SavingPath("editor"), httpPostedFile.FileName.ToString());
                else
                    return "";
            }
            catch (Exception ex) { return ex.Message.ToString(); }
        }
        //---------------------------------------------------------

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string DeleteFile(object value)
        {
            try
            {
                var dataString = JsonConvert.SerializeObject(value).Replace("[", "").Replace("]", "");
                Entities.Items.FileDelete data = JsonConvert.DeserializeObject<Entities.Items.FileDelete>(dataString);
                //---------------------------------------------------------
                string imagePath = SavingPath(data.filepath);
                string message = "Resim";
                System.IO.File.Delete(HttpContext.Current.Server.MapPath(imagePath + data.filename));
                //---------------------------------------------------------
                if (data.filepath == "files")
                    message = "Dosya";
                if (data.filepath == "videos")
                    message = "Video";
                //---------------------------------------------------------
                return Function.ResultMessage("", 0, 0, 0, true, message + " başarıyla silindi.");
            }
            catch (Exception ex)
            {
                return Function.ResultMessage("", 0, 0, 0, false, ex.Message);
            }

        }
        //---------------------------------------------------------

        #endregion

        #region export-pdf

        [WebMethod]
        public string TableAsPNG()
        {
            try
            {
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFile"];
                if (httpPostedFile != null)
                    return Uploads.FileWithoutResizing(httpPostedFile, SavingPath("agencies"), httpPostedFile.FileName.ToString());
                else
                    return "";
            }
            catch (Exception ex) { return ex.Message.ToString(); }
        }
        //---------------------------------------------------------

        [WebMethod]
        public string CreatePDF(object value)
        {
            string FilePath = "false";
            List<Entities.DailyReports> dList = Bll.DailyReports.Select(Convert.ToInt32(value), filter: "");
            if (dList.Count > 0)
            {
                foreach (var item in dList)
                {
                    ArrayList QuestionList = Helper.SplitedList(",", item.Questions);
                    ArrayList AnswerList = Helper.SplitedList(",", item.Answers);
                    string TempPath = HttpContext.Current.Server.MapPath(SavingPath("reports") + item._ReportTemp);

                    //---------------------------------------------
                    // DocX ile yeni belge oluştur ve şablon dosyasını yükle
                    using (var doc = DocX.Load(TempPath))
                    {
                        for (int i = 0; i < QuestionList.Count; i++)
                        {
                            string QuestionID = "{Question" + QuestionList[i].ToString() + "}";
                            string AnswerValue = AnswerList[i].ToString();
                            // Şablondaki metni verilen yanıtla değiştir
                            doc.ReplaceText(QuestionID, AnswerValue);
                        }
                        doc.ReplaceText("{TodayDate}", Helper.SiteDateFormat(item.CreatedDate.ToString()));
                        doc.ReplaceText("{Username}", item._Username);
                        //---------------------------------------------
                        string ReportSavedName = Guid.NewGuid().ToString() + ".docx";
                        string FullPath = HttpContext.Current.Server.MapPath(SavingPath("reports")) + ReportSavedName;

                        // Dosyayı kaydet
                        doc.SaveAs(FullPath);
                        // PDF'e dönüştürme işlemi gerekiyorsa, DocX dosyasını dönüştürmek için başka bir kütüphane kullanılabilir.
                        // Örneğin, PDF conversion library veya 3. parti araçlar ile PDF'e çevirme yapılabilir.
                        //---------------------------------------------
                        item.Filename = ReportSavedName;
                        item.Save();
                        FilePath = "/uploads/reports/" + ReportSavedName;
                    }
                }
            }
            return FilePath;
        }
        //---------------------------------------------------------

        [WebMethod]
        public string ExportProject(object value)
        {
            try
            {
                var dataString = JsonConvert.SerializeObject(value).Replace("[", "").Replace("]", "");
                Entities.Items.PdfExport data = JsonConvert.DeserializeObject<Entities.Items.PdfExport>(dataString);
                //---------------------------------------------------------
                Entities.zUsers UserData = Developer.LoggedPartner();
                if (UserData != null)
                {
                    if (StaticList.Records.Where(x => (x.id == data.RecordID) && (x.Approved == 1)).ToList().Count > 0)
                    {
                        foreach (var item in Bll.GeneralRecords.Select(data.RecordID, filter: "", sorting: "", lang: Handler.GetPartnerLang()))
                        {
                            string agencyFolder = Feature.AgencyFolder.Replace("~", "");
                            string imageFolder = Feature.ImageFolder.Replace("~", "");
                            Entities.Agencies AgencyData = Bll.Agencies.Select(0, filter: " AND id=" + UserData.CatID + " AND Approved=1").FirstOrDefault();
                            List<Entities.GeneralPhotos> PhotosData = Bll.GeneralPhotos.Select(0, filter: " AND CatID=" + item.id + " AND Approved=1");
                            List<Entities.GeneralPlans> planList = Bll.GeneralPlans.Select(0, filter: " AND CatID=" + item.id + " AND Approved=1", sorting: " Sorting ASC, id ASC");
                            //---------------------------------------------------------
                            data.AgencyLogo = Feature.AgencyFolder + AgencyData.CompanyLogo;
                            data.AgencyName = AgencyData.Title;
                            data.BrokerName = UserData.Name + " " + UserData.Surname;
                            data.BrokerPhone = UserData.Phone;
                            data.ProjectName = Handler.SetPartnerText(item.Title, item._Title);
                            data.StartDate = Helper.DatewithCulture(item.PropertyStartDate, data.Language);
                            data.EndDate = Helper.DatewithCulture(item.PropertyEndDate, data.Language);
                            data.ShortContent = Handler.SetPartnerText(item.ShortContent, item._ShortContent);
                            data.OutdoorPhoto1 = imageFolder + PhotosData.Where(x => x.Outdoor == 1).First().Image;
                            data.OutdoorPhoto2 = imageFolder + PhotosData.Where(x => x.Outdoor == 1).Skip(1).First().Image;
                            data.OutdoorPhoto3 = imageFolder + PhotosData.Where(x => x.Outdoor == 1).Skip(2).First().Image;
                            data.OutdoorPhoto4 = imageFolder + PhotosData.Where(x => x.Outdoor == 1).Skip(3).First().Image;
                            data.IndoorPhoto1 = imageFolder + PhotosData.Where(x => x.Indoor == 1).First().Image;
                            data.IndoorPhoto2 = imageFolder + PhotosData.Where(x => x.Indoor == 1).Skip(1).First().Image;
                            data.IndoorPhoto3 = imageFolder + PhotosData.Where(x => x.Indoor == 1).Skip(2).First().Image;
                            data.IndoorPhoto4 = imageFolder + PhotosData.Where(x => x.Indoor == 1).Skip(3).First().Image;
                            data.PaymentPlans = Handler.SetPartnerText(item.PropertyPaymentPlan, item._PropertyPaymentPlan);
                            data.Properties = Feature.AgencyFolder + data.Properties;
                            data.AvailabilityPhoto = Feature.AgencyFolder + data.AvailabilityPhoto;
                        }
                        string ExportName = Handler.ProjectPdf(data);
                        return Function.ResultMessage("", 0, 0, 0, true, "/uploads/agencies/" + ExportName);
                    }
                    else
                        return Function.ResultMessage("", 0, 0, 0, false, "Proje bulunamadı!");
                }
                //---------------------------------------------------------
                else
                    return Function.ResultMessage("", 0, 0, 0, false, "Lütfen kullanıcı girişi yapınız.");
            }
            catch (Exception ex) { return Function.ResultMessage("", 0, 0, 0, false, ex.Message.ToString()); }

        }
        //---------------------------------------------------------

        #endregion

        #region get functions

        protected string EntityTable(int id)
        {
            switch (id)
            {
                case 1:
                    return Entities.Adwords.tableName;
                case 2:
                    return Entities.FormCategories.tableName;
                case 3:
                    return Entities.FormIncomings.tableName;
                case 4:
                    return Entities.GeneralCategories.tableName;
                case 5:
                    return Entities.GeneralContacts.tableName;
                case 6:
                    return Entities.GeneralFeatures.tableName;
                case 7:
                    return Entities.GeneralFiles.tableName;
                case 8:
                    return Entities.GeneralPhotos.tableName;
                case 9:
                    return Entities.GeneralRecords.tableName;
                case 10:
                    return Entities.GeneralVideos.tableName;
                case 11:
                    return Entities.LangCategories.tableName;
                case 12:
                    return Entities.LangFixed.tableName;
                case 13:
                    return Entities.LangRecords.tableName;
                case 14:
                    return Entities.SiteSliders.tableName;
                case 15:
                    return Entities.zLangCodes.tableName;
                case 16:
                    return Entities.zMenus.tableName;
                case 17:
                    return Entities.zPageTypes.tableName;
                case 18:
                    return Entities.zPhotoSettings.tableName;
                case 19:
                    return Entities.zSearchEngineIndex.tableName;
                case 20:
                    return Entities.zSettings.tableName;
                case 21:
                    return Entities.zSortingType.tableName;
                case 22:
                    return Entities.zUsers.tableName;
                case 23:
                    return Entities.zUsersStatu.tableName;
                case 24:
                    return Entities.zDefines.tableName;
                case 25:
                    return Entities.zDefineDetails.tableName;
                case 27:
                    return Entities.GeneralPlans.tableName;
                case 28:
                    return Entities.Agencies.tableName;
                case 29:
                    return Entities.InspectionSummaries.tableName;
                case 30:
                    return Entities.Customers.tableName;
                case 31:
                    return Entities.CustomerFiles.tableName;
                case 32:
                    return Entities.Inspections.tableName;
                case 33:
                    return Entities.Reservations.tableName;
                case 34:
                    return Entities.ReservationFiles.tableName;
                case 35:
                    return Entities.ReservationFeatures.tableName;
                case 36:
                    return Entities.SaleTransactions.tableName;
                case 37:
                    return Entities.Assignments.tableName;
                case 38:
                    return Entities.Attendees.tableName;
                case 39:
                    return Entities.DailyReports.tableName;
                case 40:
                    return Entities.AgencyCallbacks.tableName;
                case 41:
                    return Entities.InspectionLeads.tableName;
                case 42:
                    return Entities.ProjectStatus.tableName;
                default:
                    return "";
            }
        }
        //--------------------------------------------------------- get tablename from IEntity.tableName

        protected string SavingPath(string path)
        {
            switch (path)
            {
                case "files":
                    return Utility.Feature.FileFolder;
                case "videos":
                    return Utility.Feature.VideoFolder;
                case "agencies":
                    return Utility.Feature.AgencyFolder;
                case "reports":
                    return Utility.Feature.ReportFileFolder;
                case "editor":
                    return Utility.Feature.EditorFolder;
                default:
                    return Utility.Feature.ImageFolder;
            }
        }
        //--------------------------------------------------------- get saving path

        protected string NewExcelList(string UploadedFileName, int UserID)
        {
            try
            {
                int counter = 0;
                FileStream stream = File.Open(HttpContext.Current.Server.MapPath(Feature.FileFolder + UploadedFileName), FileMode.Open, FileAccess.Read);
                //---------------------------------------------------------
                IExcelDataReader excelReader;
                if (Path.GetExtension(UploadedFileName).ToUpper() == ".XLS")
                    excelReader = ExcelReaderFactory.CreateBinaryReader(stream); //Reading from a binary Excel file ('97-2003 format; *.xls)
                else
                    excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream); //Reading from a OpenXml Excel file (2007 format; *.xlsx)
                //---------------------------------------------------------
                while (excelReader.Read())
                {
                    counter++;
                    if (counter > 1) //ilk satır başlık olduğu için 2.satırdan okumaya başlıyorum.
                    {
                        List<Entities.InspectionLeads> dataList = new List<Entities.InspectionLeads>  {
                            new Entities.InspectionLeads  {
                                    LeadsDate = Helper.ShortDateFormat(ColumnData(excelReader, 1, "date")),
                                    Name = ColumnData(excelReader, 2),
                                    Surname = ColumnData(excelReader, 3),
                                    Phone = ColumnData(excelReader, 4),
                                    Email = ColumnData(excelReader, 5),
                                    Channel = ColumnData(excelReader, 6),
                                    AdvInformation = ColumnData(excelReader, 7),
                                    Call = ColumnData(excelReader, 8),
                                    Occupation = ColumnData(excelReader, 9),
                                    Age = ColumnData(excelReader, 10),
                                    Country = ColumnData(excelReader, 11),
                                    City = ColumnData(excelReader, 12),
                                    Budget = ColumnData(excelReader, 13),
                                    InterestedProperty = ColumnData(excelReader, 14),
                                    Message = ColumnData(excelReader, 15),
                                    Notes = ColumnData(excelReader, 16),
                                    isInterested = ColumnData(excelReader, 17),
                                    Result = ColumnData(excelReader, 18),
                                }
                            };
                        foreach (var item in dataList)
                        {
                            item.CreatedDate = DateTime.Now;
                            item.CreatedUser = UserID;
                            item.Save();
                        }
                    }
                }
                excelReader.Close();
                return "true";
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }
        //--------------------------------------------------------- excel listesini yükle

        protected string ColumnData(IExcelDataReader reader, int IndexCount, string type = "")
        {
            try
            {
                switch (type)
                {
                    case "int":
                        return reader.GetInt32(IndexCount).ToString();
                    case "double":
                        return reader.GetDouble(IndexCount).ToString();
                    case "date":
                        return reader.GetDateTime(IndexCount).ToString();
                    case "bool":
                        string isInterest = reader.GetString(IndexCount).ToString();
                        if (isInterest.ToLower().Contains("not"))
                            return "0";
                        else
                            return "1";
                    default:
                        return reader.GetString(IndexCount);
                }
            }
            catch
            {
                return reader.GetString(IndexCount);
            }
        }
        //--------------------------------------------------------- excel column içeriği

        #endregion
    }
}